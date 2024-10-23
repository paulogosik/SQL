-- Dupla: Paulo Gosik M. Moita e Murillo Lessa

-- Criando a Database ====================
CREATE DATABASE aula_2310
USE aula_2310


-- Criando as tabelas necessárias ===========================
CREATE TABLE PRODUTO(
codigo_produto VARCHAR(10) NOT NULL,
nome_produto VARCHAR(100) NOT NULL,
preco INT
)

CREATE TABLE Logs (
IDTransac VARCHAR(10),
nome_tabela VARCHAR(10),
tipoOp VARCHAR(10),
    objeto VARCHAR(10) NULL,
    preco_antigo INT NULL,
    preco_novo INT NULL,
    LogDate DATETIME DEFAULT GETDATE()
);


-- Alimentando a tabela ==================
INSERT INTO produto(codigo_produto, nome_produto, preco) VALUES ('A', 'Camisa', 10);
INSERT INTO produto(codigo_produto, nome_produto, preco) VALUES ('B', 'Sapato',15);
INSERT INTO produto(codigo_produto, nome_produto, preco) VALUES ('D', 'Bermuda', 20);


-- Criando a procedure ===================
CREATE PROCEDURE Inserir_log

    @IDTransac VARCHAR(10),
@nome_tabela VARCHAR(10),
    @tipoOp VARCHAR(10),
    @objeto VARCHAR(10) = NULL,
    @preco_antigo INT = NULL,
    @preco_novo INT = NULL
AS
BEGIN
    INSERT INTO Logs (IDTransac,nome_tabela, tipoOp, objeto, preco_antigo, preco_novo,LogDate)
    VALUES (@IDTransac,@nome_tabela,@tipoOp, @objeto, @preco_antigo, @preco_novo,GETDATE() );
END;


-- Inicio das Transactions =====================
-- Início da T3
BEGIN TRANSACTION T3;
EXEC Inserir_log @IDTransac = 'T3', @tipoOp = 'Start',@nome_tabela = 'Produto';

--T3 (Write)
DECLARE @preco_antigoB INT;
SELECT @preco_antigoB = preco FROM PRODUTO WHERE codigo_produto = 'B';

UPDATE PRODUTO
SET preco = 12
WHERE codigo_produto = 'B';

EXEC Inserir_log @IDTransac = 'T3', @tipoOp = 'Write', @objeto = 'B', @preco_antigo = @preco_antigoB, @preco_novo = 12,@nome_tabela = 'Produto';

-- Início da T2
BEGIN TRANSACTION T2;
EXEC Inserir_log @IDTransac = 'T2', @tipoOp = 'Start',@nome_tabela = 'Produto';;

-- T2 (Write)
DECLARE @preco_antigoB2 INT;
SELECT @preco_antigoB2 = preco FROM PRODUTO WHERE codigo_produto = 'B';

UPDATE PRODUTO
SET preco = 18
WHERE codigo_produto = 'B';

EXEC Inserir_log @IDTransac = 'T2', @tipoOp = 'Write', @objeto = 'B', @preco_antigo = @preco_antigoB2, @preco_novo = 18,@nome_tabela = 'Produto';

-- Início da T1
BEGIN TRANSACTION T1;
EXEC Inserir_log @IDTransac = 'T1', @tipoOp = 'Start',@nome_tabela = 'Produto';

--  T1 (Write)
DECLARE @preco_antigoD INT;
SELECT @preco_antigoD = preco FROM PRODUTO WHERE codigo_produto = 'D';

UPDATE PRODUTO
SET preco = 25
WHERE codigo_produto = 'D';

EXEC Inserir_log @IDTransac = 'T1', @tipoOp = 'Write', @objeto = 'D', @preco_antigo = @preco_antigoD, @preco_novo = 25,@nome_tabela = 'Produto';

-- Commit da T1
COMMIT TRANSACTION T1;
EXEC Inserir_log @IDTransac = 'T1', @tipoOp = 'Commit',@nome_tabela = 'Produto';

-- Continuando da T2 (Write)
DECLARE @preco_antigoD2 INT;
SELECT @preco_antigoD2 = preco FROM PRODUTO WHERE codigo_produto = 'D';

UPDATE PRODUTO
SET preco = 26
WHERE codigo_produto = 'D';

EXEC Inserir_log @IDTransac = 'T2', @tipoOp = 'Write', @objeto = 'D', @preco_antigo = @preco_antigoD2, @preco_novo = 26,@nome_tabela = 'Produto';

-- Commit da T2
COMMIT TRANSACTION T2;
EXEC Inserir_log @IDTransac = 'T2', @tipoOp = 'Commit',@nome_tabela = 'Produto';

-- Continuando a T3 (Write)
DECLARE @preco_antigoA INT;
SELECT @preco_antigoA = preco FROM PRODUTO WHERE codigo_produto = 'A';

UPDATE PRODUTO
SET preco = 19
WHERE codigo_produto = 'A';

EXEC Inserir_log @IDTransac = 'T3', @tipoOp = 'Write', @objeto = 'A', @preco_antigo = @preco_antigoA, @preco_novo = 19,@nome_tabela = 'Produto';

-- Commit da T3
COMMIT TRANSACTION T3;
EXEC Inserir_log @IDTransac = 'T3', @tipoOp = 'Commit',@nome_tabela = 'Produto';


-- Relatórios =======================
	-- Relatório 1:
CREATE VIEW logs_por_mes
	("Ano", "Mês", "Quantidade")
AS
	SELECT
		YEAR(LogDate),
		MONTH(LogDate), 
		COUNT(*) 
	FROM Logs 
	GROUP BY MONTH(LogDate), YEAR(LogDate)

	-- Relatório 2:
CREATE PROCEDURE relatorio_por_tabela
	@tabela_parametro VARCHAR(100)
AS
BEGIN
	SELECT * FROM Logs WHERE nome_tabela = @tabela_parametro
END

EXEC relatorio_por_tabela 'Produto'


	-- Relatório 3:
CREATE PROCEDURE relatorio_escrita_por_tabela
	@tabela_parametro VARCHAR(100),
	@acao VARCHAR(100)
AS
BEGIN
	SELECT * FROM Logs WHERE tipoOp = @acao AND nome_tabela = @tabela_parametro
END

	-- Relatório 4:
CREATE PROCEDURE relatorio_transacao
	@IDTransac VARCHAR(10)
AS
BEGIN
	SELECT * FROM Logs WHERE IDTransac = @IDTransac
END