CREATE TABLE [dbo].[Dim_Classes_Despesas_Receitas]
(
    [id] INT IDENTITY(1,1),
	[uid_dim_classe_receita] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	[cod_classe] VARCHAR(50) NOT NULL PRIMARY KEY,
	[descricao] VARCHAR(150) NOT NULL
);
