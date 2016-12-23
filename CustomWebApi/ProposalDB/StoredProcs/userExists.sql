CREATE PROCEDURE dbo.userExists
    @pEmail NVARCHAR(max),
    @responseMessage bit = 0 OUTPUT
AS
BEGIN

    SET NOCOUNT ON

    DECLARE @userID UNIQUEIDENTIFIER= NEWID();

   SET @userID=(SELECT Id FROM [dbo].[User] WHERE Email=@pEmail);
       
	   IF(@userID IS NULL)
           SET @responseMessage=0
       ELSE 
           SET @responseMessage=1
   

END