create global temporary table if not exists upa.pushMessageLog(
    pushToken long varchar,
    msg long varchar,
    response long varchar,

    id ID, xid GUID, ts TS, cts CTS,
    unique (xid), primary key (id)
    
)  not transactional share by all
;

create global temporary table upa.log(

    service varchar(64),
    pushToken long varchar,
    deviceType varchar(256),
    deviceId varchar(256),
    applicationId varchar(128),
    activationCode varchar(1024),
    clientId varchar(256),
    clientSecret varchar(1024),
    accountCode varchar(1024),
    accountSecret varchar(1024),
    redirectUrl long varchar,
    
    response long varchar,

    callerIP varchar(128) default coalesce(nullif(http_header('clientIp'),''), connection_property('ClientNodeAddress')),

    id ID, xid GUID, ts TS, cts CTS,
    unique (xid), primary key (id)
    
)  not transactional share by all
;

