CREATE TABLE [dbo].[Dim_Contribuinte_Despesa]
(
id INT IDENTITY(1,1) PRIMARY KEY,
codigo INT NOT NULL,
cpf_cnpj VARCHAR(50) NOT NULL,
contribuinte VARCHAR(500) NOT NULL,
fonte_dados_despesas VARCHAR(50) NOT NULL,
id_fonte_dados INT NOT NULL,
uid_contribuinte_despesas UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
CONSTRAINT FK_dim_contribuinte_despesa_id_fonte_dados FOREIGN KEY (id_fonte_dados) REFERENCES Dim_Fonte_Dados(Id)
);
GO
