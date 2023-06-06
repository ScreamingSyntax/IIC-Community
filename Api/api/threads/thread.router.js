const {postThreadController,vewThreadController} = require("./thread.controller")
const router = require('express').Router();
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

router.post("/",upload.single('register'),postThreadController);
router.get("/",vewThreadController);
module.exports = router;