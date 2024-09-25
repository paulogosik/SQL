-- Criando a DATABASE da G1 ===========================
CREATE DATABASE g1_paulomoita
USE g1_paulomoita


-- Criando as tabelas necessárias ===========================
CREATE TABLE PRODUTO(
	codigo_produto VARCHAR(10) NOT NULL,
	nome_produto VARCHAR(100) NOT NULL,
	preco DECIMAL(7,2)
)

CREATE TABLE LOG_PRODUTO(
	data_hora DATETIME NOT NULL,
	codigo_produto VARCHAR(10) NOT NULL,
	nome_produto VARCHAR(100) NOT NULL,
	acao VARCHAR(10) NOT NULL,
	preco DECIMAL(7,2) NOT NULL
)


-- Criando a trigger para salvar o log ===========================
CREATE TRIGGER salvar_log_produto
ON PRODUTO
FOR INSERT, UPDATE, DELETE
AS
BEGIN
	IF (SELECT COUNT(*) FROM INSERTED) = 1 AND (SELECT COUNT(*) FROM DELETED) = 1
		INSERT INTO LOG_PRODUTO(data_hora, codigo_produto, nome_produto, acao, preco)
		VALUES (GETDATE(), (SELECT codigo_produto FROM inserted), (SELECT nome_produto FROM inserted), 'Alteração', (SELECT preco FROM inserted));
	IF (SELECT COUNT(*) FROM INSERTED) = 1 AND (SELECT COUNT(*) FROM DELETED) = 0
		INSERT INTO LOG_PRODUTO(data_hora, codigo_produto, nome_produto, acao, preco)
		VALUES (GETDATE(), (SELECT codigo_produto FROM inserted), (SELECT nome_produto FROM inserted), 'Inserção', (SELECT preco FROM inserted));
	IF (SELECT COUNT(*) FROM INSERTED) = 0 AND (SELECT COUNT(*) FROM DELETED) = 1
		INSERT INTO LOG_PRODUTO(data_hora, codigo_produto, nome_produto, acao, preco)
		VALUES (GETDATE(), (SELECT codigo_produto FROM deleted), (SELECT nome_produto FROM deleted), 'Exclusão', (SELECT preco FROM deleted));
END


-- Criando as views da questão 2 e 3===========================
CREATE VIEW quantidade_operacoes
	("Código do Produto", "Nome do Produto", "Qtd. de Operações")
AS
	SELECT
		codigo_produto 'Código do Produto',
		nome_produto 'Nome do Produto',
		(SELECT COUNT(*) FROM LOG_PRODUTO WHERE LOG_PRODUTO.codigo_produto = PRODUTO.codigo_produto) AS 'Qtd. de Operações'
	FROM
		PRODUTO


CREATE VIEW relatorio_tipo_acao
	("Ação", "Qtd. de Operações")
AS
	SELECT
		acao,
		COUNT(*)
	FROM
		LOG_PRODUTO
	GROUP BY acao


CREATE VIEW relatorio_primeiro_ultimo
	("Código do Produto", "Nome do Produto", "Primeira Alteração", "Última Alteração")
AS
	SELECT
		codigo_produto,
		nome_produto,
		MIN(data_hora),
		MAX(data_hora)
	FROM
		LOG_PRODUTO
	GROUP BY codigo_produto, nome_produto


-- Criando a procedure da questão 3.a ===========================
CREATE PROCEDURE historico_periodo
	@data_inicial datetime,
	@data_final datetime
AS
BEGIN
	SELECT * FROM LOG_PRODUTO
	WHERE data_hora > @data_inicial AND data_hora < @data_final
END


-- Testando o trigger ===========================
INSERT INTO produto(codigo_produto, nome_produto, preco) VALUES ('PROD001', 'Camisa', 60.0)
INSERT INTO produto(codigo_produto, nome_produto, preco) VALUES ('PROD002', 'Sapato', 120.50)
INSERT INTO produto(codigo_produto, nome_produto, preco) VALUES ('PROD003', 'Bermuda', 80.0)

UPDATE produto SET preco = 65.00 WHERE codigo_produto = 'PROD001'
UPDATE produto SET preco = 55.00 WHERE codigo_produto = 'PROD001'

DELETE FROM produto WHERE codigo_produto = 'PROD003'

SELECT * FROM LOG_PRODUTO
SELECT * FROM PRODUTO

-- Teste questão 2 ===========================
SELECT * FROM quantidade_operacoes

-- Teste questão 3 ===========================
SELECT * FROM relatorio_tipo_acao
SELECT * FROM relatorio_primeiro_ultimo