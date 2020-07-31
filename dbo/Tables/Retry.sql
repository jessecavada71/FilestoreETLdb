CREATE TABLE [dbo].[Retry]
(
	[RetryId] BIGINT NOT NULL PRIMARY KEY IDENTITY (1,1),
	[Value] NVARCHAR(256) COLLATE SQL_Latin1_General_CP1_CS_AS NOT NULL UNIQUE,
	[ReceivedOnUTC] DATETIME2 NOT NULL,
	[CreatedDateTimeUTC] DATETIME2 (7) NOT NULL DEFAULT (getutcdate()),
)

GO

CREATE UNIQUE INDEX [IX_Retry_RetryId-Value-ReceivedOnUTC] ON [dbo].[Retry] ([RetryId], [Value], [ReceivedOnUTC])

GO

CREATE TRIGGER [dbo].[Trigger_Retry]
    ON [dbo].[Retry]
    FOR UPDATE
    AS
    BEGIN
        SET NoCount ON

        -- Constraint violation: Duplicate ReceivedOnUTC'
        if exists(select top 1 1 from inserted as i
            inner join deleted as d on d.RetryId = i.RetryId
            where not i.ReceivedOnUTC = d.ReceivedOnUTC
            and exists(select top 1 1 from Retry as r where not r.RetryId = i.RetryId and r.ReceivedOnUTC = i.ReceivedOnUTC)
            )
 			begin
				rollback transaction
				raiserror ('Constraint violation: Duplicate ReceivedOnUTC', 16, 1)
			end           
    END
GO

