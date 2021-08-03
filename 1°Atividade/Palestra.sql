CREATE DATABASE palestras

go

USE palestras 

CREATE TABLE curso(

codigo_curso     INT    NOT NULL,
nome             VARCHAR(70)   NOT NULL,
sigla            VARCHAR(10)   NOT NULL


PRIMARY KEY(codigo_curso)

)
GO

INSERT INTO curso(codigo_curso, nome, sigla) VALUES
(1, 'Física', 'FIS'),
(2, 'Quimica', 'QUI'),
(3, 'Biologia', 'BIO')



GO


CREATE TABLE aluno(

ra        CHAR(7)     NOT NULL,
nome      VARCHAR(250) NOT NULL,
codigo_curso   INT     NOT NULL


PRIMARY KEY  (ra)
FOREIGN KEY (codigo_curso) REFERENCES curso(codigo_curso)


)

INSERT INTO aluno(ra, nome, codigo_curso) VALUES
('1111111', 'Felipe', 1),
('2222222', 'Sandro', 2),
('3333333', 'Renato', 3)

GO


CREATE TABLE palestra (

codigo_palestra     INT    IDENTITY(1,1),
titulo              VARCHAR(MAX)  NOT NULL,
carga_horaria       INT           NULL,
data                DATETIME      NOT NULL,
codigo_palestrante  INT           NOT NULL


PRIMARY KEY (codigo_palestra)
FOREIGN KEY (codigo_palestrante) REFERENCES palestrante(codigo_palestrante)



)

INSERT INTO palestra(titulo, carga_horaria, data, codigo_palestrante) VALUES
    ('Power BI', 2, '2020-06-05 00:00:00.000', 1),
    ('SQL', 4, '2020-06-07 00:00:00.000', 2),
    ('IOT', 2, '2020-06-05 00:00:00.000', 3)

CREATE TABLE alunos_inscritos(
    ra CHAR(7) NOT NULL,
    codigo_palestra INT NOT NULL
    PRIMARY KEY(ra, codigo_palestra)
    FOREIGN KEY(ra) REFERENCES aluno(ra),
    FOREIGN KEY(codigo_palestra) REFERENCES palestra(codigo_palestra)
)





INSERT INTO alunos_inscritos(ra, codigo_palestra) VALUES
    ('1111111', 1),
    ('2222222', 2),
    ('3333333', 2)

GO

CREATE TABLE palestrante(

codigo_palestrante       INT       IDENTITY(1,1),
nome                     VARCHAR(250)   NOT NULL,
empresa                  VARCHAR(100)   NOT NULL

PRIMARY KEY (codigo_palestrante)


)

INSERT INTO palestrante( nome, empresa) VALUES
( 'Ana Paula', 'IBM'),
( 'Renan', 'Apple'),
( 'Jorge', 'Uber')

GO
    
	
CREATE TABLE nao_alunos(

rg                      VARCHAR(9) NOT NULL,
orgao_exp               CHAR(5)    NOT NULL,
nome                   VARCHAR(250) NOT NULL

PRIMARY KEY (rg, orgao_exp)



)

INSERT INTO nao_alunos(rg, orgao_exp, nome) VALUES
('777777777', 'SSP', 'Fabio'),
('123456123', 'SSP', 'Clara'),
('098765098', 'SSP', 'Luis')

CREATE TABLE nao_alunos_inscrito(

codigo_palestra         INT       NOT NULL,
rg                      VARCHAR(9) NOT NULL,
orgao_exp               CHAR(5)    NOT NULL
PRIMARY KEY (codigo_palestra, rg, orgao_exp)
FOREIGN KEY (codigo_palestra) REFERENCES palestra(codigo_palestra),
FOREIGN KEY (rg, orgao_exp) REFERENCES nao_alunos(rg, orgao_exp)


)

INSERT INTO nao_alunos_inscrito(codigo_palestra, rg, orgao_exp) VALUES
(1, '777777777', 'SSP'),
(2, '123456123', 'SSP'),
(2, '098765098', 'SSP')


CREATE VIEW Lista_Presenca
AS

SELECT a.ra AS Num_Documento, a.nome AS Nome_Pessoa, p.titulo, pa.nome, p.carga_horaria, p.data  
FROM aluno a, palestra p, palestrante pa, alunos_inscritos ains
WHERE a.ra = ains.ra
AND ains.codigo_palestra = p.codigo_palestra
AND p.codigo_palestrante = pa.codigo_palestrante

UNION


SELECT na.rg +na.orgao_exp AS Num_Documento, na.nome AS Nome_Pessoa, p.titulo, pa.nome, p.carga_horaria, p.data  
FROM nao_alunos na, nao_alunos_inscrito nai, palestra p , palestrante pa
WHERE p.codigo_palestra = nai.codigo_palestra
AND nai.orgao_exp = na.orgao_exp
AND nai.rg = na.rg
AND pa.codigo_palestrante = p.codigo_palestrante


SELECT * FROM Lista_Presenca
ORDER BY Nome_Pessoa
