CREATE TABLE [dbo].[Event]
(
	[EventId] BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[EventTypeId] TINYINT NOT NULL REFERENCES [EventType]([EventTypeId]),
	[EventActionId] INT NOT NULL REFERENCES [EventAction]([EventActionId]),
	[Value] VARCHAR(8000) NOT NULL,
	[CreatedDateTimeUTC] DATETIME2 (7) NOT NULL DEFAULT (getutcdate()),
)
