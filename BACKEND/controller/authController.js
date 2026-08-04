const jwt = require("jsonwebtoken");
const userServis = require("../services/userservices");

//register a new user
exports.register = async (req, res, next) => {
    const { username, email, password } = req.body;
    try {
        const userExist = await userServis.findUser({ email });
        if (userExist) {
            return res.status(401).json({ messange: "email already exists" });
        }

        const findEmail = await userServis.findUserName({ username });
        if (userExist) {
            return res.status(402).json({ messange: "username already exists" });
        }

        const user = await userServis.saveUser({ username, email, password });

        res.status(201).json({
            _id: user._id,
            username: user.username,
            email: user.email,
            token: userServis.generateToken(user._id),
            refreshToken: userServis.generateRefreshToken(user._id),
        });
    } catch (err) {
        console.log(err);
        res.status(500).json({ messange: err.messange });
    }
};

//login user
exports.login = async (req, res, next) => {
    const { email, password } = req.body;
    try {

        console.log("memulai login");
        const user = await userServis.findUser({ email });
        if (user && userServis.passwordCheck(email, password)) {
            console.log("data di temukan");
            res.status(200).json({
                _id: user._id,
                username: user.username,
                email: user.email,
                token: userServis.generateToken(user._id),
                refreshToken: userServis.generateRefreshToken(user._id),
            });
        } else {
            res.status(401).json({ messange: "invalid email or password" });
        }
    } catch (err) {
        next(err);
    }
};

//auth atau middleware
exports.auth = async (req, res, next) => {
    const authHeader = req.headers["authorization"];
    if (!authHeader) {
        return res.status(400).json({ messanges: "token kosong" });
    }

    const token = authHeader.split(" ")[1];
    if (!token) {
        return res.status(401).json({ messange: "token invalid" });
    }

    try {
        const decoded = jwt.verify(token, process.env.secret_key);
        req.userId = decoded._id;
        console.log("data berhasil di deteksi");
        return res.status(200).json({
            status: true,
            message: "Token valid",
        });
    } catch (err) {
        if (err.name === "TokenExpiredError") {
            return res.status(401).json({
                status: false,
                message: "Token sudah expired, silakan login ulang",
            });
        }

        if (err.name === "JsonWebTokenError") {
            return res.status(401).json({
                status: false,
                message: "Token tidak valid",
            });
        }

        return res.status(500).json({
            status: false,
            message: "Server error",
        });
    }
};

//refres token
exports.refresh = async (req, res, next) => {
    try {
        const { refreshToken } = req.body;

        if (!refreshToken) {
            return res.status(403).json({ messange: "refres token missing" });
        }

        const decoded = jwt.verify(refreshToken, "refresh_secret_token");

        const user = await userServis.findUserId(decoded._id);

        if (!user || user.refreshToken !== refreshToken) {
            return res.status(403).json({ message: "refresh token tidak valid" });
        }

        const newToken = await userServices.generateToken(user._id);

        res.status(200).json({
            status: true,
            message: "token baru dibuat",
            token: newToken,
        });
    } catch (err) {
        if (err.name === "TokenExpiredError") {
            return res.status(403).json({
                status: false,
                message: "Refresh token sudah expired, silakan login ulang",
            });
        }
        if (err.name === "JsonWebTokenError") {
            return res
                .status(403)
                .json({ status: false, message: "Refresh token tidak valid" });
        }
        console.log("data error refreshToken:", err);
        return res.status(500).json({ status: false, message: "Server error" });
    }
};



