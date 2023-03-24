USE livraria;

SELECT
	Nome_do_Livro AS Livro
    , UF AS Estado
FROM
	livros
WHERE
	Sexo = "M"