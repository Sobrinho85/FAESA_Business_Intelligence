-- Define a codificação de caracteres
CREATE DATABASE covid19 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE covid19;


-- Define a tabela Dimensão Tempo
CREATE TABLE Dimensao_Tempo (
    ID_Tempo INT PRIMARY KEY,
    Data DATE,
    Dia_Semana VARCHAR(20),
    Dia_Mes INT,
    Mes INT,
    Ano INT
);

-- Define a tabela Dimensão Comodidade
CREATE TABLE Dimensao_Comodidade (
    ID_Comodidade INT PRIMARY KEY,
    Tipo_Comodidade VARCHAR(20)
);

-- Define a tabela Dimensão Localidade
CREATE TABLE Dimensao_Localidade (
    ID_Localidade INT PRIMARY KEY,
    Pais VARCHAR(50),
    Estado VARCHAR(50),
    Cidade VARCHAR(50),
    CEP VARCHAR(10),
    Latitude DECIMAL(10,6),
    Longitude DECIMAL(10,6)
);

-- Define a tabela Dimensão Faixa Etária
CREATE TABLE Dimensao_Faixa_Etaria (
    ID_FaixaEtaria INT PRIMARY KEY,
    Faixa_Etaria VARCHAR(10)
);

-- Define a tabela Dimensão Gênero
CREATE TABLE Dimensao_Genero (
    ID_Genero INT PRIMARY KEY,
    Genero VARCHAR(20)
);

-- Define a tabela Fato Mortes por Covid-19
CREATE TABLE Fato_Mortes_Covid19 (
    ID_Morte INT PRIMARY KEY,
    ID_Tempo INT,
    ID_Comodidade INT,
    ID_Localidade INT,
    ID_FaixaEtaria INT,
    ID_Genero INT,
    Numero_Mortes INT,
    CONSTRAINT FK_Tempo FOREIGN KEY (ID_Tempo) REFERENCES Dimensao_Tempo(ID_Tempo),
    CONSTRAINT FK_Comodidade FOREIGN KEY (ID_Comodidade) REFERENCES Dimensao_Comodidade(ID_Comodidade),
    CONSTRAINT FK_Localidade FOREIGN KEY (ID_Localidade) REFERENCES Dimensao_Localidade(ID_Localidade),
    CONSTRAINT FK_FaixaEtaria FOREIGN KEY (ID_FaixaEtaria) REFERENCES Dimensao_Faixa_Etaria(ID_FaixaEtaria),
    CONSTRAINT FK_Genero FOREIGN KEY (ID_Genero) REFERENCES Dimensao_Genero(ID_Genero)
);


ALTER TABLE Fato_Mortes_Covid19
    ADD Latitude DECIMAL(10,6);
    
ALTER TABLE Fato_Mortes_Covid19
    ADD Longitude DECIMAL(10,6);
    
ALTER TABLE Fato_Mortes_Covid19
    ADD Data DATE;
    
ALTER TABLE Fato_Mortes_Covid19
    ADD Pais VARCHAR(50);
    
ALTER TABLE Fato_Mortes_Covid19
    ADD Estado VARCHAR(50);
    
ALTER TABLE Fato_Mortes_Covid19
    ADD Cidade VARCHAR(50);
    
ALTER TABLE Fato_Mortes_Covid19
    ADD CEP VARCHAR(50);




-- Define outras restrições e configurações
ALTER TABLE Fato_Mortes_Covid19
    ADD CONSTRAINT CK_Numero_Mortes CHECK (Numero_Mortes >= 0);

ALTER TABLE Fato_Mortes_Covid19
    ADD CONSTRAINT FK_Morte_Tempo_Comodidade UNIQUE (ID_Morte, ID_Tempo, ID_Comodidade);

ALTER TABLE Fato_Mortes_Covid19
    ADD CONSTRAINT FK_Morte_Localidade_FaixaEtaria_Genero UNIQUE (ID_Morte, ID_Localidade, ID_FaixaEtaria, ID_Genero);

ALTER TABLE Fato_Mortes_Covid19
    ADD CONSTRAINT FK_Localidade_Latitude_Longitude UNIQUE (ID_Localidade, Latitude, Longitude);

ALTER TABLE Fato_Mortes_Covid19
    ADD CONSTRAINT FK_Tempo_Data UNIQUE (ID_Tempo, Data);

ALTER TABLE Fato_Mortes_Covid19
    ADD CONSTRAINT FK_Localidade_Pais_Estado_Cidade_CEP UNIQUE (ID_Localidade, Pais, Estado, Cidade, CEP);
    
ALTER TABLE Fato_Mortes_Covid19
    ENGINE=InnoDB
    DEFAULT CHARSET=utf8mb4
    COLLATE=utf8mb4_unicode_ci;
    
SHOW TABLES;
