CREATE PROCEDURE [dbo].[EventCreate]
	@Action varchar(256),
	@Type varchar(16),
	@Value varchar(8000)
AS
set nocount on

declare @EventActionId int = (select EventActionId from EventAction where [Name] = @Action)

if @EventActionId is null
	insert into EventAction ([Name]) values (@Action)
	set @EventActionId = SCOPE_IDENTITY()

insert into [Event] (EventTypeId, EventActionId, [Value]) values ((select EventTypeId from EventType where ForeignIdentifier = @Type), @EventActionId, @Value)

select cast(SCOPE_IDENTITY() as bigint) as EventId

