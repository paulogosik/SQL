--CREATE TABLE Produto(
--	codProduto int IDENTITY(1, 1),
--	nomeProduto varchar(100) NOT NULL,
--	precoProduto float
--)

CREATE TABLE Categoria(
	codigo int IDENTITY(1,1),
	titulo varchar(100) NOT NULL
)

CREATE TABLE Noticia(
	codigo int IDENTITY(1,1),
	titulo varchar(100) NOT NULL,
	descricao varchar(255) NOT NULL,
	data_cadastro date NOT NULL,
	codigo_categoria int NOT NULL,
)

INSERT INTO Categoria(titulo) VALUES ('Mundo')
INSERT INTO Categoria(titulo) VALUES ('Moda')
INSERT INTO Categoria(titulo) VALUES ('Politica')
INSERT INTO Categoria(titulo) VALUES ('Guerra')
SELECT * FROM Categoria

INSERT INTO Noticia(titulo, descricao, data_cadastro, codigo_categoria) VALUES ('Guerra Ucrania', 'Guerra Ucrania', GETDATE(), 4)
INSERT INTO Noticia(titulo, descricao, data_cadastro, codigo_categoria) VALUES ('Desfile Moda', 'Desfile Moda', GETDATE(), 2)
INSERT INTO Noticia(titulo, descricao, data_cadastro, codigo_categoria) VALUES ('Novo país descoberto', 'Novo país descoberto', GETDATE(), 1)
INSERT INTO Noticia(titulo, descricao, data_cadastro, codigo_categoria) VALUES ('Trump Baleado', 'Trump Baleado', GETDATE(), 3)
SELECT * FROM Noticia

CREATE VIEW consulta_noticia_mundo
	(titulo, descricao, data_cadastro)
AS
	SELECT titulo, descricao, data_cadastro
	FROM Noticia
	WHERE codigo_categoria = 1

SELECT * FROM consulta_noticia_mundo

CREATE PROCEDURE consulta_categoria
	@categoria int
AS
BEGIN
	SELECT titulo, descricao, data_cadastro FROM Noticia
	WHERE codigo_categoria = @categoria
END

EXEC consulta_categoria 1

DELETE FROM Categoria WHERE titulo = 'E-sports'