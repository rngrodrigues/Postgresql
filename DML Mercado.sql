-- SELECT --

SELECT * FROM Supermercado;

SELECT * FROM Funcionario;

SELECT * FROM Caixa;

SELECT * FROM Controle_Caixa;

SELECT * FROM Produto;

SELECT VLR_Compra FROM Produto_Estoque WHERE VLR_Compra < 3.65;

SELECT * FROM Produto_Estoque WHERE NRO_INT_Produto_Estoque=40;

SELECT * FROM Cliente;

SELECT * FROM Lote;

SELECT * FROM Venda;

SELECT * FROM Produto_Venda;
 
SELECT * FROM Nota_Fiscal;

-- INSERT --

       INSERT INTO Supermercado (NRO_CNPJ, TXT_Nome, NRO_Contato, TXT_Endereco, IND_Filial)
VALUES ('46.669.742/0019-87', 'Supermercado A', '(21) 9 8765-4311', 'Rua Principal, 111', true),
       ('29.145.331/0001-01', 'Supermercado B', '(21) 9 1234-5678', 'Rua Principal, 222', true),
	   ('16.967.571/0001-30', 'Supermercado C', '(21) 9 1234-5698', 'Rua Principal, 333', true);
	   
	   INSERT INTO Funcionario (NRO_INT_Supermercado, NRO_CPF, TXT_Nome, NRO_Contato)
VALUES (1, '405.682.980-20', 'Bia Pereira', '(21) 9 8765-4310'),
       (2, '288.435.130-28', 'David Nunes', '(21) 9 1234-56789'),
       (3, '326.172.760-82', 'Ana Narciso', '(21) 9 8733-4321');
	   
	   INSERT INTO Caixa (NRO_INT_Supermercado, NRO_Numero, TP_Caixa, TXT_Status)
VALUES (1, 1, 'PREFERENCIAL', 'DISPONIVEL'),
       (2, 2, 'NORMAL', 'MANUTENCAO'),
       (3, 3, 'RAPIDO', 'DISPONIVEL');
	   
	   INSERT INTO Controle_Caixa (NRO_INT_Caixa, NRO_INT_Funcionario, DTH_Abertura, DTH_Fechamento, VLR_Inicial, VLR_Final)
VALUES (1, 1, '2023-06-16 09:00:00', NULL, 1000.00, NULL),
       (2, 2, '2023-06-17 09:00:00', NULL, 1000.00, NULL),
	   (3, 3, '2023-06-18 09:00:00', NULL, 1000.00, NULL);
	   
	   INSERT INTO Produto (NRO_Codigo_De_Barra, TXT_Nome, TXT_Descricao, TP_Produto, QTD_Produto_Contido)
VALUES ('CDB111111111', 'Arroz', 'Arroz branco', 'SECO', 1),
       ('CDB222222222', 'Skol', 'Lata 350ML', 'BEBIDA', 1),
       ('CDB333333333', 'Caixa Skol', 'Latas 350ML', 'BEBIDA', 6);
	   
	   INSERT INTO Lote (NRO_Nota_Fiscal, DTH_Recebimento, DT_Fabricacao, DT_Vencimento, NRO_INT_Supermercado)
VALUES  (1, '2023-06-23 10:00:00', '2023-06-23', '2023-06-30', 1),
        (2, '2023-06-23 14:30:00', '2023-06-23', '2023-07-07', 2),
        (3, '2023-06-24 09:15:00', '2023-06-24', '2023-07-01', 3);
		

	   INSERT INTO Produto_Estoque (NRO_INT_Produto, NRO_INT_Supermercado, VLR_Venda, VLR_Compra, TXT_Status)
VALUES  (1, 1, 5.99, 0.04, 'DISPONIVEL'),
		(2, 1, 5.99, 0.05, 'DISPONIVEL'),
		(3, 1, 5.99, 0.06, 'DISPONIVEL');
		
	   INSERT INTO Cliente (NRO_CPF, TXT_Nome, NRO_Contato)
VALUES ('082.329.650-40', 'Dorcas Pereira', '(21) 9 8765-4331'),
       ('796.305.020-20', 'Gabriel Setti', '(21) 9 1345-6789'),
	   ('630.179.790-67', 'Ryan Godá', '(21) 9 1111-2889');
	   
	   INSERT INTO Venda (NRO_INT_Cliente, NRO_INT_Supermercado, TXT_Forma_Pagamento, VLR_Total, DTH_Venda, TXT_Status)
