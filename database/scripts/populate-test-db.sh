#!/bin/bash

set -e

# Carrega variáveis do .env com segurança
if [ -f .env ]; then
  set -o allexport
  source .env
  set +o allexport
fi

CONTAINER_NAME="creditos-postgres-test"
LOCAL_SQL_FILE="${INIT_TEST_SQL:-./database/init-test.sql}"
REMOTE_SQL_FILE="/tmp/init-test.sql"

# Verifica se o script SQL existe localmente
if [ ! -f "$LOCAL_SQL_FILE" ]; then
  echo "❌ Arquivo $LOCAL_SQL_FILE não encontrado!"
  exit 1
fi

echo "⏳ Aguardando o container \"$CONTAINER_NAME\" ficar disponível..."
while [ "$(docker inspect -f '{{.State.Health.Status}}' $CONTAINER_NAME 2>/dev/null)" != "healthy" ]; do
  echo "🔄 Container ainda não está saudável. Aguardando..."
  sleep 2
done

echo "✅ Container está saudável. Verificando destino no container..."

# Verifica se existe um diretório com o mesmo nome no container
docker exec "$CONTAINER_NAME" bash -c "[ -d '$REMOTE_SQL_FILE' ] && rm -rf '$REMOTE_SQL_FILE'"

# Verifica se existe um arquivo com o mesmo nome no container
docker exec "$CONTAINER_NAME" bash -c "[ -f '$REMOTE_SQL_FILE' ] && rm -f '$REMOTE_SQL_FILE'"

echo "📄 Copiando o script para o container..."
docker cp "$LOCAL_SQL_FILE" "$CONTAINER_NAME:$REMOTE_SQL_FILE"

echo "🚀 Executando o script SQL..."
docker exec -i "$CONTAINER_NAME" psql -U "$POSTGRES_USER_TEST" -d "$POSTGRES_DB_TEST" -f "$REMOTE_SQL_FILE"

if [ $? -eq 0 ]; then
  echo "✅ Script SQL executado com sucesso no banco de testes!"
else
  echo "❌ Ocorreu um erro ao executar o script SQL."
fi
