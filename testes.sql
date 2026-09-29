USE control;

INSERT INTO Funcionario
(CPF, Nome, data_nascimento, Funcao, Telefone, Salario)
VALUES
('11111111111', 'João da Silva', '1990-05-15', 'Motorista', '11999990001', 2800.00),
('22222222222', 'Maria Oliveira', '1985-08-20', 'Gerente', '11999990002', 5500.00),
('33333333333', 'Carlos Santos', '1995-02-10', 'Auxiliar', '11999990003', 2200.00),
('44444444444', 'Ana Souza', '1992-11-30', 'RH', '11999990004', 4000.00);

SELECT * FROM Funcionario;

INSERT INTO Usuarios
(Senha, CPF_Funcionario, Email, Nivel_Permissao)
VALUES
('123456', '11111111111', 'joao@empresa.com', 'Motorista'),
('admin123', '22222222222', 'maria@empresa.com', 'GERENTE'),
('senha123', '33333333333', 'carlos@empresa.com', 'USUARIO'),
('rh123', '44444444444', 'ana@empresa.com', 'RH');

SELECT * FROM Usuarios;

INSERT INTO Veiculos
(Placa, Modelo, Marca, Ano, Capacidade_Carga)
VALUES
('ABC1D23', 'FH 540', 'Volvo', 2022, 30000.00),
('DEF4E56', 'Actros 2651', 'Mercedes-Benz', 2023, 33000.00),
('GHI7F89', 'Constellation', 'Volkswagen', 2021, 15000.00);

SELECT * FROM Veiculos;

INSERT INTO Carga
(Descricao, Peso, Origem, Destino, Data_Envio)
VALUES
('Carga de alimentos', 12000.00, 'São Paulo', 'Curitiba', '2026-09-28'),
('Produtos eletrônicos', 8000.00, 'Campinas', 'Rio de Janeiro', '2026-09-29'),
('Materiais de construção', 14000.00, 'Santos', 'Belo Horizonte', '2026-09-30');

SELECT * FROM Carga;

INSERT INTO Banco_de_horas
(CPF_Funcionario, Horas, Data_Registro)
VALUES
('11111111111', 8.50, '2026-09-25'),
('11111111111', 7.00, '2026-09-26'),
('22222222222', 2.50, '2026-09-26'),
('33333333333', 5.00, '2026-09-27');

SELECT * FROM Banco_de_horas;

SELECT
    F.Nome,
    B.Horas,
    B.Data_Registro
FROM Banco_de_horas B
INNER JOIN Funcionario F
    ON B.CPF_Funcionario = F.CPF;

INSERT INTO Abastecimentos
(Id_Veiculo, Data_Abastecimento, Litros, Valor_Total, Posto)
VALUES
(1, '2026-09-25 08:30:00', 350.50, 2450.00, 'Posto Central'),
(2, '2026-09-26 10:15:00', 400.00, 2800.00, 'Posto Avenida'),
(3, '2026-09-27 07:45:00', 250.00, 1750.00, 'Posto Brasil');
SELECT
    V.Placa,
    V.Modelo,
    A.Data_Abastecimento,
    A.Litros,
    A.Valor_Total,
    A.Posto
FROM Abastecimentos A
INNER JOIN Veiculos V
    ON A.Id_Veiculo = V.Id_Veiculo;

INSERT INTO Manutencoes
(Id_Veiculo, Tipo, Descricao, Data_Manutencao, Custo)
VALUES
(1, 'Preventiva', 'Troca de óleo e filtros', '2026-09-20', 850.00),
(2, 'Corretiva', 'Troca do sistema de freios', '2026-09-22', 3200.00),
(3, 'Preventiva', 'Revisão geral', '2026-09-24', 1200.00);

SELECT
    V.Placa,
    V.Modelo,
    M.Tipo,
    M.Descricao,
    M.Data_Manutencao,
    M.Custo
FROM Manutencoes M
INNER JOIN Veiculos V
    ON M.Id_Veiculo = V.Id_Veiculo;


INSERT INTO Viagens
(Id_Veiculo, CPF_Funcionario, Id_Carga, Data_Saida, Data_Chegada, Origem, Destino)
VALUES
(
    1,
    '11111111111',
    1,
    '2026-09-28 06:00:00',
    '2026-09-28 14:00:00',
    'São Paulo',
    'Curitiba'
),
(
    2,
    '11111111111',
    2,
    '2026-09-29 07:00:00',
    NULL,
    'Campinas',
    'Rio de Janeiro'
);

SELECT
    VJ.Id_Viagem,
    F.Nome AS Motorista,
    VE.Placa,
    VE.Modelo,
    C.Descricao AS Carga,
    VJ.Origem,
    VJ.Destino,
    VJ.Data_Saida,
    VJ.Data_Chegada
FROM Viagens VJ
INNER JOIN Funcionario F
    ON VJ.CPF_Funcionario = F.CPF
INNER JOIN Veiculos VE
    ON VJ.Id_Veiculo = VE.Id_Veiculo
LEFT JOIN Carga C
    ON VJ.Id_Carga = C.Id_Carga;

INSERT INTO Multas
(Id_Veiculo, CPF_Funcionario, Data_Multa, Valor, Motivo)
VALUES
(1, '11111111111', '2026-09-15', 195.23, 'Excesso de velocidade'),
(2, '11111111111', '2026-09-18', 130.16, 'Estacionamento irregular');

SELECT
    M.Id_Multa,
    F.Nome AS Motorista,
    V.Placa,
    M.Data_Multa,
    M.Valor,
    M.Motivo
FROM Multas M
INNER JOIN Funcionario F
    ON M.CPF_Funcionario = F.CPF
INNER JOIN Veiculos V
    ON M.Id_Veiculo = V.Id_Veiculo;

/* Salário dos funcionários */

SELECT
    Nome,
    Funcao,
    Salario
FROM Funcionario
ORDER BY Salario DESC;

#Total gasto com abastecimento por veículo#

SELECT
    V.Placa,
    V.Modelo,
    SUM(A.Valor_Total) AS Total_Abastecimento
FROM Abastecimentos A
INNER JOIN Veiculos V
    ON A.Id_Veiculo = V.Id_Veiculo
GROUP BY V.Id_Veiculo, V.Placa, V.Modelo;

#Total de multas por funcionário#

SELECT
    F.Nome,
    COUNT(M.Id_Multa) AS Quantidade_Multas,
    COALESCE(SUM(M.Valor), 0) AS Total_Multas
FROM Funcionario F
LEFT JOIN Multas M
    ON F.CPF = M.CPF_Funcionario
GROUP BY F.CPF, F.Nome;

#Update Teste#
UPDATE Funcionario
SET Salario = 3000.00
WHERE CPF = '11111111111';
#Teste Geral#
SELECT 'Funcionarios' AS Tabela, COUNT(*) AS Registros FROM Funcionario
UNION ALL
SELECT 'Usuarios', COUNT(*) FROM Usuarios
UNION ALL
SELECT 'Cargas', COUNT(*) FROM Carga
UNION ALL
SELECT 'Veiculos', COUNT(*) FROM Veiculos
UNION ALL
SELECT 'Banco de Horas', COUNT(*) FROM Banco_de_horas
UNION ALL
SELECT 'Abastecimentos', COUNT(*) FROM Abastecimentos
UNION ALL
SELECT 'Manutencoes', COUNT(*) FROM Manutencoes
UNION ALL
SELECT 'Viagens', COUNT(*) FROM Viagens
UNION ALL
SELECT 'Multas', COUNT(*) FROM Multas;

#delete#
DELETE FROM Multas
WHERE Id_Multa = 1;




