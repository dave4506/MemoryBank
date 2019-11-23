module.exports = {
  mongoURL: `mongodb+srv://${process.env.MONGO_USER}:${process.env.MONGO_PASSWORD}@cluster0-ia6d9.mongodb.net/test?retryWrites=true&w=majority`,
  mongoSSL: true,
  jwtSecret: 'mysecret',
  bucketName: 'stewartvhr-umich-eecs441',
  collectionId: 'memorybankcollection',
  AWS_accessKeyId: `${process.env.AWS_ACCESSKEYID}`,
  AWS_secretAccessKey: `${process.env.AWS_SECRETACCESSKEY}`,
}
