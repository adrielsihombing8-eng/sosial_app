const mongoose = require('mongoose');
const donevn = require('dotenv');
donevn.config();

const DBconnection = async() => {
    try{
        await mongoose.connect(process.env.MONGO_URL);
        console.log("connection succes!!!");
    }
    catch(error){
        console.log('error connction');
        console.log(error)
    }
}

module.exports = DBconnection;