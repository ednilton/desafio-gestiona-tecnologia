-- =======================================================
-- Sistema de Consulta de Créditos ISSQN - Init SQL
-- Arquivo idempotente para inicialização via Docker
-- Autor: Ednilton Rauh
-- =======================================================

-- 1. Criar usuário se não existir
DO $$
BEGIN
   IF NOT EXISTS (
       SELECT FROM pg_catalog.pg_roles WHERE rolname = 'creditos_user'
   ) THEN
       CREATE USER creditos_user WITH PASSWORD 'creditos_pass';
END IF;
END
$$;

-- 2. Garantir permissões sobre o banco
GRANT ALL PRIVILEGES ON DATABASE creditos_db TO creditos_user;

-- 3. Criar tabela 'credito' se não existir
CREATE TABLE IF NOT EXISTS credito (
                                       id BIGSERIAL PRIMARY KEY,
                                       numero_credito     VARCHAR(50)  NOT NULL,
    numero_nfse        VARCHAR(50)  NOT NULL,
    data_constituicao  DATE         NOT NULL,
    valor_issqn        DECIMAL(15,2) NOT NULL,
    tipo_credito       VARCHAR(50)  NOT NULL,
    simples_nacional   BOOLEAN      NOT NULL,
    aliquota           DECIMAL(5,2) NOT NULL,
    valor_faturado     DECIMAL(15,2) NOT NULL,
    valor_deducao      DECIMAL(15,2) NOT NULL,
    base_calculo       DECIMAL(15,2) NOT NULL
    );

-- 4. Criar índices se não existirem
CREATE INDEX IF NOT EXISTS idx_credito_numero_nfse     ON credito(numero_nfse);
CREATE INDEX IF NOT EXISTS idx_credito_numero_credito  ON credito(numero_credito);

-- 5. Inserir dados se a tabela estiver vazia
DO $$
BEGIN
   IF NOT EXISTS (SELECT 1 FROM credito) THEN
      INSERT INTO credito (
         numero_credito, numero_nfse, data_constituicao, valor_issqn,
         tipo_credito, simples_nacional, aliquota,
         valor_faturado, valor_deducao, base_calculo
      )
      VALUES
         ('123456', '7891011', '2024-02-25', 1500.75, 'ISSQN', true, 5.0, 30000.00, 5000.00, 25000.00),
         ('789012', '7891011', '2024-02-26', 1200.50, 'ISSQN', false, 4.5, 25000.00, 4000.00, 21000.00),
         ('654321', '1122334', '2024-01-15', 800.50, 'Outros', true, 3.5, 20000.00, 3000.00, 17000.00);
END IF;
END
$$;

-- 6. Garantir permissões para o usuário 'creditos_user'
GRANT ALL PRIVILEGES ON TABLE credito TO creditos_user;

-- Permissões adicionais sobre todas as tabelas do schema 'public'
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO creditos_user;

-- Permissões corretas para schema e sequences
GRANT USAGE ON SCHEMA public TO creditos_user;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO creditos_user;
