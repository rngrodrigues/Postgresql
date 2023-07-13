-- CREATE --

CREATE TABLE Supermercado (
  NRO_INT_Supermercado SERIAL PRIMARY KEY,
  NRO_CNPJ VARCHAR(18) NOT NULL UNIQUE,
  TXT_Nome VARCHAR(100) NOT NULL,
  NRO_Contato VARCHAR(45) NOT NULL UNIQUE,
  TXT_Endereco VARCHAR(255) NOT NULL UNIQUE,
  IND_Filial BOOLEAN NOT NULL
);

CREATE TABLE Funcionario (
  NRO_INT_Funcionario SERIAL PRIMARY KEY,
  NRO_INT_Supermercado INT REFERENCES Supermercado(NRO_INT_Supermercado) NOT NULL,
  NRO_CPF VARCHAR(14) NOT NULL UNIQUE,
  TXT_Nome VARCHAR(100) NOT NULL,
  NRO_Contato VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE Caixa (
  NRO_INT_Caixa SERIAL PRIMARY KEY,
  NRO_INT_Supermercado INT REFERENCES Supermercado(NRO_INT_Supermercado) NOT NULL,
  NRO_Numero INT NOT NULL,
  TP_Caixa Tipo_Caixa NOT NULL,
  TXT_Status Status_Caixa NOT NULL
);

CREATE TABLE Controle_Caixa (
  NRO_INT_Controle_Caixa SERIAL PRIMARY KEY,
  NRO_INT_Caixa INT REFERENCES Caixa(NRO_INT_Caixa) NOT NULL,
  NRO_INT_Funcionario INT REFERENCES Funcionario(NRO_INT_Funcionario) NOT NULL,
  DTH_Abertura TIMESTAMP NOT NULL,
  DTH_Fechamento TIMESTAMP NULL,
  VLR_Inicial NUMERIC(10, 2) NOT NULL,
  VLR_Final NUMERIC(10, 2) NULL
);

CREATE TABLE Produto (
  NRO_INT_Produto SERIAL PRIMARY KEY,
  NRO_Codigo_De_Barra VARCHAR(255) NOT NULL UNIQUE,
  TXT_Nome VARCHAR(255) NOT NULL,
  TXT_Descricao VARCHAR(255) NOT NULL,
  TP_Produto VARCHAR(20) NOT NULL,
  QTD_Produto_Contido INT NOT NULL
);

CREATE TABLE Lote ( 
  NRO_INT_Lote SERIAL PRIMARY KEY,
  NRO_INT_Supermercado INT REFERENCES Supermercado(NRO_INT_Supermercado) NOT NULL,
  NRO_Nota_Fiscal INT NOT NULL UNIQUE,
  DTH_Recebimento TIMESTAMP NOT NULL,
  DT_Fabricacao DATE NOT NULL,
  DT_Vencimento DATE NOT NULL
);

CREATE TABLE Produto_Estoque (
  NRO_INT_Produto_Estoque SERIAL PRIMARY KEY,
  NRO_INT_Produto INT REFERENCES Produto(NRO_INT_Produto) NOT NULL,
  NRO_INT_Supermercado INT REFERENCES Supermercado(NRO_INT_Supermercado) NOT NULL,
  VLR_Venda DECIMAL(10, 2) NOT NULL,
  VLR_Compra DECIMAL(10, 2) NOT NULL,
  TXT_Status Status_Produto_Estoque NOT NULL
);


CREATE TABLE Cliente (
  NRO_INT_Cliente SERIAL PRIMARY KEY,
  NRO_INT_Supermercado INT REFERENCES Supermercado(NRO_INT_Supermercado) NULL,
  NRO_CPF VARCHAR(14) NOT NULL UNIQUE,
  TXT_Nome VARCHAR(100) NOT NULL,
  NRO_Contato VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE Venda (
  NRO_INT_Venda SERIAL PRIMARY KEY,
  NRO_INT_Cliente INT REFERENCES Cliente(NRO_INT_Cliente) NULL,
  NRO_INT_Supermercado INT REFERENCES Supermercado(NRO_INT_Supermercado) NOT NULL,
  TXT_Forma_Pagamento VARCHAR(100) NOT NULL,
  VLR_Total DECIMAL(10, 2) NOT NULL,
  DTH_Venda TIMESTAMP NOT NULL,
  TXT_Status Status_Venda NOT NULL
);

CREATE TABLE Produto_Venda (
  NRO_INT_Produto_Venda SERIAL PRIMARY KEY,
  NRO_INT_Venda INT REFERENCES Venda(NRO_INT_Venda) NOT NULL,
  NRO_INT_Produto_Estoque INT REFERENCES Produto_Estoque(NRO_INT_Produto_Estoque) NOT NULL,
  NRO_INT_Controle_Caixa INT REFERENCES Controle_Caixa(NRO_INT_Controle_Caixa) NOT NULL
);

CREATE TABLE Nota_Fiscal (
  NRO_INT_Nota_Fiscal SERIAL PRIMARY KEY,
  NRO_INT_Venda INT REFERENCES Venda(NRO_INT_Venda) NOT NULL UNIQUE,
  NRO_Numero INT NOT NULL UNIQUE,
  DTH_Emissao TIMESTAMP NOT NULL,
  VLR_ICMS DECIMAL(10, 2) NOT NULL,
  VLR_IPI DECIMAL(10, 2) NOT NULL,
  VLR_PIS DECIMAL(10, 2) NOT NULL,
  VLR_COFINS DECIMAL(10, 2) NOT NULL,
  VLR_ISS DECIMAL(10, 2) NOT NULL,
  VLR_Impostos_Totais DECIMAL(10, 2) NOT NULL
);

-- ENUMS --

CREATE TYPE Tipo_Caixa AS ENUM (
  'PREFERENCIAL',
  'RAPIDO',
  'NORMAL'
);

CREATE TYPE Status_Caixa AS ENUM (
  'DISPONIVEL',
  'INDISPONIVEL',
  'QUEBRADA',
  'MANUTENCAO'
);

CREATE TYPE Status_Venda AS ENUM (
  'APROVADO',
  'CANCELADA',
  'REJEITADO'
);

CREATE TYPE Status_Produto_Estoque AS ENUM (
  'DISPONIVEL',
  'INDISPONIVEL',
  'VENDIDO',
  'ESTRAGADO',
  'VIOLADO',
  'ABERTO'
);

-- ALTER (Testes) --

ALTER TABLE Supermercado
ADD COLUMN Teste VARCHAR(100),
ADD COLUMN Teste1 VARCHAR(100),
ADD COLUMN Teste2 VARCHAR(100);

ALTER TABLE Supermercado 
ALTER COLUMN Teste0 TYPE VARCHAR(20),
ALTER COLUMN Teste01 TYPE VARCHAR(20),
ALTER COLUMN Teste02 TYPE VARCHAR(20);

ALTER TABLE Supermercado 
DROP COLUMN Teste0,
DROP COLUMN Teste01,
DROP COLUMN Teste02;

-- DROP (Testes) --

DROP TABLE Supermercado;
DROP TABLE Lote;
DROP TABLE Funcionario;
DROP TABLE Caixa;
DROP TABLE Controle_Caixa;
DROP TABLE Produto;
DROP TABLE Produto_Estoque;
DROP TABLE Cliente;
DROP TABLE Venda;
DROP TABLE Produto_Venda;
DROP TABLE Nota_Fiscal;

--- "DROP ALL" ---

DROP SCHEMA public CASCADE;

CREATE SCHEMA public;

------------------


-- ÍNDICE (1) --

CREATE INDEX IDX_Nome_Funcionario ON Funcionario (TXT_Nome);

-- ÍNDICE (2) --

CREATE INDEX IDX_Codigo_De_Barra ON Produto (NRO_Codigo_De_Barra); 

-- FUNCTION (1) --

CREATE OR REPLACE FUNCTION Verificar_Disponibilidade_Caixa(ID_Caixa INT) 
RETURNS BOOLEAN AS $$
DECLARE
  Caixa_Disponivel BOOLEAN;
  Caixa_Status VARCHAR(20);
  Data_Atual DATE := CURRENT_DATE;
BEGIN
  IF NOT EXISTS (SELECT * FROM Caixa WHERE NRO_INT_Caixa = ID_Caixa) THEN
    RAISE EXCEPTION 'Caixa com ID % não existe.', ID_Caixa;
  END IF;

  SELECT TXT_Status INTO Caixa_Status
  FROM Caixa
  WHERE NRO_INT_Caixa = ID_Caixa;

  IF Caixa_Status <> 'DISPONIVEL' THEN
    RAISE EXCEPTION 'Caixa com o ID % não está disponível. O status atual é %.', ID_Caixa, Caixa_Status;
    Caixa_Disponivel := FALSE;
  ELSE
    SELECT 
    CASE
      WHEN DTH_Fechamento IS NULL THEN FALSE
      ELSE TRUE
    END
    INTO Caixa_Disponivel
    FROM Controle_Caixa
    WHERE NRO_INT_Caixa = ID_Caixa
      AND DATE(DTH_Fechamento) = Data_Atual;

    IF Caixa_Disponivel THEN
      RAISE NOTICE 'Caixa com o ID % está disponível.', ID_Caixa;
    ELSE
      RAISE NOTICE 'Caixa com o ID % não está disponível, ainda há um expediente em aberto.', ID_Caixa;
    END IF;
  END IF;
  
  RETURN Caixa_Disponivel;
END;
$$ LANGUAGE plpgsql;


-- Function (2)--

CREATE OR REPLACE FUNCTION Finaliza_Expediente (ID_Controle_Caixa INT, Valor_Final NUMERIC(10,2))
  RETURNS VOID
AS $$
DECLARE
  Valor_Inicial NUMERIC(10,2);
BEGIN

  IF NOT EXISTS (SELECT * FROM Controle_Caixa WHERE NRO_INT_Controle_Caixa = ID_Controle_Caixa) THEN
  RAISE EXCEPTION 'Expediente com ID % não existe.', ID_Controle_Caixa;
  END IF;

  SELECT VLR_Inicial INTO Valor_Inicial FROM Controle_Caixa WHERE NRO_INT_Controle_Caixa = ID_Controle_Caixa;
  IF Valor_Final < Valor_Inicial THEN
  RAISE EXCEPTION 'O valor final não pode ser inferior ao valor inicial.';
  END IF;

  IF NOT EXISTS (SELECT * FROM Controle_Caixa WHERE NRO_INT_Controle_Caixa = ID_Controle_Caixa AND DTH_Fechamento IS NULL) THEN
    RAISE EXCEPTION 'O expediente % já foi finalizado.', ID_Controle_Caixa;
  END IF;

  UPDATE Controle_Caixa
  SET DTH_Fechamento = CURRENT_TIMESTAMP,
      VLR_Final = Valor_Final
  WHERE NRO_INT_Controle_Caixa = ID_Controle_Caixa
  AND DTH_Fechamento IS NULL;

  RAISE NOTICE 'Expediente finalizado.';
  
END;
$$ LANGUAGE plpgsql;


SELECT * FROM Finaliza_Expediente (2, '1000');

-- FUNCTION (3) --

CREATE OR REPLACE FUNCTION Valida_Formato_CPF_Cliente(NRO_ID_Cliente INT)
RETURNS VARCHAR AS $$
DECLARE
    CPF_Cliente VARCHAR(14);
BEGIN

    SELECT NRO_CPF INTO CPF_Cliente
    FROM Cliente
    WHERE NRO_INT_Cliente = NRO_ID_Cliente;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Cliente com ID % não encontrado.', NRO_ID_Cliente;
    END IF;

    IF LENGTH(CPF_Cliente) <> 14 THEN
        RAISE EXCEPTION 'CPF inválido. O CPF deve conter 14 dígitos.';
    END IF;

    IF CPF_Cliente !~ '^\d{3}\.\d{3}\.\d{3}-\d{2}$' THEN
        RAISE EXCEPTION 'CPF inválido. O CPF deve estar no formato XXX.XXX.XXX-XX.';
    END IF;

    RAISE NOTICE 'CPF válido: %.', CPF_Cliente;
    RETURN CPF_Cliente;
	
END;
$$ LANGUAGE plpgsql;

SELECT * FROM Valida_Formato_CPF_Cliente(1);

-- Function (4) -- 

CREATE OR REPLACE FUNCTION Valida_Formato_CNPJ_Supermercado(NRO_ID_Supermercado INT)
RETURNS VARCHAR(18)
AS $$
DECLARE
    CNPJ_Supermercado VARCHAR(18);
BEGIN
    SELECT NRO_CNPJ INTO CNPJ_Supermercado
    FROM Supermercado
    WHERE NRO_INT_Supermercado = NRO_ID_Supermercado;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Supermercado com ID % não encontrado.', NRO_ID_supermercado;
    END IF;

    IF LENGTH(CNPJ_Supermercado) <> 18 THEN
        RAISE EXCEPTION 'CNPJ % inválido. O CNPJ deve conter 18 dígitos.', CNPJ_Supermercado;
    END IF;

    IF CNPJ_Supermercado !~ '^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$' THEN
        RAISE EXCEPTION 'CNPJ % inválido. O CNPJ deve estar no formato XX.XXX.XXX/XXXX-XX.', CNPJ_Supermercado;
    END IF;

    RAISE NOTICE 'CNPJ válido: %.', CNPJ_Supermercado;
    RETURN CNPJ_Supermercado;
	
END;
$$ LANGUAGE plpgsql;

SELECT * FROM Valida_Formato_CNPJ_Supermercado(2);

-- PROCEDURE (1) --

CREATE OR REPLACE PROCEDURE Atualizar_Estoque_Produto_Venda(ID_Produto_Estoque INT)
AS $$
DECLARE
  Venda_Status Venda.TXT_Status%TYPE;
BEGIN
  IF NOT EXISTS (SELECT * FROM Produto_Estoque WHERE NRO_INT_Produto_Estoque = ID_Produto_Estoque) THEN
    RAISE EXCEPTION 'Produto com ID % não existe.', ID_Produto_Estoque;
  END IF;
  
 IF NOT EXISTS (SELECT * FROM Produto_Venda WHERE NRO_INT_Produto_Estoque = ID_Produto_Estoque) THEN
    RAISE EXCEPTION 'O produto com ID % não foi vendido.', ID_Produto_Estoque;
  END IF;

  UPDATE Produto_Estoque
  SET TXT_Status = 'VENDIDO'
  WHERE NRO_INT_Produto_Estoque = ID_Produto_Estoque;

  SELECT TXT_Status INTO Venda_Status
  FROM venda
  WHERE NRO_INT_Venda IN (SELECT NRO_INT_Venda FROM Produto_Venda WHERE NRO_INT_Produto_Estoque = ID_Produto_Estoque);
  IF (Venda_Status = 'CANCELADA' OR Venda_Status = 'REJEITADO') THEN
  ROLLBACK;	
    RAISE NOTICE 'Venda cancelada ou rejeitada, o produto % não foi vendido. Rollback executado.', ID_Produto_Estoque;	
  ELSIF (Venda_Status = 'APROVADO') 
    THEN	
   COMMIT;	  
    RAISE NOTICE 'Produto % vendido.', ID_Produto_Estoque;
	
  END IF;
  
END;
$$ LANGUAGE plpgsql;


CALL Atualizar_Estoque_Produto_Venda(1);

-- VIEW (1) --

CREATE VIEW Vendas_Detalhadas AS
SELECT Venda.NRO_INT_Venda AS ID_Venda,
       Cliente.NRO_CPF AS CPF_Cliente,
       Venda.DTH_Venda AS Data_Da_Venda,
       Venda.VLR_Total AS Valor_Da_Venda,
       Nota_Fiscal.NRO_Numero AS Nota_Fiscal,
       Venda.NRO_INT_Supermercado AS ID_Supermercado
FROM Venda
LEFT JOIN Cliente ON Venda.NRO_INT_Cliente = Cliente.NRO_INT_Cliente
INNER JOIN Nota_Fiscal ON Venda.NRO_INT_Venda = Nota_Fiscal.NRO_INT_Venda
ORDER BY Venda.DTH_Venda DESC;

SELECT * FROM Vendas_Detalhadas;


-- VIEW (2) --

CREATE VIEW Produtos_Disponiveis_No_Estoque AS
SELECT Produto.NRO_INT_Produto AS ID_Do_Produto,
       Produto.TXT_Nome AS Nome_Do_Produto,
       Produto_Estoque.NRO_INT_Supermercado AS ID_Do_Supermercado,
       COUNT(Produto_Estoque.NRO_INT_Produto_Estoque) AS Quantidade_Disponivel
FROM Produto
JOIN Produto_Estoque ON Produto.NRO_INT_Produto = Produto_Estoque.NRO_INT_Produto
WHERE Produto_Estoque.TXT_Status = 'DISPONIVEL'
GROUP BY Produto.NRO_INT_Produto, Produto.TXT_Nome, Produto_Estoque.NRO_INT_Supermercado;

SELECT * FROM Produtos_Disponiveis_No_Estoque;

----------

































