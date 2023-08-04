const express = require('express');
const bodyParser = require('body-parser');
const flash = require('connect-flash');

const app = express();
const port = 5000;

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

const apiRoutes = express.Router();

app.use('/api', apiRoutes);

app.use(flash());
require('./routes/routes')(app);

app.listen(port, function () {
    console.log('Server is running on Port:', port);
});
