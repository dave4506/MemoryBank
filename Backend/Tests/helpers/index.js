const http = require('http');

const httpRequest = (postData, postOptions) => {
  const promise = new Promise((resolve, reject) => {
    const req = http.request(postOptions, async (res) => {
      const responce = {};
      responce.status = res.statusCode;
      responce.header = res.headers;
      // console.log(`HEADERS: ${JSON.stringify(res.headers)}`);
      res.setEncoding('utf8');
      res.on('data', (chunk) => {
        responce.data = JSON.parse(chunk);
      });
      res.on('end', () => {
        resolve(responce);
      });
    });

    req.on('error', (e) => {
      reject(e);
    });
    // Write data to request body
    req.write(postData);
    req.end();
  });

  return promise;
};

module.exports = httpRequest;