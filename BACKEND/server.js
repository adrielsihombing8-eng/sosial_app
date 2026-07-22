const DBconnection = require('./config/db');
const app = require('./app');

const port = 300;

DBconnection();
app.get('/', (req, res) => res.send(200));
app.listen(port, () => console.log(`Example app listening on  http://localhost:${port}!`));
