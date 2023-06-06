const {getArticleController,getCommunities,getNotification} = require('./article.controller');
const router = require('express').Router();


router.get("/",getArticleController);
router.get("/communities",getCommunities);
router.get("/notification",getNotification);
module.exports = router;