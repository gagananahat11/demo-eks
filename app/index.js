const express = require('express');
const app = express();


// Read runtime ENV variables
const PORT = process.env.PORT || 3000;
const APP_NAME = process.env.APP_NAME || 'demo-app';
const GREETING = process.env.GREETING || 'Hello from demo app!';


app.get('/', (req, res) => {
res.json({
app: APP_NAME,
greeting: GREETING,
built_from: process.env.BUILD_VERSION || 'unknown',
build_time: process.env.BUILD_TIME || 'unknown'
});
});


app.listen(PORT, () => {
console.log(`Server ${APP_NAME} listening on port ${PORT}`);
});