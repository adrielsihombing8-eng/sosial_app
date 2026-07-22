const mongoose = require('mongoose');

const DBconnection = async() => {
    try{
        await mongoose.connect("mongodb+srv://adrielsihombing8_db_user:hXkpU5SLAzAUfedL@cluster0.pul08ku.mongodb.net/SosialApp?appName=Cluster0",{
            useNewUrlParser : true,
            useUnifiedTopology : true
        }
        );
        console.log("connection succes!!!");
    }
    catch(error){
        console.log('error connction');
    }
}

module.exports = DBconnection;