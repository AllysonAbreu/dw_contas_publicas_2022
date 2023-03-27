CREATE TABLE [dbo].[Dim_Classes_Despesas]
(
	[uid_dim_classe_receita] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    [id] INT IDENTITY(1,1) PRIMARY KEY,
	[cod_despesa] VARCHAR(50) NULL,
	[descricao_despesa] VARCHAR(150) NULL
);
