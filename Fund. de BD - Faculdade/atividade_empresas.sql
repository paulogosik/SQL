-- Criando DB ============================
CREATE DATABASE empresa
USE empresa

-- Criando tabelas ==========================
CREATE TABLE departamentos(
    id int IDENTITY (1, 1),
    nome varchar(100) NOT NULL,
    PRIMARY KEY (id)
)

CREATE TABLE funcionarios(
    id int IDENTITY (1, 1),
    nome varchar(100) NOT NULL,
	cargo varchar(50) NOT NULL,
	salario DECIMAL(10,2),
	departamento_id int NOT NULL,
	FOREIGN KEY (departamento_id) REFERENCES departamentos(id),
    PRIMARY KEY (id)
)

CREATE TABLE projetos(
    id int IDENTITY (1, 1),
    nome varchar(100) NOT NULL,
    PRIMARY KEY (id)
)

CREATE TABLE funcionarios_projetos(
    funcionario_id int NOT NULL,
	projeto_id int NOT NULL,
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id),
	FOREIGN KEY (projeto_id) REFERENCES projetos(id),
)


-- Testando comandos ======================
SELECT * FROM departamentos
SELECT * FROM funcionarios
SELECT * FROM projetos
SELECT * FROM funcionarios_projetos


-- Modelos para usar no app =========================
SELECT
	F.nome 'Nome Funcionário',
	F.cargo 'Cargo',
	F.salario 'Salário',
	D.nome 'Nome Departamento'
FROM funcionarios F
JOIN departamentos D ON F.departamento_id = D.id

SELECT
	P.nome 'Nome Projeto',
	F.nome 'Nome Funcionário',
	F.cargo 'Cargo'
FROM funcionarios_projetos FP
JOIN funcionarios F ON FP.funcionario_id = F.id
JOIN projetos P ON FP.funcionario_id = P.id

CREATE VIEW view_funcionarios_departamentos
	(id, nome, nomeDepartamento)
AS
	SELECT
		F.id 'ID Funcionário',
		F.nome 'Nome Funcionário',
		D.nome
	FROM funcionarios F
	JOIN departamentos D ON F.departamento_id = D.id

SELECT * FROM view_funcionarios_departamentos

CREATE FUNCTION aumentar_salario(
	@id int,
	@percentual decimal(5,2)
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @antigo_salario decimal(10,2);

	SELECT @antigo_salario = salario
	FROM funcionarios WHERE id = @id;

	UPDATE funcionarios SET salario = salario + (salario * @percentual / 100) WHERE id = @id;
	RETURN 'Concluído com sucesso!';
END

EXEC dbo.aumentar_salario(?, ?)
