CREATE TABLE [dbo].[EventType]
(
	[EventTypeId] TINYINT NOT NULL PRIMARY KEY ([EventTypeId]),
	[Name] VARCHAR(32) NOT NULL UNIQUE NONCLUSTERED ([Name]),
	[ForeignIdentifier] VARCHAR(16) NOT NULL UNIQUE NONCLUSTERED ([ForeignIdentifier])
)
