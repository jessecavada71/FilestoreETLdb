/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

-- EventType 'Error'
if(not exists(select top 1 1 from EventType where EventTypeId = 1))
begin
	insert into EventType ([EventTypeId], [Name], [ForeignIdentifier]) values (1,'Error','error')
end
else
begin
	update EventType set [Name] = 'Error',  [ForeignIdentifier] = 'error' where EventTypeId = 1
end

-- EventType 'Information'
if(not exists(select top 1 1 from EventType where EventTypeId = 2))
begin
	insert into EventType ([EventTypeId], [Name], [ForeignIdentifier]) values (2,'Information','information')
end
else
begin
	update EventType set [Name] = 'Information',  [ForeignIdentifier] = 'information' where EventTypeId = 2
end

-- EventType 'Warning'
if(not exists(select top 1 1 from EventType where EventTypeId = 3))
begin
	insert into EventType ([EventTypeId], [Name], [ForeignIdentifier]) values (3,'Warning','warning')
end
else
begin
	update EventType set [Name] = 'Warning',  [ForeignIdentifier] = 'warning' where EventTypeId = 3
end

-- EventType 'Security'
if(not exists(select top 1 1 from EventType where EventTypeId = 4))
begin
	insert into EventType ([EventTypeId], [Name], [ForeignIdentifier]) values (4,'Security','security')
end
else
begin
	update EventType set [Name] = 'Security',  [ForeignIdentifier] = 'security' where EventTypeId = 4
end
