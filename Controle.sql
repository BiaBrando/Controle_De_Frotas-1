CREATE DATABASE control;
USE control;

CREATE TABLE Funcionario (
    CPF CHAR(11) PRIMARY KEY NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    Funcao VARCHAR(50) NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    Salario DECIMAL(10,2)NOT NULL
);

CREATE TABLE Usuarios (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Senha VARCHAR(255) NOT NULL,
    CPF_Funcionario CHAR(11) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL,
    Nivel_Permissao ENUM('ADMIN', 'GERENTE', 'USUARIO', 'Motorista', 'RH') NOT NULL,
    FOREIGN KEY (CPF_Funcionario) REFERENCES Funcionario(CPF)
    

);

CREATE TABLE Carga (
    Id_Carga INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(255) NOT NULL,
    Peso DECIMAL(10,2),
    Origem VARCHAR(100),
    Destino VARCHAR(100),
    Data_Envio DATE
    
);

CREATE TABLE Veiculos (
    Id_Veiculo INT AUTO_INCREMENT PRIMARY KEY,
    Placa VARCHAR(10) UNIQUE NOT NULL,
    Modelo VARCHAR(100) NOT NULL,
    Marca VARCHAR(100),
    Ano INT,
    Capacidade_Carga DECIMAL(10,2)
);

CREATE TABLE Banco_de_horas (
    Id_Banco INT AUTO_INCREMENT PRIMARY KEY,
    CPF_Funcionario CHAR(11) NOT NULL,
    Horas DECIMAL(5,2) NOT NULL,
    Data_Registro DATE NOT NULL,
    FOREIGN KEY (CPF_Funcionario) REFERENCES Funcionario(CPF)
);

CREATE TABLE Abastecimentos (
    Id_Abastecimento INT AUTO_INCREMENT PRIMARY KEY,
    Id_Veiculo INT NOT NULL,
    Data_Abastecimento DATETIME NOT NULL,
    Litros DECIMAL(10,2) NOT NULL,
    Valor_Total DECIMAL(10,2) NOT NULL,
    Posto VARCHAR(100),
    FOREIGN KEY (Id_Veiculo) REFERENCES Veiculos(Id_Veiculo)
);

CREATE TABLE Manutencoes (
    Id_Manutencao INT AUTO_INCREMENT PRIMARY KEY,
    Id_Veiculo INT NOT NULL,
    Tipo VARCHAR(100),
    Descricao TEXT,
    Data_Manutencao DATE NOT NULL,
    Custo DECIMAL(10,2),
    FOREIGN KEY (Id_Veiculo) REFERENCES Veiculos(Id_Veiculo)
);

CREATE TABLE Viagens (
    Id_Viagem INT AUTO_INCREMENT PRIMARY KEY,
    Id_Veiculo INT NOT NULL,
    CPF_Funcionario CHAR(11) NOT NULL,
    Id_Carga INT,
    Data_Saida DATETIME,
    Data_Chegada DATETIME,
    Origem VARCHAR(100) NOT NULL,
    Destino VARCHAR(100) NOT NULL,
    FOREIGN KEY (Id_Veiculo) REFERENCES Veiculos(Id_Veiculo),
    FOREIGN KEY (CPF_Funcionario) REFERENCES Funcionario(CPF), 
    FOREIGN KEY (Id_Carga) REFERENCES Carga(Id_Carga)
);

CREATE TABLE Multas (
    Id_Multa INT AUTO_INCREMENT PRIMARY KEY,
    Id_Veiculo INT NOT NULL,
    CPF_Funcionario CHAR(11) NOT NULL,
    Data_Multa DATE NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Motivo VARCHAR(255),
    FOREIGN KEY (Id_Veiculo) REFERENCES Veiculos(Id_Veiculo),
    FOREIGN KEY (CPF_Funcionario) REFERENCES Funcionario(CPF) 
);


