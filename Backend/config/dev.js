module.exports = {
  mongoURL: `mongodb+srv://${process.env.MONGO_USER}:${process.env.MONGO_PASSWORD}@cluster0-ia6d9.mongodb.net/test?retryWrites=true&w=majority`,
  mongoSSL: true,
  jwtSecret: 'mysecret',
  bucketName: 'memoryBank',
}
