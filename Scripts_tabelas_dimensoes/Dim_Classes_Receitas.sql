CREATE TABLE [dbo].[Dim_Classes_Receitas]
(
  id INT IDENTITY(1,1) PRIMARY KEY,
  uid_classe_receitas UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
  cod_classe_receita VARCHAR(50) NULL,
  descricao_receita VARCHAR(150) NULL
);
GO