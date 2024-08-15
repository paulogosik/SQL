-- Criando procedures na DB
/*CREATE PROCEDURE soma
	@n1 int,
	@n2 int
	AS
BEGIN
	RETURN @n1 + @n2
END*/

-------------------------------

/* Criando tabela para testar o exemplo1 */
/*CREATE TABLE Produto(
	codProduto int IDENTITY(1, 1),
	nomeProduto varchar(100) NOT NULL,
	precoProduto float
)*/

--CREATE PROCEDURE exemplo1
--	@nomeProduto varchar(100),
--	@precoProduto float
--AS
--BEGIN
--	INSERT INTO Produto(nomeProduto, precoProduto)
--	VALUES (@nomeProduto, @precoProduto)
--END

--EXEC exemplo1 'iPhone 13', 3000
--EXEC exemplo1 'iPad Pro', 4500
--EXEC exemplo1 'MacBook Air 13', 9000

--CREATE PROCEDURE exemplo2
--	@nomeProduto varchar(100) = null,
--	@precoProduto float = null,
--	@mensagem varchar(50) OUTPUT,
--	@opcao int = null
--AS
--BEGIN
--	IF (@opcao = 1) BEGIN
--		INSERT INTO Produto (nomeProduto, precoProduto)
--		VALUES (@nomeProduto, @precoProduto);
--		SET @mensagem = 'O registro foi inserido!';
--	END
--	ELSE BEGIN
--		SELECT * FROM Produto;
--		SET @mensagem = 'Resultado da consulta!';
--	END
--END

--DECLARE
--	@msg varchar(50) = 'teste'
--EXEC exemplo2 'Mesa', 300, @msg OUTPUT, 1;
--PRINT(@msg)
--EXEC exemplo2 '', null, @msg OUTPUT, 2
--PRINT (@msg)


--select * from Produto

--CREATE PROCEDURE desafio2
--	@frase varchar(100)
--AS
--BEGIN
--	DECLARE @cont int = 1
--	WHILE @cont <= LEN(@frase) BEGIN
--		IF (@cont % 2 = 0) BEGIN
--			PRINT(SUBSTRING(@frase, @cont, 1))
--			END
--		SET @cont = @cont + 1
--	END
--END

--EXEC desafio2 'a1b2c3d4e5f6';

CREATE PROCEDURE desafio3 --Pode usar o ALTER
	@cpf varchar(11),
	--@return varchar(14) = ''
AS
BEGIN
	DECLARE @cont int = 1
	WHILE @cont <= LEN(@cpf) BEGIN
		IF (@cont < 4) BEGIN
			IF (@cont = 3) BEGIN
				SET @return = CONCAT(@return, SUBSTRING(@cpf, @cont, 1), '.')
			END
			ELSE BEGIN
				SET @return = CONCAT(@return, SUBSTRING(@cpf, @cont, 1))
			END
		END
		ELSE BEGIN
			IF (@cont < 7) BEGIN
				IF (@cont = 6) BEGIN
					SET @return = CONCAT(@return, SUBSTRING(@cpf, @cont, 1), '.')
				END
				ELSE BEGIN
					SET @return = CONCAT(@return, SUBSTRING(@cpf, @cont, 1))
				END
			END
			ELSE BEGIN
				IF (@cont < 10) BEGIN
					IF (@cont = 9) BEGIN
						SET @return = CONCAT(@return, SUBSTRING(@cpf, @cont, 1), '-')
					END
					ELSE BEGIN
						SET @return = CONCAT(@return, SUBSTRING(@cpf, @cont, 1))
					END
				END
				ELSE BEGIN
					SET @return = CONCAT(@return, SUBSTRING(@cpf, @cont, 1))
				END
			END
		END

		SET @cont = @cont + 1
	END

	PRINT(@return)
END

DROP PROCEDURE desafio3

DECLARE @cpfFormatado varchar(14)
EXEC desafio3 '79191479100'--, null
