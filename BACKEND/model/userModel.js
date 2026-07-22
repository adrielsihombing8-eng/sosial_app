const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const { type } = require('node:os');

const userSchema = new mongoose.Schema({
    username:{
        type: String,
        require: true,
        unique: true,
    },
    email:{
        type: String,
        require: true,
        unique: true,
    },
    password:{
        type: String,
        require: true,
        unique: true,
    }
});

userSchema.pre('save', async function (next){
    try{
        var user = this;
        if(!this.isModified('password')) return;

        const salt = await (bcrypt.genSalt(10));
        const hashpass = await bcrypt.hash(user.password, salt);

        user.password = hashpass;
    }
    catch(err){
        throw err;
    }
});

userSchema.methods.comparePw = async function (UserPassword) {
    try {
        const isMatch = await bcrypt.compare(UserPassword, this.password)
        return isMatch;
    } catch (error) {
        throw error;
    }
}

module.exports = mongoose.model('user', userSchema);
