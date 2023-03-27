USE funcionarios;

SELECT
	nome
    , email
    , sexo
    , departamento
FROM funcionarios
WHERE
	sexo = "Feminino"
    AND (departamento = "Filmes" OR departamento = "Lar")