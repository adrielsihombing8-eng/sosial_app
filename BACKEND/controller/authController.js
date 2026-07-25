const jwt = require('jsonwebtoken');
const userServis = require('../services/userservices');

//register a new user
exports.register = async (req, res, next) => {
    const {username, email, password} = req.body;
    try{
        const userExist = await userServis.findUser({email});
        if(userExist){
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
        console.log(err);
        res.status(500).json({messange: err.messange});
    }
};

//login user
exports.login = async (req, res, next) => {
    const {email, password} = req.body;
    try{
        const user = await userServis.findUser({email});
        if(user && userServis.passwordCheck(email, password)){
            res.status(200).json({
                _id: user._id,
                username: user.username,
                email: user.email,
                token: userServis.generateToken(user._id),
            })
        }else{
            res.status(401).json({messange: "invalid email or password"})
        }
    }
    catch(err){
        next(err);
    }
};

