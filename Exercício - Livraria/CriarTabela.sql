CREATE TABLE Livros (
	ID INT NOT NULL AUTO_INCREMENT,
	Nome_do_Livro  VARCHAR (30),
    Nome_do_Autor  VARCHAR (30),
    Sexo CHAR (1),
    Numero_de_Paginas  INT(11),
    Nome_da_Editora  VARCHAR (30),
    Valor_do_Livro FLOAT(8),
    UF CHAR(2),
    Ano INT(4),
    PRIMARY KEY (ID)
);