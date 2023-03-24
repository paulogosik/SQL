USE livraria;

SELECT
	Nome_do_Livro AS Livro
    , Numero_de_Paginas AS Páginas
FROM
	livros
WHERE 
	Sexo = "F";