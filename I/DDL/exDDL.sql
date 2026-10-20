PRAGMA foreign_keys = ON;

CREATE TABLE Maquina (
    CodMaq INTEGER NOT NULL,
    NomeMaq VARCHAR(100) NOT NULL,
    PRIMARY KEY (CodMaq)
);

CREATE TABLE Produto (
    CodProd INTEGER NOT NULL,
    DescProd VARCHAR(100) NOT NULL,
    PESO REAL,
    PRIMARY KEY (CodMaq)
);

CREATE TABLE MaqProd(
    CodMaq INTEGER NOT NULL,
    CodProd INTEGER NOT NULL,
    TEMPO INTEGER NOT NULL,
    PRIMARY KEY (CodMaq, CodProd),
    CONSTRAINT maqprod_fk_1 FOREIGN KEY (CodMaq) REFERENCES Maquina (CodMaq) ON DELETE CASCADE,
    CONSTRAINT maqprod_fk_2 FOREIGN KEY (CodProd) REFERENCES Produto (CodProd) ON DELETE CASCADE
);

CREATE TABLE ComposProd (
    CodProdComposto INTEGER NOT NULL,
    CodProdComponente INTEGER NOT NULL,
    Quant REAL NOT NULL,
    PRIMARY KEY (CodProdComposto, CodProdComponente),
    CONSTRAINT composprod_fk_1 FOREIGN KEY (CodProdComposto) REFERENCES Produto (CodProd) ON DELETE CASCADE,
    CONSTRAINT composprod_fk_2 FOREIGN KEY (CodProdComponente) REFERENCES Produto (CodProd) ON DELETE CASCADE
);




--Q1

PRAGMA foreign_keys = OFF;
BEGIN;
CREATE TABLE Produto_novo (
    CodProd INTEGER NOT NULL,
    DescrProd VARCHAR(100) NOT NULL,
    Peso REAL CHECK (Peso > 0),
    PRIMARY KEY (CodProd)
);
INSERT INTO Produto_novo SELECT CodProd, DescrProd, Peso FROM Produto;
DROP TABLE Produto;
ALTER TABLE Produto_novo RENAME TO Produto;
COMMIT;
PRAGMA foreign_keys = ON;

--Q2

PRAGMA foreign_keys = OFF;
BEGIN;
CREATE TABLE MaqProd_nova (
    CodMaq INTEGER NOT NULL,
    CodProd INTEGER NOT NULL,
    Tempo INTEGER NOT NULL CHECK (Tempo > 0),
    PRIMARY KEY (CodMaq, CodProd),
    CONSTRAINT maqprod_fk_1 FOREIGN KEY (CodMaq) REFERENCES Maquina (CodMaq) ON DELETE CASCADE,
    CONSTRAINT maqprod_fk_2 FOREIGN KEY (CodProd) REFERENCES Produto (CodProd) ON DELETE CASCADE
);
INSERT INTO MaqProd_nova SELECT CodMaq, CodProd, Tempo FROM MaqProd;
DROP TABLE MaqProd;
ALTER TABLE MaqProd_nova RENAME TO MaqProd;
COMMIT;
PRAGMA foreign_keys = ON;

--Q3

PRAGMA foreign_keys = OFF;
BEGIN;
CREATE TABLE Produto_novo (
    CodProd INTEGER NOT NULL,
    DescrProd VARCHAR(100) NOT NULL,
    Peso REAL,
    PRIMARY KEY (CodProd)
);
INSERT INTO Produto_novo SELECT CodProd, DescrProd, Peso FROM Produto;
DROP TABLE Produto;
ALTER TABLE Produto_novo RENAME TO Produto;
COMMIT;
PRAGMA foreign_keys = ON;

--Q4

ALTER TABLE Produto ADD COLUMN PRECO FLOAT;

--Q5

ALTER TABLE ComposProd DROP COLUMN quant;

--Q6

DROP TABLE ComposProd;

--Q7

PRAGMA foreign_keys = OFF;
BEGIN;
CREATE TABLE Maquina_nova (
    CodMaq INTEGER NOT NULL,
    NomeMaq VARCHAR(50) NOT NULL,
    PRIMARY KEY (CodMaq)
);
INSERT INTO Maquina_nova SELECT CodMaq, NomeMaq FROM Maquina;
DROP TABLE Maquina;
ALTER TABLE Maquina_nova RENAME TO Maquina;
COMMIT;
PRAGMA foreign_keys = ON;