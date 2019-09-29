# Memory Bank #

This is memory bank.
We remember for those that can't!

# Folder List : #
Starter_App:
> Backend_Code:
    
> Chatter(Frontend_Code):
    
# File list : #
Starter_App:
> Backend_Code:
>> views.py
        
>> urls.py
        
>> settings.py
    
> Chatter(Frontend_Code):
>> AppDelegate.swift 

>> Chatt.swift	

>> ChattTableCell.swift	

>> Info.plist	

>> ViewController.swift

*Members*
* Benjamin Turner (bentur) -- Mobile Development/Visual Design
* Patrick Crowe (patcrowe) -- Backend Development
* Carlos Volante (volantes) -- Backend Development
* Sebastian Fay (sebbyfay) -- Backend Development
* Corbin Stone (stoneco) -- Project Manager
* Stewart Vohra (vohrstew) -- Mobile Development
* David Sun (sundavid) -- Frontend Development

# Running the starter app #
*Steps for how to build and run Chatter*
1. Download the starter app files from the starter app directory
2. Build and run the backend server code
    Login to the Droplet virtual machine by using terminal command ssh root@167.71.84.124 and custom password.  
    
    1. To run a GET request, run http://167.71.84.124/getchatts/ in the browser. 
    
    2. To run POST request:
        a. Open Postman application
        
        b. Create a new request. 
        
        c. Select the POST type for the request type under Request title from the dropdown. 
        
        d. Enter http://167.71.84.124/addchatt/ in the url box next to the request type. 
        
        e. Select the Body tab below and check the raw tab. 
        
        f. Set the message format to JSon, the last tab on the right. 
        
        g. Make sure the Body is a JSon text file, a dictionary containing a username and message keys.
        
        h. Hit SEND. 
    
    3. To run a PUT request:
        a. Open Postman application
        
        b. Create a new request. 
        
        c. Select the POST type for the request type under Request title from the dropdown. 
        
        d. Enter http://167.71.84.124/adduser/ in the url box next to the request type. 
        
        e. Select the Body tab below and check the raw tab. 
        
        f. Set the message format to JSon, the last tab on the right. 
        
        g. Make sure the Body is a JSon text file, a dictionary containing a username, name, and email keys.
        
        h. Hit SEND.
        
     For any of the requests, before running them, if you are logged into the droplet virtual machine, you can run the command service gunicorn restart to restart the application. 
     
3. Build and run the app in xcode
    1. Open the front-end directory in xcode
    2. Click play to build and run the app in the ios simulator
    3. Click in the simulator to interact with the app
    4. Click the stop button to close out of the app, or press Cmd+Q to close the simulator
