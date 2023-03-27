CREATE DATABASE comercio;

#----------------------------------

USE comercio;

#----------------------------------

CREATE TABLE clientes (
	cliente_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL
    , nome VARCHAR(30) NOT NULL
    , sexo ENUM('M', 'F') NOT NULL
    , email VARCHAR(50) UNIQUE
    , cpf VARCHAR(15) UNIQUE
);

#----------------------------------

CREATE TABLE endereco (
	endereco_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL
	, rua VARCHAR(30) NOT NULL
    , bairro VARCHAR(30) NOT NULL
    , cidade VARCHAR(30)
    , estado CHAR(2) NOT NULL
); 

#----------------------------------

CREATE TABLE telefone (
	 telefone_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL
     , tipo ENUM('Residencial', 'Comercial', 'Celular') NOT NULL
     , numero VARCHAR(10) NOT NULL
);

#----------------------------------

SELECT * FROM clientes;