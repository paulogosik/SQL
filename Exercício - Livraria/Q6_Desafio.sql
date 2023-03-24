USE livraria;

SELECT 
	*
FROM
	livros
WHERE
	Sexo = "M" AND (UF = "RJ" OR UF = "SP")