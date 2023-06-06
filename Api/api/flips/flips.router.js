const {getFlips,getThreeFlip,getFlipsByCategory} = require('./flips.controller');
const router = require('express').Router();


router.get("/",getFlips);
router.get("/three",getThreeFlip);
router.post("/cat",getFlipsByCategory);
module.exports = router;