VALUES (1, 1, 'Cartão de Crédito', 100.00, '2023-06-22 15:30:00', 'APROVADO'),
       (2, 2,'Dinheiro', 50.00, '2023-06-22 12:00:00', 'CANCELADA'),
	   (NULL, 3, 'Dinheiro', 80.00, '2023-06-22 19:00:00', 'REJEITADO');

INSERT INTO Produto_Venda (NRO_INT_Venda, NRO_INT_Produto_Estoque, NRO_INT_Controle_Caixa)
VALUES (2, 40, 1);
    
	   
	   INSERT INTO Nota_Fiscal (NRO_INT_Venda, NRO_Numero, DTH_Emissao, VLR_ICMS, VLR_IPI, VLR_PIS, VLR_COFINS, VLR_ISS, VLR_Impostos_Totais)
VALUES (1, 133859, '2023-06-22 16:30:00', 10.00, 5.00, 2.50, 2.50, 1.50, 21.50),
       (2, 654321, '2023-06-22 13:00:00', 8.00, 4.00, 2.00, 2.00, 1.20, 17.20),
	   (3, 654371, '2023-06-22 15:00:00', 8.00, 4.00, 2.00, 2.00, 1.20, 17.20);
	   
-- Function (1) --

SELECT * FROM Verificar_Disponibilidade_Caixa(1);

-- Function (2) --

SELECT * FROM Fecha_Caixa (3, '1000.99');

-- Function (3) --

SELECT * FROM Valida_Formato_CPF_Cliente(4);

-- Function (4) -- 

SELECT * FROM Valida_Formato_CNPJ_Supermercado (3);

-- Procedure (1) --

CALL Atualizar_Estoque_Produto_Venda(136963);

-- View (1) --

SELECT * FROM Vendas_Detalhadas; 

-- View (2) --

SELECT * FROM Produtos_Disponiveis_No_Estoque;
	   
-- UPDATE (Testes) --	  

UPDATE Supermercado
SET TXT_Nome = 'Supermercado 222'
WHERE TXT_Nome = 'Supermercado 2';

UPDATE Funcionario
SET TXT_Nome = 'João Carlos'
WHERE NRO_Numero = 0001;

UPDATE Caixa
SET TXT_Status = 'DISPONIVEL'
WHERE NRO_INT_Caixa = 2;

UPDATE Controle_Caixa
SET DTH_Fechamento = NULL, VLR_Final = NULL
WHERE NRO_INT_Caixa = 1;

UPDATE Produto
SET TXT_Descricao = 'Lata 500ml', VLR_Venda = 12.00
WHERE NRO_INT_Produto = 1;

UPDATE Produto_Estoque
SET TXT_Status = 'DISPONIVEL';

UPDATE Cliente
SET NRO_Contato = '(21) 9 9999-9999'
WHERE NRO_INT_Cliente = 1;

UPDATE Venda
SET TXT_Status = 'APROVADO';

UPDATE Venda_Produto
SET NRO_INT_Caixa_Registradora_Controle = 2
WHERE NRO_INT_Venda = 4;

UPDATE Nota_Fiscal
SET NRO_Numero = 654321
WHERE NRO_INT_Nota_Fiscal = 7;

-- DELETE (Testes) --

DELETE FROM Supermercado;

DELETE FROM Funcionario;

DELETE FROM Caixa_Registradora;

DELETE FROM Controle_Caixa_Registradora;

DELETE FROM Produto;

DELETE FROM Produto_Estoque;

DELETE FROM Cliente;

DELETE FROM Venda;

DELETE FROM Produto_Venda;

DELETE FROM Lote;

DELETE FROM Nota_Fiscal;

-- DELETE WHERE (Testes) --

DELETE FROM Supermercado
WHERE CNPJ = '12.345.678/0001-90';

DELETE FROM Funcionario
WHERE NRO_INT_Supermercado = 1;

DELETE FROM Caixa
WHERE TP_Caixa = 'NORMAL';

DELETE FROM Controle_Caixa
WHERE NRO_INT_Caixa = 1;

DELETE FROM Produto
WHERE TP_Produto = 'BEBIDA';

DELETE FROM Produto_Estoque
WHERE TXT_Status = 'DISPONIVEL';

DELETE FROM Cliente
WHERE NRO_CPF = '348.942.690-82';

DELETE FROM Venda
WHERE TXT_Forma_Pagamento = 'DINHEIRO';

DELETE FROM Venda_Produto
WHERE NRO_INT_Caixa_Registradora_Controle = 1;

DELETE FROM Nota_Fiscal
WHERE VLR_Impostos_Totais > 20.00; 







