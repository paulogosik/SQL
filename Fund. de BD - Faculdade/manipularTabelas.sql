-- Criar tabelas
    -- Exemplo:
        -- CREATE TABLE nome_tabela (
        --     nome_atributo1 tipo (tamanho) NOT NULL UNIQUE,
        --     nome_atributo2 tipo (tamanho),
        --     nome_atributo3 tipo (tamanho) DEFAULT valor_padrao,
        --     PRIMARY KEY (nome_campo)
        -- );

CREATE TABLE tb_cliente (
    codCli int IDENTITY (1, 1),
    nomeCli varchar(100) NOT NULL,
    emailCli varchar(100),
    cidadeCli varchar(50) NOT NULL DEFAULT 'Palmas',
    PRIMARY KEY (codCli)
)

CREATE TABLE tb_agencia (
    codAg int IDENTITY (1, 1),
    nomeAg varchar(100) NOT NULL,
    cidadeAg varchar(50) NOT NULL DEFAULT 'Palmas',
    PRIMARY KEY (codAg)
)

CREATE TABLE tb_conta (
    codConta int NOT NULL IDENTITY(1,1),
    codCli int NOT NULL ,
    codAg int NOT NULL ,
    saldo money,
    PRIMARY KEY (codConta),
    FOREIGN KEY (codCli) REFERENCES tb_cliente (codCli),
    FOREIGN KEY (codAg) REFERENCES tb_agencia (codAg)
)

CREATE TABLE tb_emprestimo (
    codEmp int NOT NULL IDENTITY(1,1),
    codCli int NOT NULL ,
    codAg int NOT NULL ,
    valor money NOT NULL DEFAULT 0,
    taxa float,
    qtMeses int,
    saldo money,
    PRIMARY KEY (codEmp),
    FOREIGN KEY (codCli) REFERENCES tb_cliente (codCli),
    FOREIGN KEY (codAg) REFERENCES tb_agencia (codAg)
)

-- DDL – ALTER TABLE
    -- Usado para alterar a definição de uma tabela
    -- Permite alterar: atributos, restrições definidas, integridade referencial etc.
    -- Sintaxe para alterar atributo:
    -- ALTER TABLE nome_tabela tipo_alteracao nome_atributo definicao_atributo

ALTER TABLE tb_agencia ADD emailAg varchar(50) NOT NULL
ALTER TABLE tb_agencia ADD CONSTRAINT mailDef DEFAULT 'sem mail' FOR emailAg
ALTER TABLE tb_agencia ALTER COLUMN emailAg varchar (100)
ALTER TABLE tb_agencia DROP CONSTRAINT mailDef
ALTER TABLE tb_agencia DROP COLUMN emailAg
ALTER TABLE tb_emprestimo ADD codConta int
ALTER TABLE tb_emprestimo ADD FOREIGN KEY (codConta) REFERENCES tb_conta(codConta)
ALTER TABLE tb_cliente ADD codCli int
ALTER TABLE tb_cliente ADD CONSTRAINT pk_cli PRIMARY KEY (codCli)

-- DDL – DROP TABLE
    -- Usado para excluir uma tabela existente
DROP TABLE tb_cliente