CREATE PROCEDURE [dbo].[EventRetrieve]
	@EventId int = null
AS
set nocount on

select e.EventId, et.ForeignIdentifier as EventTypeForeignIdentifier, ea.[Name] as EventActionName, e.[Value], e.CreatedDateTimeUTC from [Event] as e
inner join EventAction as ea on ea.EventActionId = e.EventActionId
inner join EventType as et on et.EventTypeId = e.EventTypeId
where (e.EventId = @EventId or @EventId is null)
order by e.CreatedDateTimeUTC desc
