create or replace function upa.UPushAuth(@url long varchar)
returns xml
begin

    declare @response xml;
    
    if http_variable('register') = '' then
        set @url = 'register';
    elseif http_variable('activate') = '' then
        set @url = 'activate';
    elseif http_variable('auth') = '' then
        set @url = 'auth';
    elseif http_variable('check-credentials') = '' then
        set @url = 'check-credentials';
    end if;

    case @url
    
        when 'register' then
            set @response = upa.register();
        when 'activate' then
            set @response = upa.activate();
        when 'auth' then
            set @response = upa.auth();
        when 'check-credentials' then
            set @response = upa.checkCredentials();
        
    end case;

    set @response = xmlelement('response', @response);

    return @response;

    -- Пока во всех случаях 404 вернём
    exception  
        when others then 
            call util.errorHandler('upa.UPushAuth',SQLSTATE,errormsg()); 
            
            call dbo.sa_set_http_header('@HttpStatus', '404');

            return '';

end
;