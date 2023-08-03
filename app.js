const express = require('express');
const bodyParser = require('body-parser');
const flash = require('connect-flash');

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

const apiRoutes = express.Router();

app.use('/api', apiRoutes);

app.use(flash());

// require('./routes/chatbot.routes')(app);
// require('./routes/analyze/analyze.staff.routes')(app);
// require('./routes/analyze/analyze.manage.routes')(app);
// require('./routes/questions.routes')(app);

app.listen(port, function () {
    console.log('Server is running on Port:', port);
});


app.listen(port, () => console.log(`Express app running on port ${port}!`));
