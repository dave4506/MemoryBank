/* global test expect:true */

const request = require('./helpers/index');

test('handles correct signup', async () => {
  const postData = JSON.stringify({
    email: 'new_email@gmail.com',
    displayName: 'New User',
    password: 'password',
  });

  // An object of options to indicate where to post to
  const postOptions = {
    host: 'localhost',
    port: '1234',
    path: '/auth/signup',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(postData),
    },
  };

  const res = await request(postData, postOptions);

  expect(res.status).toEqual(200);
  expect(res.data).toHaveProperty('message');
});

test('handles repeated email', async () => {
  const postData = JSON.stringify({
    email: 'new_email@gmail.com',
    displayName: 'New User',
    password: 'password',
  });

  // An object of options to indicate where to post to
  const postOptions = {
    host: 'localhost',
    port: '1234',
    path: '/auth/signup',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(postData),
    },
  };

  const res = await request(postData, postOptions);

  expect(res.status).toEqual(409);
  expect(res.data).toHaveProperty('error');
});

test('handles incomplete signup (no data)', async () => {
  const postData = JSON.stringify({});

  // An object of options to indicate where to post to
  const postOptions = {
    host: 'localhost',
    port: '1234',
    path: '/auth/signup',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(postData),
    },
  };

  const res = await request(postData, postOptions);

  expect(res.status).toEqual(400);
  expect(res.data).toHaveProperty('error');
});

test('handles incomplete signup (no email)', async () => {
  const postData = JSON.stringify({
    displayName: 'New User',
    password: 'password',
  });


  // An object of options to indicate where to post to
  const postOptions = {
    host: 'localhost',
    port: '1234',
    path: '/auth/signup',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(postData),
    },
  };

  const res = await request(postData, postOptions);

  expect(res.status).toEqual(400);
  expect(res.data).toHaveProperty('error');
});

test('handles incomplete signup (no displayName)', async () => {
  const postData = JSON.stringify({
    email: 'noDisplay@gmail.com',
    password: 'password',
  });


  // An object of options to indicate where to post to
  const postOptions = {
    host: 'localhost',
    port: '1234',
    path: '/auth/signup',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(postData),
    },
  };

  const res = await request(postData, postOptions);

  expect(res.status).toEqual(400);
  expect(res.data).toHaveProperty('error');
});

test('handles incomplete signup (no password)', async () => {
  const postData = JSON.stringify({
    email: 'noPassword@gmail.com',
    displayName: 'New User',
  });


  // An object of options to indicate where to post to
  const postOptions = {
    host: 'localhost',
    port: '1234',
    path: '/auth/signup',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(postData),
    },
  };

  const res = await request(postData, postOptions);

  expect(res.status).toEqual(400);
  expect(res.data).toHaveProperty('error');
});

test('handles incorrect email', async () => {
  const postData = JSON.stringify({
    email: 'incorrect@gmail',
    displayName: 'New User',
    password: 'password',
  });

  // An object of options to indicate where to post to
  const postOptions = {
    host: 'localhost',
    port: '1234',
    path: '/auth/signup',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(postData),
    },
  };

  const res = await request(postData, postOptions);

  expect(res.status).toEqual(400);
  expect(res.data).toHaveProperty('error');
});