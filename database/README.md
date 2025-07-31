# 🗃️ Scripts de Banco de Dados – Projeto Consulta de Créditos ISSQN

Este diretório contém os scripts de criação e povoamento do banco de dados, utilizados tanto no ambiente de **desenvolvimento** quanto de **testes automatizados**.

---

## 📦 Arquivos

| Arquivo                | Descrição                                                                          |
|------------------------|--------------------------------------------------------------------------------------|
| `init.sql`             | Script SQL idempotente que cria a tabela `credito`, índices e dados de exemplo.     |
| `populate-test-db.sh`  | Script bash para povoar o banco de dados de testes via Docker container.            |
| `drop-db.sh`           | Script para dropar o banco de dados local (PostgreSQL). Requer permissão de execução.|

---

## 🚀 Fluxo de Uso

### 1. 🔽 Derrubar os containers (limpeza total)

```bash
docker-compose down -v
```

### 2. 📜 Subir os containers com build completo (modo full-stack)

```bash
docker-compose --profile full-stack up --build -d
```
Ou apenas subir:

```bash
docker-compose up -d
```

### 3. 📋 Acompanhar os logs

```bash
docker-compose logs -f
```

---

## 🧪 Testes Automatizados

### 4. 🧼 Rodar os testes unitários

```bash
mvn clean test
```

### 5. 📊 Gerar relatório de cobertura (Jacoco)

```bash
mvn clean test jacoco:report
```

---

## 🧪 Banco de Testes

### 6. ✅ Atribuir permissão de execução ao script

```bash
chmod +x populate-test-db.sh
```

### 7. ▶️ Executar script de povoamento do banco de testes

```bash
./populate-test-db.sh
```

### 8. 🔍 Acessar o banco de dados de testes via Docker

```bash
docker exec -it creditos-postgres-test psql -U creditos_user -d creditos_db_test
```

---

## ⚠️ Drop do Banco (caso necessário)

### 9. ✅ Atribuir permissão ao script

```bash
chmod +x drop-db.sh
```

### 🔥 Executar script de exclusão do banco

```bash
./drop-db.sh
```

---

## ℹ️ Observações

- O script `init.sql` é idempotente, ou seja, pode ser executado múltiplas vezes sem causar conflitos.
- O banco de testes é iniciado no container `creditos-postgres-test` e escuta na porta `5433`.
- As variáveis de ambiente estão definidas no arquivo `.env`.
