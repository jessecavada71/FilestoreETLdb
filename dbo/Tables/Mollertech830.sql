CREATE TABLE [dbo].[Mollertech830]
(
	[Mollertech830Id] BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[RetryId] BIGINT NOT NULL REFERENCES [Retry] ([RetryId]),
	[TransmissionDatetime] VARCHAR(8) NOT NULL,
	[Datetime] VARCHAR(8) NOT NULL,
	[CustomerNumber] NUMERIC(12) NOT NULL,
	[PlantNo] VARCHAR(50) NOT NULL,
	[ConRefNo] VARCHAR(50) NOT NULL,
	[ItemNoCust] VARCHAR(50) NOT NULL,
	[ItemNoVend] VARCHAR(250) NULL,
	[DueDate] VARCHAR(8) NOT NULL,
	[Qty] NUMERIC(12) NOT NULL,
	[UnMeas] VARCHAR(5) NOT NULL,
	[CumOld] NUMERIC(12) NULL,
	[CumNew] NUMERIC(12) NOT NULL,
	[DateZero] VARCHAR(8) NOT NULL,
	[AsnNo] VARCHAR(11) NULL,
	[Address] VARCHAR(250) NOT NULL,
	[City] VARCHAR(50) NOT NULL,
	[State] VARCHAR(20) NOT NULL
)

GO

CREATE UNIQUE INDEX [IX_Mollertech830_Mollertech830Id-ItemNoCust-DueDate-Qty-Address-City-State] ON [dbo].[Mollertech830] ([Mollertech830Id], [ItemNoCust], [DueDate], [Qty], [Address], [City], [State])

GO

CREATE TRIGGER [dbo].[Trigger_Mollertech830]
    ON [dbo].[Mollertech830]
    FOR INSERT, UPDATE
    AS
    BEGIN
        SET NoCount ON

		-- Constraint violation: Conflicting quantities
		if exists(select top 1 1 from inserted)
		begin
			if exists(select top 1 1 from inserted as i
				inner join Retry as r on r.RetryId = i.RetryId
				where exists(select top 1 1 from Mollertech830 as m
					inner join Retry as r2 on r2.RetryId = m.RetryId
					where not i.Mollertech830Id = m.Mollertech830Id and i.ItemNoCust = m.ItemNoCust and i.DueDate = m.DueDate and i.[Address] = m.[Address] and i.City = m.City and i.[State] = m.[State] and r.ReceivedOnUTC = r2.ReceivedOnUTC and not i.Qty = m.Qty
				)
				)
				begin
					rollback transaction
					raiserror ('Constraint violation: Conflicting quantities', 16, 1)
				end
		end
    END
GO
