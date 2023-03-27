USE funcionarios;

SELECT 	
	*
FROM
	funcionarios
WHERE 
	1 = 1
    AND departamento = "Roupas"
    OR departamento = "Filmes";