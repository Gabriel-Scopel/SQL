Markdown

# Guia de Sintaxe SQL

Este guia resume os principais comandos e sintaxes da linguagem SQL para consulta, manipulação e definição de dados, ideal para uma referência rápida.

## Sumário
1.  [Consultas Básicas](#consultas-básicas)
2.  [Filtros Avançados](#filtros-avançados)
3.  [Funções de Agregação](#funções-de-agregação)
4.  [Agrupamento de Dados](#agrupamento-de-dados)
5.  [Junção de Tabelas (JOINs)](#junção-de-tabelas-joins)
6.  [Combinação de Consultas](#combinação-de-consultas)
7.  [Subconsultas (Subselect)](#subconsultas-subselect)
8.  [Funções de Data e Texto](#funções-de-data-e-texto)
9.  [DDL & DML (Estrutura e Manipulação)](#definição-e-manipulação-de-dados-ddl--dml)
10. [Views](#views)

---

## Consultas Básicas

### `SELECT`
Seleciona colunas específicas de uma tabela.
```sql
SELECT coluna1, coluna2 FROM tabela;
DISTINCT
Retorna apenas valores distintos (únicos) de uma coluna.

SQL

SELECT DISTINCT coluna1 FROM tabela;
WHERE
Filtra os registros com base em uma condição.

SQL

SELECT coluna FROM tabela WHERE condicao;
Operadores Comuns: <, >, <>, =, <=, >=, AND, OR.

COUNT
Conta o número de linhas que correspondem a um critério.

SQL

SELECT COUNT(coluna) FROM tabela;
TOP / LIMIT
Seleciona um número específico de registros do topo do resultado.

SQL

-- SQL Server / MS Access
SELECT TOP 10 coluna FROM tabela;

-- MySQL / PostgreSQL
SELECT coluna FROM tabela LIMIT 10;
ORDER BY
Ordena os resultados com base em uma ou mais colunas.

SQL

-- Ordenação ascendente (padrão)
SELECT coluna FROM tabela ORDER BY colunax ASC;

-- Ordenação descendente
SELECT coluna FROM tabela ORDER BY colunax DESC;
Filtros Avançados
BETWEEN
Seleciona valores dentro de um intervalo (incluindo os extremos).

SQL

-- Sintaxe geral
SELECT coluna FROM tabela WHERE colunaCondicao BETWEEN valor1 AND valor2;

-- Com negação
SELECT coluna FROM tabela WHERE colunaCondicao NOT BETWEEN valor1 AND valor2;

-- Exemplo com datas (formato 'AAAA-MM-DD' é o padrão ISO)
SELECT * FROM tabela WHERE data_nascimento BETWEEN '1990-01-01' AND '1999-12-31';
IN
Especifica múltiplos valores possíveis para uma coluna.

SQL

-- Retorna registros que correspondem a qualquer valor na lista
SELECT * FROM tabela WHERE coluna IN (valor1, valor2, valor3);

-- Com negação
SELECT * FROM tabela WHERE coluna NOT IN (valor1, valor2, valor3);
LIKE
Busca por um padrão específico em uma coluna de texto. Geralmente não é case-sensitive.

SQL

SELECT * FROM tabela WHERE nome LIKE 'Gab%';
%: Representa qualquer sequência de zero ou mais caracteres.

_: Representa um único caractere qualquer.

Funções de Agregação
Realizam um cálculo em um conjunto de valores e retornam um único valor.

Função	Descrição	Exemplo
SUM()	Soma os valores de uma coluna numérica.	SELECT SUM(preco) AS total_vendas FROM pedidos;
MAX()	Retorna o valor máximo de uma coluna.	SELECT MAX(salario) AS maior_salario FROM funcionarios;
MIN()	Retorna o valor mínimo de uma coluna.	SELECT MIN(idade) AS menor_idade FROM clientes;
AVG()	Calcula a média dos valores de uma coluna.	SELECT AVG(nota) AS media_geral FROM alunos;
COUNT()	Conta o número de linhas.	SELECT COUNT(id) AS total_clientes FROM clientes;

Exportar para as Planilhas
Agrupamento de Dados
GROUP BY
Agrupa linhas que têm os mesmos valores em colunas especificadas, permitindo o uso de funções de agregação em cada grupo.

SQL

SELECT coluna1, FUNCAO_DE_AGREGACAO(coluna2)
FROM tabela
GROUP BY coluna1;
HAVING
Filtra resultados de um agrupamento. É como um WHERE, mas para os resultados do GROUP BY.

SQL

SELECT coluna1, COUNT(coluna2)
FROM tabela
GROUP BY coluna1
HAVING COUNT(coluna2) > 5;
Junção de Tabelas (JOINs)
INNER JOIN
Retorna registros que têm valores correspondentes em ambas as tabelas.

SQL

SELECT a.coluna1, b.coluna2
FROM tabelaA AS a
INNER JOIN tabelaB AS b ON a.id_correspondente = b.id_correspondente;
Obs: INNER JOIN é o mesmo que JOIN.

LEFT JOIN
Retorna todos os registros da tabela da esquerda (tabelaA) e os registros correspondentes da tabela da direita (tabelaB). O resultado é NULL do lado direito se não houver correspondência.

SQL

SELECT a.coluna1, b.coluna2
FROM tabelaA AS a
LEFT JOIN tabelaB AS b ON a.id_correspondente = b.id_correspondente;
Obs: LEFT OUTER JOIN é o mesmo que LEFT JOIN.

RIGHT JOIN
Retorna todos os registros da tabela da direita (tabelaB) e os registros correspondentes da tabela da esquerda (tabelaA).

FULL OUTER JOIN
Retorna todos os registros quando há uma correspondência na tabela esquerda ou direita.

SELF JOIN
É um join regular, mas a tabela é juntada com ela mesma, usando aliases para distingui-las.

SQL

SELECT a.nome AS Nome1, b.nome AS Nome2, a.cidade
FROM clientes AS a, clientes AS b
WHERE a.id <> b.id AND a.cidade = b.cidade;
Combinação de Consultas
UNION
Combina o conjunto de resultados de duas ou mais consultas SELECT, removendo registros duplicados.
Requisitos: A quantidade de colunas e os tipos de dados devem ser os mesmos.

SQL

SELECT coluna1, coluna2 FROM tabela1
UNION
SELECT colunaA, colunaB FROM tabela2;
UNION ALL: Para preservar os registros duplicados.

Subconsultas (Subselect)
Uma consulta aninhada dentro de outra consulta SELECT, INSERT, UPDATE ou DELETE, ou dentro de outra subconsulta.

SQL

-- Seleciona produtos cujo preço é maior que a média de todos os preços.
SELECT nome_produto, preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);
Funções de Data e Texto
DATEPART
Retorna uma parte específica de uma data (sintaxe do SQL Server).

SQL

DATEPART(parte_da_data, coluna_data)
datepart	Valor Retornado
year, yyyy	Ano
quarter, qq	Trimestre
month, mm	Mês
day, dd	Dia
week, wk	Semana

Exportar para as Planilhas
Funções de String
Para uma lista completa de funções de texto, consulte a documentação do seu SGBD (ex: Transact-SQL String Functions).

Definição e Manipulação de Dados (DDL & DML)
CREATE TABLE
Cria uma nova tabela.

SQL

CREATE TABLE nome_tabela (
    coluna1 tipo_dado RESTRICAO,
    coluna2 tipo_dado,
    PRIMARY KEY (coluna1)
);
Restrições (Constraints): NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT.

INSERT INTO
Adiciona novos registros.

SQL

INSERT INTO nome_tabela (coluna1, coluna2) VALUES (valor1, valor2);
UPDATE
Modifica registros existentes.

SQL

UPDATE nome_tabela SET coluna1 = novo_valor WHERE condicao;
DELETE
Remove registros existentes.

SQL

DELETE FROM tabela WHERE condicao;
ALTER TABLE
Adiciona, exclui ou modifica colunas/restrições.

SQL

-- Adiciona uma coluna
ALTER TABLE nome_tabela ADD nome_coluna tipo_dado;

-- Modifica o tipo de uma coluna
ALTER TABLE produtos ALTER COLUMN nome VARCHAR(100) NOT NULL;
DROP TABLE
Exclui uma tabela e todos os seus dados.

SQL

DROP TABLE nome_tabela;
TRUNCATE TABLE
Remove todos os registros de uma tabela rapidamente, sem apagar a estrutura.

SQL

TRUNCATE TABLE nome_tabela;
Views
Uma VIEW é uma tabela virtual baseada no conjunto de resultados de uma consulta SQL.

CREATE VIEW
Cria uma nova view.

SQL

CREATE VIEW V_ClientesAtivos AS
SELECT id_cliente, nome, email
FROM clientes
WHERE status = 'ativo';
