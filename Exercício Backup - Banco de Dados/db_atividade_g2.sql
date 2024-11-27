-- Criando a DB
CREATE DATABASE db_atividade_g2;
USE db_atividade_g2;


-- Criando as tabelas
DROP TABLE Produto(
	codbarras INT IDENTITY(1, 1) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	descricao VARCHAR(255) NOT NULL,
	preco_unitario FLOAT NOT NULL,
	codcateg INT NOT NULL
);

CREATE TABLE Categoria(
	codcateg INT IDENTITY(1, 1) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	descricao VARCHAR(255) NOT NULL,
);


-- Alimentando as tabelas
INSERT INTO Categoria (nome, descricao) VALUES ('Eletronicos', 'Variedade de eletronicos');
INSERT INTO Categoria (nome, descricao) VAlUES ('Eletrodomesticos', 'Todo tipo de eletrodomesticos');
INSERT INTO Categoria (nome, descricao) VALUES ('Moveis', 'Tipos variados de moveis');

INSERT INTO Produto (nome, descricao, preco_unitario, codcateg) VALUES ('iPhone 15', 'Apple iPhone 15 128Gb', 6500, 1);
INSERT INTO Produto (nome, descricao, preco_unitario, codcateg) VALUES ('Samsung S24', 'Samsung S24 256Gb', 4500, 1);
INSERT INTO Produto (nome, descricao, preco_unitario, codcateg) VALUES ('Notebook Gamer', 'Notebook Gamer DELL', 6000, 1);
INSERT INTO Produto (nome, descricao, preco_unitario, codcateg) VALUES ('Geladeira', 'Geladeira Brastemp', 3500, 2);
INSERT INTO Produto (nome, descricao, preco_unitario, codcateg) VALUES ('Micro-ondas', 'Micro-ondas Brastemp', 1000, 2);
INSERT INTO Produto (nome, descricao, preco_unitario, codcateg) VALUES ('AirFryer', 'AirFryer Mondial', 600, 2);
INSERT INTO Produto (nome, descricao, preco_unitario, codcateg) VALUES ('Sofa', 'Sofa Preto', 2500, 3);
INSERT INTO Produto (nome, descricao, preco_unitario, codcateg) VALUES ('Armario', 'Armario grande marrom', 1500, 3);
INSERT INTO Produto (nome, descricao, preco_unitario, codcateg) VALUES ('Cadeira', 'Cadeira Ergonomica', 800, 3);

SELECT * FROM Categoria
SELECT * FROM Produto


-- Fazendo o primeiro backup do banco de dados
BACKUP DATABASE db_atividade_g2 TO DISK = 'C:\Backup\primeirobackup.bak' WITH FORMAT


-- Restaurando Banco de Dados
RESTORE DATABASE teste4
FROM DISK = 'C:\Backup\primeirobackup.bak'
WITH 
    MOVE 'db_atividade_g2' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\teste4.mdf',
	MOVE 'db_atividade_g2_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\teste4_log.ldf',
    REPLACE;

USE teste4
