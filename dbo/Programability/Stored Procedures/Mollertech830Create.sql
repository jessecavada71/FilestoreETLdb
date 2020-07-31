CREATE PROCEDURE [dbo].[Mollertech830Create]
	@RetryIdentifier NVARCHAR(256),
	@ReceivedOnUTC DATETIME2,
	@Mollertech830Type Mollertech830Type readonly
AS

if not exists(select top 1 1 from @Mollertech830Type)
	throw 50000, N'@Mollertech830Type is empty', 1

Declare @RetryId bigint = (select RetryId from Retry where [Value] = @RetryIdentifier)

if @RetryId is null
begin
	begin try
		begin transaction
			insert into Retry ([Value], [ReceivedOnUTC]) values (@RetryIdentifier, @ReceivedOnUTC)
			set @RetryId = SCOPE_IDENTITY()

			insert into Mollertech830 (RetryId, TransmissionDatetime, [Datetime], CustomerNumber, PlantNo, ConRefNo, ItemNoCust, ItemNoVend, DueDate, Qty, UnMeas, CumOld, CumNew, DateZero, AsnNo, [Address], City, [State])
			select @RetryId, TransmissionDatetime, [Datetime], CustomerNumber, PlantNo, ConRefNo, ItemNoCust, ItemNoVend, DueDate, Qty, UnMeas, CumOld, CumNew, DateZero, AsnNo, [Address], City, [State] from @Mollertech830Type

		commit transaction
	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback transaction

		select -1 as RetryId, ERROR_MESSAGE() as ErrorMessage, 'Line #' + cast(ERROR_LINE() as varchar(10)) as Line
	end catch
end

select cast(@RetryId as bigint) as RetryId