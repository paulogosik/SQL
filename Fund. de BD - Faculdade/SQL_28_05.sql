-- Produto Cartesiano; ------------------------
-- SELECT * FROM tb_cliente, tb_conta
-- SELECT * FROM tb_cliente, tb_conta WHERE tb_cliente.codCli = tb_conta.codCli


-- Junção natural; ------------------------
-- SELECT * FROM tb_cliente t1 INNER JOIN tb_conta t2 ON t1.codCli = t2.codCli
-- SELECT 
-- 	nomeCli, 
-- 	nomeAg, 
-- 	codConta, 
-- 	saldo
-- FROM tb_cliente cli
-- INNER JOIN tb_conta con ON cli.codCli = con.codCli
-- INNER JOIN tb_agencia ag ON con.codAg = ag.codAg


-- ORDER BY: Ordenação de Dados; ------------------------
-- SELECT nomeCli FROM tb_cliente ORDER BY nomeCli
-- SELECT nomeCli FROM tb_cliente ORDER BY nomeCli DESC


-- Funções de agregação sobre conjuntos ------------------------
-- MAX - Valor máximo
-- MIN - Valor mínimo
-- SUM - Soma
-- AVG - Média
-- COUNT - Conta unidades
-- SELECT COUNT(*) FROM tb_cliente WHERE cidadeCli = 'Palmas'
-- SELECT AVG(saldo) FROM tb_conta
-- SELECT MIN(saldo), MAX(saldo) FROM tb_emprestimo
-- SELECT SUM(saldo) FROM tb_emprestimo t1
-- INNER JOIN tb_agencia t2 ON t1.codAg = t2.codAg
-- WHERE cidadeAg = 'Palmas'


-- GROUP BY: Agrupando Dados; ------------------------
-- SELECT cidadeCli FROM tb_cliente GROUP BY cidadeCli
-- SELECT codAg FROM tb_conta GROUP BY codAg
-- SELECT cidadeCli, count(*) AS 'Contagem' FROM tb_cliente GROUP BY cidadeCli
--  SELECT t2.cidadeAg, AVG(saldo)
--  FROM tb_conta t1 INNER JOIN tb_agencia t2 ON t1.codAg = t2.codAg
--  GROUP BY t2.cidadeAg


-- UPDATE: Atualizando Dados; ------------------------
-- UPDATE tb_agencia SET nomeAg = 'CENTRO SUL' WHERE codAg = 2


-- DELETE: Excluindo Dados; ------------------------
DELETE FROM tb_cliente WHERE codCli = 1
DELETE FROM tb_conta WHERE codCli = (
	SELECT codCli FROM tb_cliente WHERE nomeCli = 'Ana Banana'
)
