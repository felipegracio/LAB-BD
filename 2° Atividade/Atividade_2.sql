--1. Fazer um algoritmo que leia 3 valores e retorne se os valores formam um triângulo e se ele é
--isóceles, escaleno ou equilátero.
--Condições para formar um triângulo
--	Nenhum valor pode ser = 0
--	Um lado não pode ser maior que a soma dos outros 2.



DECLARE @lado1 INT
DECLARE @lado2 INT
DECLARE @lado3 INT 
SET @lado1 =5
SET @lado2 =5
SET @lado3 =6

IF(@lado1 = @lado2 AND @lado2 = @lado3 AND @lado1 = @lado3 )
BEGIN

PRINT('Triangulo Equilatero')
END

IF (@lado1 = @lado2 AND @lado1 != @lado3 OR @lado1 = @lado3 AND @lado2 != @lado3 OR @lado2 = @lado3 AND @lado2 !=@lado1)
BEGIN
PRINT('Trinagulo Escaleno')

END


IF (@lado1 != @lado2 AND @lado1 != @lado3 AND @lado2!=@lado3)
BEGIN

PRINT('Trinagulo Isoceles')

END

IF (@lado1=0 OR @lado2=0 OR @lado3=0)
BEGIN
PRINT('Nenhum valor pode ser = 0')
END

IF(@lado1+@lado2<@lado3 OR @lado1+@lado3<@lado2 OR @lado3 +@lado2<@lado1)
BEGIN
PRINT('Um lado não pode ser maior que a soma dos outros 2')
END




--2. Fazer um algoritmo que calcule e exiba, os 15 primeiros termos da série de Fibonacci
--1,1,2,3,5,8,13,21,...
--Ao final, deve calcular e exibir a soma dos 15 termos

DECLARE @valor1 INT
DECLARE @valor2 INT
DECLARE @valor3 INT
DECLARE @cont   INT
DECLARE @num    INT

SET @valor1 = 1
SET @valor2 = 1
SET @cont = 3
SET @num = 15

PRINT(@valor1)
PRINT(@valor2)

WHILE(@cont<=@num)
BEGIN

SET @valor3 = @valor1 + @valor2 
PRINT (@valor3)
SET @valor1 = @valor2
SET @valor2 = @valor3
SET @cont = @cont +1
END



-- 3. Fazer um algoritmo que retorne se duas cadeias de caracteres são palíndromos

DECLARE @palavra1 VARCHAR(20)
DECLARE @palavra2 VARCHAR(20)
SET @palavra1 = 'ana'
SET @palavra2 = 'ana'

IF (LEN(@palavra1)!=LEN(@palavra2))
BEGIN
RAISERROR('As palavras possuem numeros diferentes de caracteres, não são palindromos', 16,1)
END

IF (@palavra1 = REVERSE(@palavra2))
BEGIN

PRINT ('As palavras são palindromos')

END

ELSE 
BEGIN
PRINT('As palavras não são Palindromos')
END




--4. Fazer um algoritmo que verifique em uma entrada no formato de uma frase, quantas palavras tem e exiba a quantidade de palavras.
DECLARE @frase  VARCHAR(100)
DECLARE @qtd  INT
DECLARE @num1 INT
DECLARE @letra1 CHAR(1)
DECLARE @letra2 CHAR(1)
SET @frase = 'fisica e muito legal de estudar'
SET @qtd = 0
SET @num1 = 1
WHILE(@num1 <= LEN(@frase))
BEGIN
	SET @letra1 = SUBSTRING(@frase, @num1, 1)

	IF(@num1 = 1) SET @letra2 = ' '
	ELSE 
	SET @letra2 = SUBSTRING(@frase, @num1-1, 1)

	IF(@letra2 = ' ' AND @letra1 != ' ') 
	SET @qtd = @qtd + 1
	SET @num1 = @num1 + 1
END
PRINT(@qtd)