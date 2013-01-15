UPushAuth
============

activate
------------
activates registered device

### variables:

* device_id - guid of registered device
* activation_code - activation code pushed to device by register service

### returns:

"activate" element. If guid of device and/or activation code is invalid then http-status 403 ("Forbidden")

    <response>
        <activate>yes</activate>
    </response>

auth
------------
authentificates registered device for "client" (application on device)

### variables:

* client_id - client code
* redirect_uri - "upush://" + device guid
    
### returns:

"code" element - activation code for device/client and authentification attempt id

pushes new client secret to device through Apple services.

    <response>
        <code>yes</code>
        <id>10101</id>
    </response>


check-credentials
------------
checks device/client authentification

### variables:

* client_id - client code
* client_secret - unused
* account_code - activation code for device/client
* account_secret - client secret pushed by auth service
* redirect_uri - "upush://" + device guid

### returns:

device type string and device guid if succesfull

    <response>
        <type>iPhone</type>
        <xid>000-999-000</xid>
    </response>

register
------------
registers new device

### variables:

* push_token - Apple push token for device
* device_type - device type name ("iPhone", "iPad" etc)

### returns:

"activation_needed" element and device guid.

pushes activation code to device through Apple services.

    <response>
        <device_id>000-999-0000-0000</device_id>
        <activation_needed>true</activation_needed>
    </response>