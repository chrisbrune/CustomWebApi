﻿/*
Deployment script for TechProposalDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "TechProposalDB"
:setvar DefaultFilePrefix "TechProposalDB"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL13.SQL\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL13.SQL\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [Id]           UNIQUEIDENTIFIER NOT NULL,
    [FirstName]    VARCHAR (MAX)    NOT NULL,
    [LastName]     VARCHAR (MAX)    NOT NULL,
    [Email]        VARCHAR (MAX)    NOT NULL,
    [PasswordHash] BINARY (64)      NOT NULL,
    [Salt]         UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT NEWID() FOR [Id];


GO
PRINT N'Creating [dbo].[uspAddUser]...';


GO
CREATE PROCEDURE dbo.uspAddUser
    @pFirstName NVARCHAR(40) = NULL, 
    @pLastName NVARCHAR(40) = NULL,
    @pEmail NVARCHAR(50), 
    @pPassword NVARCHAR(50),

    @responseMessage bit =0 OUTPUT
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @salt UNIQUEIDENTIFIER=NEWID()
    BEGIN TRY

        INSERT INTO dbo.[User] (FirstName, LastName, Email, PasswordHash, Salt)
        VALUES(@pFirstName, @pLastName, @pEmail, HASHBYTES('SHA2_512', @pPassword+CAST(@salt AS NVARCHAR(36))), @salt)

       SET @responseMessage=1

    END TRY
    BEGIN CATCH
        SET @responseMessage=0
    END CATCH

END
GO
PRINT N'Creating [dbo].[uspLogin]...';


GO
CREATE PROCEDURE dbo.uspLogin
    @pEmail NVARCHAR(254),
    @pPassword NVARCHAR(50),
    @responseMessage bit = 0 OUTPUT
AS
BEGIN

    SET NOCOUNT ON

    DECLARE @userID INT

    IF EXISTS (SELECT TOP 1 Id FROM [dbo].[User] WHERE Email=@pEmail)
    BEGIN
        SET @userID=(SELECT Id FROM [dbo].[User] WHERE Email=@pEmail AND PasswordHash=HASHBYTES('SHA2_512', @pPassword+CAST(Salt AS NVARCHAR(36))))

       IF(@userID IS NULL)
           SET @responseMessage=0
       ELSE 
           SET @responseMessage=1
    END
    ELSE
       SET @responseMessage=0

END
GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

INSERT INTO dbo.Role(Id,Name)VALUES(1, 'Admin');
INSERT INTO dbo.Role(Id,Name)VALUES(2, 'Company');
INSERT INTO dbo.Role(Id,Name)VALUES(3, 'User');
GO

GO
PRINT N'Update complete.';


GO
