### Express Skeleton

This is the backend code for the app. It is an Express app built out in Javascript.
We are using MongoDB for authentication. The user model can be found in the models
folder and the authentication routes can be found in the routes/authRoutes.js folder.

The driver of the authentication is a system called passport that allows the backend
to keep track of user registration and when a user is logged in and is making
requests to the backend. This code can be found in services/passport.js

Other code necessary for the authentication aspect of the backend is found in the
helpers folder. Specifically, the JWT tokens that notify the backend when a
user is currently logged in.

We are also using mongoDB for storing the events. The event model can be found
in the models folder and the routes associated with events (creation, sharing,
deleting and getting) can be found in the routes/eventRoutes.js folder.

### Deployment

This app is currently deployed and running on Heroku. The application is deployed using Terraform, the Infrastructure Code is on the file staging.tf. The heroku deployment specification (specifying the Dockerfile) are inside the heroku.yml file and the Dockerfile specification on the Dockerfile.dev file. In order to deploy, you need two enviroment variables (HEROKU_EMAIL and HEROKU_API_KEY) which you can get from your Heroku account. After that you can deploy using the $ terraform apply command. To destroy the remote instance use $ terraform destroy.

### Directory structure
This is a tree output that excludes the node_modules, which are packages needed for node (there are thousands and would have polluted the output)
```
├── Dockerfile.dev
├── README.md
├── config
│   ├── dev.js
│   ├── keys.js
│   └── prod.js
├── helpers
│   └── authentication.js
├── heroku.yml
├── index.js
├── models
│   ├── Event.js
│   └── User.js
├── package-lock.json
├── package.json
├── routes
│   ├── authRoutes.js
│   ├── eventRoutes.js
│   ├── index.js
│   ├── messagingRoutes.js
│   ├── rekognitionRoutes.js
│   └── s3Routes.js
├── services
│   └── passport.js
└── staging.tf
```

### Deploying

Required for deployment of the backend are:
 - Terraform CLI

The commands to run within the /Backend directory are:

```
$ terraform init    # if you haven't yet initialized Terraform
$ terraform apply   # due to a bug in heroku, you might need to perform this command twice
```

$terraform apply will require you to provide 4 environment variables:

 - MONGO_USER
 - MONGO_PASSWORD
 - AWS_ACCESSKEYID
 - AWS_SECRETACCESSKEY

 For security purposes, these are not to be published to git, please reach out if these are required.
