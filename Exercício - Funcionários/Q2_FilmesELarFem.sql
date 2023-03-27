USE funcionarios;

SELECT
	nome
    , email
    , sexo
    , departamento
FROM funcionarios
WHERE
	(departamento = "Filmes" AND sexo = "Feminino")
    OR (departamento = "Lar" AND sexo = "Feminino");