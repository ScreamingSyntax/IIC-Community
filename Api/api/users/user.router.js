const {createUser,getUserByID,getUsers,updateUsers,deleteUsers,login,viewFriends,viewChat,send_messages,getFlips} = require('./user.controller');
const router = require('express').Router();
const {checkToken} = require("../../auth/token_validation");
const { getUserDetailsByEmail } = require('./user.controller');
const path = require("path");
const multer = require("multer");

const storage = multer.diskStorage({
    destination:'./upload/images',
    filename:(req,file,callBack)=>{
        console.log(file.originalname);
        return callBack(null,`${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`)
    }
});
const upload = multer({storage:storage,
    limits:{fileSize:100000000}
})

router.post("/",upload.single('register'),createUser);
router.get("/viewFriends/:id",checkToken,viewFriends);
router.get("/",checkToken,getUsers);
router.patch("/",checkToken,updateUsers);
router.get("/:email",checkToken,getUserDetailsByEmail);
router.get("/get/:id",checkToken,getUserByID)
router.delete("/:id",checkToken,deleteUsers);
router.post("/login",login);
router.post("/viewChat",checkToken,viewChat);
router.post("/sendChat",checkToken,send_messages);
// router.get("/flips",getFlips);
// router.get("/f")
module.exports = router;

