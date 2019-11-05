# Memory Bank #

This is memory bank.
We remember for those that can't!

# Running App: #
1. Install app on phone via usb cable using Xcode. 

2. Build and Run app and follow prompts on screen. 

# Folder List : #
Backend:
> Tests:

>> helpers:


> config:

> helpers:

> models:

> routes:

> services:

frontend:
> memory_bank_app:

>> memorybank.xcodeproj:

>>> xcshareddata:

>>> project.xcworkspace:

>>> xcshareddata/xcschemes:

>> memorybank.xcworkspace:

>>> xcshareddata:

>> memorybank:

>>>Assets.xcassets/AppIcon.appiconset:

>>>Base.lproj:

> Skeletal_Features:

>> SF_2:

>>> memory_bank_app:

>>>> memorybank.xcworkspace:

>> SF_7:

>>> Simple_Camera_App:

>>>> Simple_Camera_App.xcodeproj:

>>>>> project.xcworkspace:

>>>>>> xcshareddata:

>>>> Simple_Camera_App:

>>>>> Assets.xcassets:

>>>>>> AppIcon.appiconset:

>>>>>> defaultPhoto.imageset:

>>>>> Base.lproj:

>>>> Simple_Camera_AppTests:

>>>> Simple_Camera_AppUITests:

Routes:

Starter_App:
> Backend_Code:
    
StarterApp-Frontend:
> Backend_Code:

> Chatter(Frontend_Code):
    
Full File list is at the end of this file.

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
    
    
# File list : #
```
.
├── Backend
│   ├── Dockerfile.dev
│   ├── README.md
│   ├── Tests
│   │   ├── helpers
│   │   │   └── index.js
│   │   └── signup.test.js
│   ├── config
│   │   ├── dev.js
│   │   ├── keys.js
│   │   └── prod.js
│   ├── helpers
│   │   └── authentication.js
│   ├── heroku.yml
│   ├── index.js
│   ├── models
│   │   ├── Event.js
│   │   └── User.js
│   ├── package-lock.json
│   ├── package.json
│   ├── routes
│   │   ├── authRoutes.js
│   │   ├── eventRoutes.js
│   │   └── index.js
│   ├── services
│   │   └── passport.js
│   └── staging.tf
├── README.md
├── Routes
│   ├── Dockerfile
│   ├── heroku.yml
│   ├── staging.tf
│   └── swagger.json
├── Starter_App
│   ├── backend
│   │   ├── settings.py
│   │   ├── urls.py
│   │   └── views.py
│   └── frontend
│       ├── Backend_Code
│       │   ├── settings.py
│       │   ├── urls.py
│       │   └── views.py
│       ├── Chatter
│       │   ├── AppDelegate.swift
│       │   ├── Assets.xcassets
│       │   │   └── AppIcon.appiconset
│       │   │       └── Contents.json
│       │   ├── Base.lproj
│       │   │   ├── LaunchScreen.storyboard
│       │   │   └── Main.storyboard
│       │   ├── Chatt.swift
│       │   ├── ChattTableCell.swift
│       │   ├── Info.plist
│       │   └── ViewController.swift
│       └── Chatter.xcodeproj
│           ├── project.pbxproj
│           └── project.xcworkspace
│               ├── contents.xcworkspacedata
│               └── xcshareddata
│                   └── IDEWorkspaceChecks.plist
└── frontend
    ├── README.md
    ├── Skeletal_Features
    │   ├── README.md
    │   └── SF_7
    │       ├── README.txt
    │       └── Simple_Camera_App
    │           ├── Simple_Camera_App
    │           │   ├── AppDelegate.swift
    │           │   ├── Assets.xcassets
    │           │   │   ├── AppIcon.appiconset
    │           │   │   │   └── Contents.json
    │           │   │   ├── Contents.json
    │           │   │   └── defaultPhoto.imageset
    │           │   │       ├── 736E2151-AAF2-482B-B63B-D87848EDCD21_1_105_c.jpeg
    │           │   │       └── Contents.json
    │           │   ├── Base.lproj
    │           │   │   ├── LaunchScreen.storyboard
    │           │   │   └── Main.storyboard
    │           │   ├── CustomButton.swift
    │           │   ├── Info.plist
    │           │   └── ViewController.swift
    │           ├── Simple_Camera_App.xcodeproj
    │           │   ├── project.pbxproj
    │           │   └── project.xcworkspace
    │           │       ├── contents.xcworkspacedata
    │           │       └── xcshareddata
    │           │           └── IDEWorkspaceChecks.plist
    │           ├── Simple_Camera_AppTests
    │           │   ├── Info.plist
    │           │   └── Simple_Camera_AppTests.swift
    │           └── Simple_Camera_AppUITests
    │               ├── Info.plist
    │               └── Simple_Camera_AppUITests.swift
    └── memory_bank_app
        ├── Podfile
        ├── Podfile.lock
        ├── README.md
        ├── memorybank
        │   ├── AppDelegate.swift
        │   ├── Assets.xcassets
        │   │   └── AppIcon.appiconset
        │   │       └── Contents.json
        │   ├── Base.lproj
        │   │   └── Main.storyboard
        │   ├── Celebrity.swift
        │   ├── CognitoUserPoolIdentityProvider.swift
        │   ├── CognitoYourUserPoolsSample.entitlements.xml
        │   ├── ConfirmForgotPasswordViewController.swift
        │   ├── ConfirmSignUpViewController.swift
        │   ├── Constants.swift
        │   ├── ForgotPasswordViewController.swift
        │   ├── Info.plist
        │   ├── MFAViewController.swift
        │   ├── MFAViewController.xib
        │   ├── S3ImageDownloadViewController.swift
        │   ├── S3ImageUploadViewController.swift
        │   ├── SignInViewController.swift
        │   ├── SignUpViewController.swift
        │   └── utils.swift
        ├── memorybank.xcodeproj
        │   ├── project.pbxproj
        │   ├── project.xcworkspace
        │   │   ├── contents.xcworkspacedata.xml
        │   │   └── xcshareddata
        │   │       ├── IDEWorkspaceChecks.plist
        │   │       └── WorkspaceSettings.xcsettings.xml
        │   └── xcshareddata
        │       └── xcschemes
        │           ├── creko.xcscheme.xml
        │           └── memorybank.xcscheme
        └── memorybank.xcworkspace
            ├── contents.xcworkspacedata
            ├── contents.xcworkspacedata.xml
            └── xcshareddata
                └── IDEWorkspaceChecks.plist
```
