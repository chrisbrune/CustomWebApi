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
	