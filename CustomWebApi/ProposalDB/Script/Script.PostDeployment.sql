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

DELETE FROM dbo.Role;
INSERT INTO dbo.Role(Id,Name)VALUES(1, 'Admin');
INSERT INTO dbo.Role(Id,Name)VALUES(2, 'Company');
INSERT INTO dbo.Role(Id,Name)VALUES(3, 'User');
