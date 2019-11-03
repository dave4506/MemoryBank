# Memory Bank App S3 Skeltal Feature

This uses the Amazon Cognito Identity Provider found in the AWS Mobile SDK for iOS for sign up and sign in so one can use the skeltal feature to upload or download image file from S3.

## Requirements

* iOS 8 and later
* On the backend in AWS Management Console, you need to configure a Cognito User Pool and a Cognito Identity Pool to use with this app. The configuration of the backend Cognito service is used in Constants.swift file.

## Using the S3 Image Upload Feature

1. If you are using the app for the first time, Sign Up and verify your email.

2. Sign In to the App using username and password.

3. In the Upload to S3 view of the app, use the tap gesture on image viewer to take a new picture using the camera, or use swipe right gesture to select image from camera library to upload to S3

4. If the image upload is successful, you should see an alert showing the key of the file uploaded to S3. Note this key if you would like to download this file later.
