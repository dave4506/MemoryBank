# Memory Bank #

This is memory bank.
We remember for those that can't!

# Folder List : #
Backend:
> config:

> helpers:

> models:

> routes:

> services:

MemoryBank:
> MemoryBank:

> MemoryBank.xcodeproj:

> MemoryBankTests:

> MemoryBankUITests:

MemoryBank.xcodeproj:

Memory_Bank_App:
> Backend_Code:
>> MVP_Features:
>> Skeletal_Features:

> Frontend_Code:
>> MVP_Features:
>> Skeletal_Features:

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
├── MemoryBank.xcodeproj
│   └── project.xcworkspace
│       └── contents.xcworkspacedata
├── Memory_Bank_App
│   ├── Backend_Code
│   │   ├── MVP_Features
│   │   │   └── README.md
│   │   ├── README.md
│   │   └── Skeletal_Features
│   │       └── README.md
│   ├── Frontend_Code
│   │   ├── MVP_Features
│   │   │   └── README.md
│   │   ├── README.md
│   │   └── Skeletal_Features
│   │       ├── README.md
│   │       ├── SF_2
│   │       │   └── memory_bank_app
│   │       │       ├── Podfile
│   │       │       ├── Podfile.lock
│   │       │       ├── Pods
│   │       │       │   ├── AWSCognitoIdentityProvider
│   │       │       │   │   ├── AWSCognitoIdentityProvider
│   │       │       │   │   │   ├── AWSCognitoIdentityProvider.h
│   │       │       │   │   │   ├── AWSCognitoIdentityUser.h
│   │       │       │   │   │   ├── AWSCognitoIdentityUser.m
│   │       │       │   │   │   ├── AWSCognitoIdentityUserPool.h
│   │       │       │   │   │   ├── AWSCognitoIdentityUserPool.m
│   │       │       │   │   │   ├── CognitoIdentityProvider
│   │       │       │   │   │   │   ├── AWSCognitoIdentityProviderModel.h
│   │       │       │   │   │   │   ├── AWSCognitoIdentityProviderModel.m
│   │       │       │   │   │   │   ├── AWSCognitoIdentityProviderResources.h
│   │       │       │   │   │   │   ├── AWSCognitoIdentityProviderResources.m
│   │       │       │   │   │   │   ├── AWSCognitoIdentityProviderService.h
│   │       │       │   │   │   │   └── AWSCognitoIdentityProviderService.m
│   │       │       │   │   │   └── Internal
│   │       │       │   │   │       ├── AWSCognitoIdentityProviderHKDF.h
│   │       │       │   │   │       ├── AWSCognitoIdentityProviderHKDF.m
│   │       │       │   │   │       ├── AWSCognitoIdentityProviderSrpHelper.h
│   │       │       │   │   │       ├── AWSCognitoIdentityProviderSrpHelper.m
│   │       │       │   │   │       ├── AWSCognitoIdentityUserPool_Internal.h
│   │       │       │   │   │       ├── AWSCognitoIdentityUser_Internal.h
│   │       │       │   │   │       ├── JKBigInteger
│   │       │       │   │   │       │   ├── AWSJKBigDecimal.h
│   │       │       │   │   │       │   ├── AWSJKBigDecimal.m
│   │       │       │   │   │       │   ├── AWSJKBigInteger.h
│   │       │       │   │   │       │   ├── AWSJKBigInteger.m
│   │       │       │   │   │       │   └── LibTomMath
│   │       │       │   │   │       │       ├── aws_tommath.h
│   │       │       │   │   │       │       ├── aws_tommath_class.h
│   │       │       │   │   │       │       ├── aws_tommath_superclass.h
│   │       │       │   │   │       │       └── tommath.c
│   │       │       │   │   │       ├── NSData+AWSCognitoIdentityProvider.h
│   │       │       │   │   │       └── NSData+AWSCognitoIdentityProvider.m
│   │       │       │   │   ├── LICENSE
│   │       │       │   │   ├── LICENSE.APACHE
│   │       │       │   │   └── README.md
│   │       │       │   ├── AWSCognitoIdentityProviderASF
│   │       │       │   │   ├── AWSCognitoIdentityProviderASF
│   │       │       │   │   │   ├── AWSCognitoIdentityProviderASF.h
│   │       │       │   │   │   ├── AWSCognitoIdentityProviderASF.m
│   │       │       │   │   │   └── Internal
│   │       │       │   │   │       ├── AWSCognitoIdentityASF.h
│   │       │       │   │   │       └── libAWSCognitoIdentityProviderASFBinary.a
│   │       │       │   │   ├── LICENSE
│   │       │       │   │   ├── LICENSE.AMAZON
│   │       │       │   │   ├── LICENSE.APACHE
│   │       │       │   │   └── README.md
│   │       │       │   ├── AWSCore
│   │       │       │   │   ├── AWSCore
│   │       │       │   │   │   ├── AWSCore.h
│   │       │       │   │   │   ├── Authentication
│   │       │       │   │   │   │   ├── AWSCredentialsProvider.h
│   │       │       │   │   │   │   ├── AWSCredentialsProvider.m
│   │       │       │   │   │   │   ├── AWSIdentityProvider.h
│   │       │       │   │   │   │   ├── AWSIdentityProvider.m
│   │       │       │   │   │   │   ├── AWSSignature.h
│   │       │       │   │   │   │   └── AWSSignature.m
│   │       │       │   │   │   ├── Bolts
│   │       │       │   │   │   │   ├── AWSBolts.h
│   │       │       │   │   │   │   ├── AWSBolts.m
│   │       │       │   │   │   │   ├── AWSCancellationToken.h
│   │       │       │   │   │   │   ├── AWSCancellationToken.m
│   │       │       │   │   │   │   ├── AWSCancellationTokenRegistration.h
│   │       │       │   │   │   │   ├── AWSCancellationTokenRegistration.m
│   │       │       │   │   │   │   ├── AWSCancellationTokenSource.h
│   │       │       │   │   │   │   ├── AWSCancellationTokenSource.m
│   │       │       │   │   │   │   ├── AWSExecutor.h
│   │       │       │   │   │   │   ├── AWSExecutor.m
│   │       │       │   │   │   │   ├── AWSGeneric.h
│   │       │       │   │   │   │   ├── AWSTask.h
│   │       │       │   │   │   │   ├── AWSTask.m
│   │       │       │   │   │   │   ├── AWSTaskCompletionSource.h
│   │       │       │   │   │   │   └── AWSTaskCompletionSource.m
│   │       │       │   │   │   ├── CognitoIdentity
│   │       │       │   │   │   │   ├── AWSCognitoIdentity+Fabric.h
│   │       │       │   │   │   │   ├── AWSCognitoIdentity+Fabric.m
│   │       │       │   │   │   │   ├── AWSCognitoIdentity.h
│   │       │       │   │   │   │   ├── AWSCognitoIdentityModel.h
│   │       │       │   │   │   │   ├── AWSCognitoIdentityModel.m
│   │       │       │   │   │   │   ├── AWSCognitoIdentityResources.h
│   │       │       │   │   │   │   ├── AWSCognitoIdentityResources.m
│   │       │       │   │   │   │   ├── AWSCognitoIdentityService.h
│   │       │       │   │   │   │   └── AWSCognitoIdentityService.m
│   │       │       │   │   │   ├── FMDB
│   │       │       │   │   │   │   ├── AWSFMDB+AWSHelpers.h
│   │       │       │   │   │   │   ├── AWSFMDB+AWSHelpers.m
│   │       │       │   │   │   │   ├── AWSFMDB.h
│   │       │       │   │   │   │   ├── AWSFMDatabase+Private.h
│   │       │       │   │   │   │   ├── AWSFMDatabase.h
│   │       │       │   │   │   │   ├── AWSFMDatabase.m
│   │       │       │   │   │   │   ├── AWSFMDatabaseAdditions.h
│   │       │       │   │   │   │   ├── AWSFMDatabaseAdditions.m
│   │       │       │   │   │   │   ├── AWSFMDatabasePool.h
│   │       │       │   │   │   │   ├── AWSFMDatabasePool.m
│   │       │       │   │   │   │   ├── AWSFMDatabaseQueue.h
│   │       │       │   │   │   │   ├── AWSFMDatabaseQueue.m
│   │       │       │   │   │   │   ├── AWSFMResultSet.h
│   │       │       │   │   │   │   └── AWSFMResultSet.m
│   │       │       │   │   │   ├── Fabric
│   │       │       │   │   │   │   ├── FABAttributes.h
│   │       │       │   │   │   │   ├── FABKitProtocol.h
│   │       │       │   │   │   │   ├── Fabric+FABKits.h
│   │       │       │   │   │   │   └── Fabric.h
│   │       │       │   │   │   ├── GZIP
│   │       │       │   │   │   │   ├── AWSGZIP.h
│   │       │       │   │   │   │   └── AWSGZIP.m
│   │       │       │   │   │   ├── KSReachability
│   │       │       │   │   │   │   ├── AWSKSReachability.h
│   │       │       │   │   │   │   └── AWSKSReachability.m
│   │       │       │   │   │   ├── Logging
│   │       │       │   │   │   │   ├── AWSCocoaLumberjack.h
│   │       │       │   │   │   │   ├── AWSDDASLLogCapture.h
│   │       │       │   │   │   │   ├── AWSDDASLLogCapture.m
│   │       │       │   │   │   │   ├── AWSDDASLLogger.h
│   │       │       │   │   │   │   ├── AWSDDASLLogger.m
│   │       │       │   │   │   │   ├── AWSDDAbstractDatabaseLogger.h
│   │       │       │   │   │   │   ├── AWSDDAbstractDatabaseLogger.m
│   │       │       │   │   │   │   ├── AWSDDAssertMacros.h
│   │       │       │   │   │   │   ├── AWSDDFileLogger.h
│   │       │       │   │   │   │   ├── AWSDDFileLogger.m
│   │       │       │   │   │   │   ├── AWSDDLegacyMacros.h
│   │       │       │   │   │   │   ├── AWSDDLog+LOGV.h
│   │       │       │   │   │   │   ├── AWSDDLog.h
│   │       │       │   │   │   │   ├── AWSDDLog.m
│   │       │       │   │   │   │   ├── AWSDDLogMacros.h
│   │       │       │   │   │   │   ├── AWSDDMultiFormatter.m
│   │       │       │   │   │   │   ├── AWSDDOSLogger.h
│   │       │       │   │   │   │   ├── AWSDDOSLogger.m
│   │       │       │   │   │   │   ├── AWSDDTTYLogger.h
│   │       │       │   │   │   │   ├── AWSDDTTYLogger.m
│   │       │       │   │   │   │   └── Extensions
│   │       │       │   │   │   │       ├── AWSDDContextFilterLogFormatter.h
│   │       │       │   │   │   │       ├── AWSDDContextFilterLogFormatter.m
│   │       │       │   │   │   │       ├── AWSDDDispatchQueueLogFormatter.h
│   │       │       │   │   │   │       ├── AWSDDDispatchQueueLogFormatter.m
│   │       │       │   │   │   │       └── AWSDDMultiFormatter.h
│   │       │       │   │   │   ├── Mantle
│   │       │       │   │   │   │   ├── AWSMTLJSONAdapter.h
│   │       │       │   │   │   │   ├── AWSMTLJSONAdapter.m
│   │       │       │   │   │   │   ├── AWSMTLManagedObjectAdapter.h
│   │       │       │   │   │   │   ├── AWSMTLManagedObjectAdapter.m
│   │       │       │   │   │   │   ├── AWSMTLModel+NSCoding.h
│   │       │       │   │   │   │   ├── AWSMTLModel+NSCoding.m
│   │       │       │   │   │   │   ├── AWSMTLModel.h
│   │       │       │   │   │   │   ├── AWSMTLModel.m
│   │       │       │   │   │   │   ├── AWSMTLReflection.h
│   │       │       │   │   │   │   ├── AWSMTLReflection.m
│   │       │       │   │   │   │   ├── AWSMTLValueTransformer.h
│   │       │       │   │   │   │   ├── AWSMTLValueTransformer.m
│   │       │       │   │   │   │   ├── AWSMantle.h
│   │       │       │   │   │   │   ├── NSArray+AWSMTLManipulationAdditions.h
│   │       │       │   │   │   │   ├── NSArray+AWSMTLManipulationAdditions.m
│   │       │       │   │   │   │   ├── NSDictionary+AWSMTLManipulationAdditions.h
│   │       │       │   │   │   │   ├── NSDictionary+AWSMTLManipulationAdditions.m
│   │       │       │   │   │   │   ├── NSError+AWSMTLModelException.h
│   │       │       │   │   │   │   ├── NSError+AWSMTLModelException.m
│   │       │       │   │   │   │   ├── NSObject+AWSMTLComparisonAdditions.h
│   │       │       │   │   │   │   ├── NSObject+AWSMTLComparisonAdditions.m
│   │       │       │   │   │   │   ├── NSValueTransformer+AWSMTLInversionAdditions.h
│   │       │       │   │   │   │   ├── NSValueTransformer+AWSMTLInversionAdditions.m
│   │       │       │   │   │   │   ├── NSValueTransformer+AWSMTLPredefinedTransformerAdditions.h
│   │       │       │   │   │   │   ├── NSValueTransformer+AWSMTLPredefinedTransformerAdditions.m
│   │       │       │   │   │   │   └── extobjc
│   │       │       │   │   │   │       ├── AWSEXTKeyPathCoding.h
│   │       │       │   │   │   │       ├── AWSEXTRuntimeExtensions.h
│   │       │       │   │   │   │       ├── AWSEXTRuntimeExtensions.m
│   │       │       │   │   │   │       ├── AWSEXTScope.h
│   │       │       │   │   │   │       ├── AWSEXTScope.m
│   │       │       │   │   │   │       └── AWSmetamacros.h
│   │       │       │   │   │   ├── Networking
│   │       │       │   │   │   │   ├── AWSNetworking.h
│   │       │       │   │   │   │   ├── AWSNetworking.m
│   │       │       │   │   │   │   ├── AWSURLSessionManager.h
│   │       │       │   │   │   │   └── AWSURLSessionManager.m
│   │       │       │   │   │   ├── STS
│   │       │       │   │   │   │   ├── AWSSTS.h
│   │       │       │   │   │   │   ├── AWSSTSModel.h
│   │       │       │   │   │   │   ├── AWSSTSModel.m
│   │       │       │   │   │   │   ├── AWSSTSResources.h
│   │       │       │   │   │   │   ├── AWSSTSResources.m
│   │       │       │   │   │   │   ├── AWSSTSService.h
│   │       │       │   │   │   │   └── AWSSTSService.m
│   │       │       │   │   │   ├── Serialization
│   │       │       │   │   │   │   ├── AWSSerialization.h
│   │       │       │   │   │   │   ├── AWSSerialization.m
│   │       │       │   │   │   │   ├── AWSURLRequestRetryHandler.h
│   │       │       │   │   │   │   ├── AWSURLRequestRetryHandler.m
│   │       │       │   │   │   │   ├── AWSURLRequestSerialization.h
│   │       │       │   │   │   │   ├── AWSURLRequestSerialization.m
│   │       │       │   │   │   │   ├── AWSURLResponseSerialization.h
│   │       │       │   │   │   │   ├── AWSURLResponseSerialization.m
│   │       │       │   │   │   │   ├── AWSValidation.h
│   │       │       │   │   │   │   └── AWSValidation.m
│   │       │       │   │   │   ├── Service
│   │       │       │   │   │   │   ├── AWSClientContext.h
│   │       │       │   │   │   │   ├── AWSClientContext.m
│   │       │       │   │   │   │   ├── AWSInfo.h
│   │       │       │   │   │   │   ├── AWSInfo.m
│   │       │       │   │   │   │   ├── AWSService.h
│   │       │       │   │   │   │   ├── AWSService.m
│   │       │       │   │   │   │   └── AWSServiceEnum.h
│   │       │       │   │   │   ├── TMCache
│   │       │       │   │   │   │   ├── AWSTMCache.h
│   │       │       │   │   │   │   ├── AWSTMCache.m
│   │       │       │   │   │   │   ├── AWSTMCacheBackgroundTaskManager.h
│   │       │       │   │   │   │   ├── AWSTMDiskCache.h
│   │       │       │   │   │   │   ├── AWSTMDiskCache.m
│   │       │       │   │   │   │   ├── AWSTMMemoryCache.h
│   │       │       │   │   │   │   └── AWSTMMemoryCache.m
│   │       │       │   │   │   ├── UICKeyChainStore
│   │       │       │   │   │   │   ├── AWSUICKeyChainStore.h
│   │       │       │   │   │   │   └── AWSUICKeyChainStore.m
│   │       │       │   │   │   ├── Utility
│   │       │       │   │   │   │   ├── AWSCategory.h
│   │       │       │   │   │   │   ├── AWSCategory.m
│   │       │       │   │   │   │   ├── AWSLogging.h
│   │       │       │   │   │   │   ├── AWSLogging.m
│   │       │       │   │   │   │   ├── AWSModel.h
│   │       │       │   │   │   │   ├── AWSModel.m
│   │       │       │   │   │   │   ├── AWSSynchronizedMutableDictionary.h
│   │       │       │   │   │   │   └── AWSSynchronizedMutableDictionary.m
│   │       │       │   │   │   ├── XMLDictionary
│   │       │       │   │   │   │   ├── AWSXMLDictionary.h
│   │       │       │   │   │   │   └── AWSXMLDictionary.m
│   │       │       │   │   │   └── XMLWriter
│   │       │       │   │   │       ├── AWSXMLWriter.h
│   │       │       │   │   │       └── AWSXMLWriter.m
│   │       │       │   │   ├── LICENSE
│   │       │       │   │   ├── LICENSE.APACHE
│   │       │       │   │   └── README.md
│   │       │       │   ├── AWSDynamoDB
│   │       │       │   │   ├── AWSDynamoDB
│   │       │       │   │   │   ├── AWSDynamoDB.h
│   │       │       │   │   │   ├── AWSDynamoDBModel.h
│   │       │       │   │   │   ├── AWSDynamoDBModel.m
│   │       │       │   │   │   ├── AWSDynamoDBObjectMapper.h
│   │       │       │   │   │   ├── AWSDynamoDBObjectMapper.m
│   │       │       │   │   │   ├── AWSDynamoDBRequestRetryHandler.h
│   │       │       │   │   │   ├── AWSDynamoDBRequestRetryHandler.m
│   │       │       │   │   │   ├── AWSDynamoDBResources.h
│   │       │       │   │   │   ├── AWSDynamoDBResources.m
│   │       │       │   │   │   ├── AWSDynamoDBService.h
│   │       │       │   │   │   └── AWSDynamoDBService.m
│   │       │       │   │   ├── LICENSE
│   │       │       │   │   ├── LICENSE.APACHE
│   │       │       │   │   └── README.md
│   │       │       │   ├── AWSRekognition
│   │       │       │   │   ├── AWSRekognition
│   │       │       │   │   │   ├── AWSRekognition.h
│   │       │       │   │   │   ├── AWSRekognitionModel.h
│   │       │       │   │   │   ├── AWSRekognitionModel.m
│   │       │       │   │   │   ├── AWSRekognitionResources.h
│   │       │       │   │   │   ├── AWSRekognitionResources.m
│   │       │       │   │   │   ├── AWSRekognitionService.h
│   │       │       │   │   │   └── AWSRekognitionService.m
│   │       │       │   │   ├── LICENSE
│   │       │       │   │   ├── LICENSE.APACHE
│   │       │       │   │   └── README.md
│   │       │       │   ├── AWSS3
│   │       │       │   │   ├── AWSS3
│   │       │       │   │   │   ├── AWSS3.h
│   │       │       │   │   │   ├── AWSS3Model.h
│   │       │       │   │   │   ├── AWSS3Model.m
│   │       │       │   │   │   ├── AWSS3PreSignedURL.h
│   │       │       │   │   │   ├── AWSS3PreSignedURL.m
│   │       │       │   │   │   ├── AWSS3RequestRetryHandler.h
│   │       │       │   │   │   ├── AWSS3RequestRetryHandler.m
│   │       │       │   │   │   ├── AWSS3Resources.h
│   │       │       │   │   │   ├── AWSS3Resources.m
│   │       │       │   │   │   ├── AWSS3Serializer.h
│   │       │       │   │   │   ├── AWSS3Serializer.m
│   │       │       │   │   │   ├── AWSS3Service.h
│   │       │       │   │   │   ├── AWSS3Service.m
│   │       │       │   │   │   ├── AWSS3TransferManager.h
│   │       │       │   │   │   ├── AWSS3TransferManager.m
│   │       │       │   │   │   ├── AWSS3TransferUtility+HeaderHelper.h
│   │       │       │   │   │   ├── AWSS3TransferUtility+HeaderHelper.m
│   │       │       │   │   │   ├── AWSS3TransferUtility+Validation.m
│   │       │       │   │   │   ├── AWSS3TransferUtility.h
│   │       │       │   │   │   ├── AWSS3TransferUtility.m
│   │       │       │   │   │   ├── AWSS3TransferUtilityDatabaseHelper.h
│   │       │       │   │   │   ├── AWSS3TransferUtilityDatabaseHelper.m
│   │       │       │   │   │   ├── AWSS3TransferUtilityTasks.h
│   │       │       │   │   │   └── AWSS3TransferUtilityTasks.m
│   │       │       │   │   ├── LICENSE
│   │       │       │   │   ├── LICENSE.APACHE
│   │       │       │   │   └── README.md
│   │       │       │   ├── Manifest.lock
│   │       │       │   ├── Pods.xcodeproj
│   │       │       │   │   ├── project.pbxproj
│   │       │       │   │   └── xcuserdata
│   │       │       │   │       └── stewartvhr.xcuserdatad
│   │       │       │   │           └── xcschemes
│   │       │       │   │               ├── AWSCognitoIdentityProvider.xcscheme
│   │       │       │   │               ├── AWSCognitoIdentityProviderASF.xcscheme
│   │       │       │   │               ├── AWSCore.xcscheme
│   │       │       │   │               ├── AWSDynamoDB.xcscheme
│   │       │       │   │               ├── AWSRekognition.xcscheme
│   │       │       │   │               ├── AWSS3.xcscheme
│   │       │       │   │               ├── Pods-creko.xcscheme
│   │       │       │   │               └── xcschememanagement.plist
│   │       │       │   └── Target Support Files
│   │       │       │       ├── AWSCognitoIdentityProvider
│   │       │       │       │   ├── AWSCognitoIdentityProvider-Info.plist
│   │       │       │       │   ├── AWSCognitoIdentityProvider-dummy.m
│   │       │       │       │   ├── AWSCognitoIdentityProvider-prefix.pch
│   │       │       │       │   ├── AWSCognitoIdentityProvider-umbrella.h
│   │       │       │       │   ├── AWSCognitoIdentityProvider.modulemap
│   │       │       │       │   └── AWSCognitoIdentityProvider.xcconfig
│   │       │       │       ├── AWSCognitoIdentityProviderASF
│   │       │       │       │   ├── AWSCognitoIdentityProviderASF-Info.plist
│   │       │       │       │   ├── AWSCognitoIdentityProviderASF-dummy.m
│   │       │       │       │   ├── AWSCognitoIdentityProviderASF-prefix.pch
│   │       │       │       │   ├── AWSCognitoIdentityProviderASF-umbrella.h
│   │       │       │       │   ├── AWSCognitoIdentityProviderASF.modulemap
│   │       │       │       │   └── AWSCognitoIdentityProviderASF.xcconfig
│   │       │       │       ├── AWSCore
│   │       │       │       │   ├── AWSCore-Info.plist
│   │       │       │       │   ├── AWSCore-dummy.m
│   │       │       │       │   ├── AWSCore-prefix.pch
│   │       │       │       │   ├── AWSCore-umbrella.h
│   │       │       │       │   ├── AWSCore.modulemap
│   │       │       │       │   └── AWSCore.xcconfig
│   │       │       │       ├── AWSDynamoDB
│   │       │       │       │   ├── AWSDynamoDB-Info.plist
│   │       │       │       │   ├── AWSDynamoDB-dummy.m
│   │       │       │       │   ├── AWSDynamoDB-prefix.pch
│   │       │       │       │   ├── AWSDynamoDB-umbrella.h
│   │       │       │       │   ├── AWSDynamoDB.modulemap
│   │       │       │       │   └── AWSDynamoDB.xcconfig
│   │       │       │       ├── AWSRekognition
│   │       │       │       │   ├── AWSRekognition-Info.plist
│   │       │       │       │   ├── AWSRekognition-dummy.m
│   │       │       │       │   ├── AWSRekognition-prefix.pch
│   │       │       │       │   ├── AWSRekognition-umbrella.h
│   │       │       │       │   ├── AWSRekognition.modulemap
│   │       │       │       │   └── AWSRekognition.xcconfig
│   │       │       │       ├── AWSS3
│   │       │       │       │   ├── AWSS3-Info.plist
│   │       │       │       │   ├── AWSS3-dummy.m
│   │       │       │       │   ├── AWSS3-prefix.pch
│   │       │       │       │   ├── AWSS3-umbrella.h
│   │       │       │       │   ├── AWSS3.modulemap
│   │       │       │       │   └── AWSS3.xcconfig
│   │       │       │       └── Pods-creko
│   │       │       │           ├── Pods-creko-Info.plist
│   │       │       │           ├── Pods-creko-acknowledgements.markdown
│   │       │       │           ├── Pods-creko-acknowledgements.plist
│   │       │       │           ├── Pods-creko-dummy.m
│   │       │       │           ├── Pods-creko-frameworks.sh
│   │       │       │           ├── Pods-creko-umbrella.h
│   │       │       │           ├── Pods-creko.debug.xcconfig
│   │       │       │           ├── Pods-creko.modulemap
│   │       │       │           └── Pods-creko.release.xcconfig
│   │       │       ├── README.md
│   │       │       ├── _DS_Store
│   │       │       ├── memorybank
│   │       │       │   ├── AppDelegate.swift
│   │       │       │   ├── Assets.xcassets
│   │       │       │   │   └── AppIcon.appiconset
│   │       │       │   │       └── Contents.json
│   │       │       │   ├── Base.lproj
│   │       │       │   │   └── Main.storyboard
│   │       │       │   ├── Celebrity.swift
│   │       │       │   ├── CognitoUserPoolIdentityProvider.swift
│   │       │       │   ├── CognitoYourUserPoolsSample.entitlements.xml
│   │       │       │   ├── ConfirmForgotPasswordViewController.swift
│   │       │       │   ├── ConfirmSignUpViewController.swift
│   │       │       │   ├── Constants.swift
│   │       │       │   ├── ForgotPasswordViewController.swift
│   │       │       │   ├── Info.plist
│   │       │       │   ├── MFAViewController.swift
│   │       │       │   ├── MFAViewController.xib
│   │       │       │   ├── S3ImageDownloadViewController.swift
│   │       │       │   ├── S3ImageUploadViewController.swift
│   │       │       │   ├── SignInViewController.swift
│   │       │       │   ├── SignUpViewController.swift
│   │       │       │   └── utils.swift
│   │       │       ├── memorybank.xcodeproj
│   │       │       │   ├── project.pbxproj
│   │       │       │   ├── project.xcworkspace
│   │       │       │   │   ├── contents.xcworkspacedata.xml
│   │       │       │   │   ├── xcshareddata
│   │       │       │   │   │   ├── IDEWorkspaceChecks.plist
│   │       │       │   │   │   └── WorkspaceSettings.xcsettings.xml
│   │       │       │   │   └── xcuserdata
│   │       │       │   │       ├── ajayvohr.xcuserdatad
│   │       │       │   │       │   ├── UserInterfaceState.xcuserstate
│   │       │       │   │       │   └── WorkspaceSettings.xcsettings.xml
│   │       │       │   │       ├── benjaminturner.xcuserdatad
│   │       │       │   │       │   └── UserInterfaceState.xcuserstate
│   │       │       │   │       └── stewartvhr.xcuserdatad
│   │       │       │   │           └── UserInterfaceState.xcuserstate
│   │       │       │   ├── xcshareddata
│   │       │       │   │   └── xcschemes
│   │       │       │   │       ├── creko.xcscheme.xml
│   │       │       │   │       └── memorybank.xcscheme
│   │       │       │   └── xcuserdata
│   │       │       │       ├── ajayvohr.xcuserdatad
│   │       │       │       │   └── xcschemes
│   │       │       │       │       └── xcschememanagement.plist
│   │       │       │       └── stewartvhr.xcuserdatad
│   │       │       │           └── xcschemes
│   │       │       │               └── xcschememanagement.plist
│   │       │       └── memorybank.xcworkspace
│   │       │           ├── contents.xcworkspacedata
│   │       │           ├── contents.xcworkspacedata.xml
│   │       │           ├── xcshareddata
│   │       │           │   └── IDEWorkspaceChecks.plist
│   │       │           └── xcuserdata
│   │       │               ├── ajayvohr.xcuserdatad
│   │       │               │   ├── UserInterfaceState.xcuserstate
│   │       │               │   └── xcdebugger
│   │       │               │       └── Breakpoints_v2.xcbkptlist.xml
│   │       │               └── stewartvhr.xcuserdatad
│   │       │                   ├── UserInterfaceState.xcuserstate
│   │       │                   └── xcdebugger
│   │       │                       └── Breakpoints_v2.xcbkptlist
│   │       └── SF_7
│   │           ├── README.txt
│   │           └── Simple_Camera_App
│   │               ├── Simple_Camera_App
│   │               │   ├── AppDelegate.swift
│   │               │   ├── Assets.xcassets
│   │               │   │   ├── AppIcon.appiconset
│   │               │   │   │   └── Contents.json
│   │               │   │   ├── Contents.json
│   │               │   │   └── defaultPhoto.imageset
│   │               │   │       ├── 736E2151-AAF2-482B-B63B-D87848EDCD21_1_105_c.jpeg
│   │               │   │       └── Contents.json
│   │               │   ├── Base.lproj
│   │               │   │   ├── LaunchScreen.storyboard
│   │               │   │   └── Main.storyboard
│   │               │   ├── CustomButton.swift
│   │               │   ├── Info.plist
│   │               │   └── ViewController.swift
│   │               ├── Simple_Camera_App.xcodeproj
│   │               │   ├── project.pbxproj
│   │               │   ├── project.xcworkspace
│   │               │   │   ├── contents.xcworkspacedata
│   │               │   │   ├── xcshareddata
│   │               │   │   │   └── IDEWorkspaceChecks.plist
│   │               │   │   └── xcuserdata
│   │               │   │       ├── benjaminturner.xcuserdatad
│   │               │   │       │   └── UserInterfaceState.xcuserstate
│   │               │   │       └── stewartvhr.xcuserdatad
│   │               │   │           └── UserInterfaceState.xcuserstate
│   │               │   └── xcuserdata
│   │               │       ├── benjaminturner.xcuserdatad
│   │               │       │   └── xcschemes
│   │               │       │       └── xcschememanagement.plist
│   │               │       └── stewartvhr.xcuserdatad
│   │               │           ├── xcdebugger
│   │               │           │   └── Breakpoints_v2.xcbkptlist
│   │               │           └── xcschemes
│   │               │               └── xcschememanagement.plist
│   │               ├── Simple_Camera_AppTests
│   │               │   ├── Info.plist
│   │               │   └── Simple_Camera_AppTests.swift
│   │               └── Simple_Camera_AppUITests
│   │                   ├── Info.plist
│   │                   └── Simple_Camera_AppUITests.swift
│   └── README.md
├── README.md
├── Routes
│   ├── Dockerfile
│   ├── heroku.yml
│   ├── staging.tf
│   └── swagger.json
├── StarterApp-Frontend
│   ├── Backend_Code
│   │   ├── settings.py
│   │   ├── urls.py
│   │   └── views.py
│   ├── Chatter
│   │   ├── AppDelegate.swift
│   │   ├── Assets.xcassets
│   │   │   └── AppIcon.appiconset
│   │   │       └── Contents.json
│   │   ├── Base.lproj
│   │   │   ├── LaunchScreen.storyboard
│   │   │   └── Main.storyboard
│   │   ├── Chatt.swift
│   │   ├── ChattTableCell.swift
│   │   ├── Info.plist
│   │   └── ViewController.swift
│   └── Chatter.xcodeproj
│       ├── project.pbxproj
│       ├── project.xcworkspace
│       │   ├── contents.xcworkspacedata
│       │   ├── xcshareddata
│       │   │   └── IDEWorkspaceChecks.plist
│       │   └── xcuserdata
│       │       └── sebastianfay.xcuserdatad
│       │           └── UserInterfaceState.xcuserstate
│       └── xcuserdata
│           ├── sebastianfay.xcuserdatad
│           │   └── xcschemes
│           │       └── xcschememanagement.plist
│           └── tiberiuvilcu.xcuserdatad
│               └── xcschemes
│                   ├── Chatter.xcscheme
│                   └── xcschememanagement.plist
└── Starter_App
    └── Backend_Code
        ├── settings.py
        ├── urls.py
        └── views.py
```
