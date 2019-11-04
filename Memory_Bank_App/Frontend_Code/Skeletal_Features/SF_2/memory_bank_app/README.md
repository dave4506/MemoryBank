# Memory Bank App S3 Skeltal Feature

This uses the Amazon Cognito Identity Provider found in the AWS Mobile SDK for iOS for sign up and sign in so one can use the skeltal feature to upload or download image file from S3.

## Requirements

* iOS 8 and later
* On the backend in AWS Management Console, you need to configure a Cognito User Pool, a Cognito Identity Pool, and a S3 Bucket to use with this app. The configuration of the backend Cognito service is used in Constants.swift file.
* Configuration Steps:
* Step 1. In AWS Management Console, set up a Cognito User Pool and implement desired signin settings.
* Step 2. In AWS Management Console, set up app with app client id and secret, if desired. This allows your app to access this Cognito User Pool to confirm user sign-in credentials.  
* Step 3. From Cognitio User Pool, extract pool id, pool region, and app client id and secret. 
* Step 4. In AWS Managment Console, set up Identity Pool and extract identity pool id from it. 
* Step 5. The above constants go into the Constants.swift file; the user pool id is appended to the end of the CognitoUserPoolsSignInProviderKey after the string 'cognito-idp.<pool region>.amazonaws.com/'. 
* Step 6. Set up S3 Bucket and put bucket id in Constants.swift file

## Using the S3 Image Upload Feature

1. If you are using the app for the first time, Sign Up and verify your email.

2. Sign In to the App using username and password.

3. In the Upload to S3 view of the app, use the tap gesture on image viewer to take a new picture using the camera, or use swipe right gesture to select image from camera library to upload to S3

4. If the image upload is successful, you should see an alert showing the key of the file uploaded to S3. Note this key(which is the string after 'username/images/') if you would like to download this file later. If the upload fails, you shuld get an alert indicating that the upload had failed due to a specific error. 

## Using the S3 Image Download Feature

1. If you are using the app for the first time, Sign Up and verify your email. 

2. Sign In to the App using username and password. 

3. Use the S3 Image Upload Feature to upload an image as described above. 

4. In the Download S3 view of the app, accessible by pressing the Next button inthe Upload Image View, type in the key that you noted from the alert showing the details of your image upload to S3. 

5. Next, click the Download Image button, and the downloaded image should appear on your screen. You will not be able to download an image with a blank key input and you will not be able to do so while typing in the key input. If the download was not successful, there should be an alert indicating that the download hadfailed due to a specific error.

##To Run the App:

1. Build and Run the app in Xcode. 

2. Click on the app icon that appears with the name memorybank on your iphone.   

