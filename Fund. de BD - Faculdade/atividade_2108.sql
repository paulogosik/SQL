-- Criação DB
CREATE DATABASE atividade_2108
USE atividade_2108



-- Criação tabelas
CREATE TABLE Cliente (
    codCliente int IDENTITY (1, 1),
    nomeCliente varchar(100) NOT NULL
)

CREATE TABLE Vendedor (
    codVendedor int IDENTITY (1, 1),
    nomeVendedor varchar(100) NOT NULL
)

CREATE TABLE Venda (
    codVenda int IDENTITY (1, 1),
	FOREIGN KEY (codCliente) REFERENCES Cliente (codCliente),
    FOREIGN KEY (codVendedor) REFERENCES Vendedor (codVendedor),
	dataVenda DATE,
	totalVenda DECIMAL(10,2)
)

CREATE TABLE Comissao (
    codComissao int IDENTITY (1, 1),
    FOREIGN KEY (codVendedor) REFERENCES Vendedor (codVendedor),
	FOREIGN KEY (dataVenda) REFERENCES Venda (dataVenda),
	valorComissao DECIMAL(10,2)
)