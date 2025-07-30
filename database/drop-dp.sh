#!/bin/bash

# ATRIBUA PERMISÃO AO ARQUIVO: chmod +x drop-db.sh
# EXECUTE NO BASH: ./drop-db.sh

# Nome do container e banco
CONTAINER_NAME="creditos-postgres"
DB_NAME="creditos_db"
DB_USER="creditos_user"

echo "🔍 Verificando se o container $CONTAINER_NAME está em execução..."
if ! docker ps | grep -q "$CONTAINER_NAME"; then
  echo "❌ Container $CONTAINER_NAME não está em execução."
  exit 1
fi

echo "✅ Container encontrado. Acessando banco de dados..."

# Finaliza conexões antes de dropar (evita erro de "database is being accessed by other users")
echo "🔒 Encerrando conexões ativas com o banco $DB_NAME..."
docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" <<EOF
DO \$\$
DECLARE
    r RECORD;
BEGIN
    FOR r IN (SELECT pid FROM pg_stat_activity WHERE datname = '$DB_NAME' AND pid <> pg_backend_pid()) LOOP
        EXECUTE 'SELECT pg_terminate_backend(' || r.pid || ')';
    END LOOP;
END
\$\$;
EOF

# Dropar as tabelas e sequências explicitamente (já que não é possível dropar o banco estando conectado nele)
echo "🗑️  Apagando tabela 'credito' (caso exista)..."
docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "DROP TABLE IF EXISTS credito CASCADE;"

echo "✅ Tabela apagada com sucesso."

# Confirmar estado final
echo "📋 Verificando novamente o conteúdo do banco:"
docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "\dt"

echo "✅ Banco $DB_NAME limpo com sucesso!"
