const jwt = require('jsonwebtoken');
const userServis = require('../services/userservices');

//register a new user
exports.register = async (req, res, next) => {
    const {username, email, password} = this.register.body;
    try{
        const userExist = await userServis.findUser({email});
        if(!userExist){
            return res.status(400).json({messange : "user already exists"});
        }
        const user = await userServis.saveUser({username, email, password});
        res.status(201).json({
            _id: user._id,
            username:user.username,
            email:user.email,
            token:userServis.generateToken(user._id),
        });
    }
    catch(err){
        res.status(500).json({messange: err.messange});
    }
};