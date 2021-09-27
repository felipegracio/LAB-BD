CREATE DATABASE EMPRESA 
GO
USE EMPRESA

GO

DROP DATABASE EMPRESA

CREATE TABLE funcionario(

codigo    INT    NOT NULL,
nome      VARCHAR(100)  NOT NULL,
salario   DECIMAL(7,2)  NOT NULL

PRIMARY KEY (codigo)


)
GO

INSERT INTO funcionario(codigo, nome, salario ) VALUES
(1, 'Fulano de Tal', 2000.),
(2, 'Beltrano', 1000.)

GO
DROP TABLE dependente
SELECT * FROM funcionario

CREATE TABLE dependente(

codigo_funcionario    INT    NOT NULL,
nome_dependente        VARCHAR(100)  NOT NULL,
salario_dependente    DECIMAL(7,2)  NOT NULL


PRIMARY KEY (codigo_funcionario, nome_dependente)
FOREIGN KEY (codigo_funcionario) REFERENCES funcionario(codigo)

)

INSERT INTO dependente(codigo_funcionario, nome_dependente, salario_dependente ) VALUES
(1, 'CARLOS HENRIQUE', 3000.),
(2, 'JOAO TIAO', 5000.)


/*
a) Uma Multi Statement Table Function que Retorne uma tabela:
(Nome_Funcionário, Nome_Dependente, Salário_Funcionário, Salário_Dependente)
*/

CREATE FUNCTION fn_lista_funcionario_e_dependentes(@nome_funcionario VARCHAR(50))
RETURNS @table TABLE (
	codigo INT,
	nome_funcionario VARCHAR(50),
	nome_dependente VARCHAR(50),
    salario_funcionario DECIMAL(7,2),
    salario_dependente DECIMAL(7,2)
)
AS
BEGIN
    INSERT INTO @table (codigo, nome_funcionario, nome_dependente, salario_funcionario, salario_dependente)
		SELECT
            f.codigo AS codigo,
            f.nome AS nome_funcionario,
            d.nome_dependente AS nome_dependente,
            f.salario AS salario_funcionario,
            d.salario_dependente AS salario_dependente
        FROM funcionario f, dependente d
		WHERE f.codigo = d.codigo_funcionario
			AND f.nome LIKE '%' + @nome_funcionario + '%'
	RETURN
END
GO

SELECT * FROM fn_lista_funcionario_e_dependentes('fulano')

-- b)Uma Scalar Function que Retorne a soma dos Salários dos dependentes, mais a do funcionário.

CREATE FUNCTION fn_somatoria_salario_depend_func(@nome_funcionario VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @somatoria DECIMAL(10,0)
	SET @somatoria = (
		SELECT
			f.salario + SUM(d.salario_dependente)
		FROM funcionario f, dependente d
		WHERE f.codigo = d.codigo_funcionario
			AND f.nome LIKE '%' + @nome_funcionario + '%'
		GROUP BY f.salario
	)
	RETURN @somatoria
END
GO

SELECT dbo.fn_somatoria_salario_depend_func('fulano') AS somatoria_salario