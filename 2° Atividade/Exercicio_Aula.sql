--Exercícios (Retornamos para discussão às 17h45):

--Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles

--Fazer um algoritmo que inverta uma palavra e mostre a palavra original toda minúscula (independente da entrada) e a invertida toda maiúscula.



--1)

DECLARE @valor INT
SET @valor = 10
IF (@valor % 2 = 0)
BEGIN
	PRINT('Valor Divisível por 2')

END
IF(@valor %3 = 0)
BEGIN
	PRINT('Valor Divisível por 3')
	
END
IF(@valor %5 = 0)
BEGIN
	PRINT('Valor Divisível por 5')
	
END
IF(@valor %2 != 0 AND @valor%3 != 0 AND @valor%5 !=0)
BEGIN
	PRINT('Valor não é divisivel por 2,3 e 5')

END



--2) 

DECLARE @palavra VARCHAR(20)
SET @palavra = 'Paralelepipido'

	PRINT('Minusculo: '+LOWER(@palavra))
	PRINT('Reverso: ' +UPPER(REVERSE(@palavra)))

