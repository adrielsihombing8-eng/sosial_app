const jwt = require("jsonwebtoken");
const contentModel = require("../model/contentModel");
const contentServices = require("../services/contentServices");
const userServices = require("../services/userservices")

//middleware
exports.middleware = async (req, res, next) => {
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

//addcontent
exports.addContent = async (req, res, next) => {
    try {
        const result = await new Promise((resolve, reject) => {
            const stream = cloudinary.uploader.upload_stream(
                { folder: 'sosialapp' },
                (err, result) => err ? reject(err) : resolve(result)
            );
            stream.end(req.file.buffer);
        });

        const userId = req.userId;
        const post = new contentModel({
            userId: userId,
            content: req.body.content,
            imageUrl: result.secure_url,
            imagePublicId: result.public_id,
        })

        const saving = await contentServices.contentAdd(post);

        if (!saving) {
            res.status(400).json({ message: "data gagal di simpan" });
        }
        else {
            res.status(200).json({ message: "data todo disimpan" });
        }
    } catch (err) {
        next(err);
    }
};

//loadcontent
exports.loadcontent = async (req, res, next) => {
    try {
        const { cursor, limit = 10 } = req.query;
        const query = cursor ? { _id: { $lt: cusor } } : {};
        const posts = await contentServices.loadContent(query);
        const nextCursor = posts.length > 0 ? posts[posts.length - 1]._id : null;

        res.json({ posts, nextCursor, hasMore: posts.length === parseInt(limit) });
    } catch (err) {
        next(err)
    }
};

//findUser
exports.findUser = async (req, res, next) => {
    try{
        const {userId} = req.query
        const user = await userServices.findUserId(postId);

        if(!user){
            return res.status(404).json({ success: false, message: "User tidak ditemukan" });
        }

        
        //search gambarnya belom

        res.status(200).json({userdata: user});
    }
    catch(err){
        res.status(500).json({ success: false, message: err.message });
    }
};
