CREATE PROCEDURE dbo.uspLogin
    @pEmail NVARCHAR(max),
    @pPassword NVARCHAR(max),
    @responseMessage bit = 0 OUTPUT
AS
BEGIN

    SET NOCOUNT ON

    DECLARE @userID UNIQUEIDENTIFIER= NEWID();

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