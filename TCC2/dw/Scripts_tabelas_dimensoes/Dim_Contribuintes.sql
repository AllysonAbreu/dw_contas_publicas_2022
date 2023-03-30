CREATE TABLE [dbo].[Dim_Contribuintes]
(
	[id] INT IDENTITY(1,1),
	[uid_contribuintes] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	[codigo] VARCHAR(50) NOT NULL PRIMARY KEY,
	[cpf_cnpj] VARCHAR(50) NOT NULL,
	[contribuinte] VARCHAR(500) NOT NULL,
	[fonte_dados] VARCHAR(50) NOT NULL,
);
