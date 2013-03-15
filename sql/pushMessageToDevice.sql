create or replace procedure upa.pushMessageToDevice(@deviceId integer, @message long varchar)
begin
    declare @pushToken long varchar;
    declare @applicationId long varchar;
    declare @response long varchar;
    declare @xid uniqueidentifier;
    
    select pushToken,
           applicationId
      into @pushToken, @applicationId
      from upa.device
     where id = @deviceId;
                       
    if @pushToken is null then
        return;
    end if;
    
    set @xid = newid();
    
    set @message = '{"aps":{},"unact":{' + @message + '}}}}';
    
    insert into upa.pushMessageLog with auto name
    select @xid as xid,
           @pushToken as pushToken,
           @message as msg;
    
    set @response = upa.pushNotification(
        util.getUserOption('UPAapnsUrl') + '/' + @applicationId,
        util.getUserOption('UPAapnsCert'),
        @pushToken,
        @message);
    
    update upa.pushMessageLog
       set response = @response
     where xid = @xid;

end
;
