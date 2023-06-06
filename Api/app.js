require("dotenv").config()
const express = require('express');
const app = express();
const userRouter = require('./api/users/user.router');
const flipsRouter = require('./api/flips/flips.router');
const threadRouter = require('./api/threads/thread.router');
const articleRouter = require('./api/article/article.router');
// const scheduleRouter = require('./api/schedule/schedule.router');
app.use(express.json());
const port =  5000


app.use('/api/users',userRouter);
app.use("/register", express.static('upload/images'))
app.use('/api/flips',flipsRouter);
app.use('/api/thread',threadRouter);
app.use('/api/article',articleRouter);
// router.get('/',(req,res)=>{
//     res.json({
//         success:1,
//         message : "This is rest api working"
//     })
// })
app.listen(port, ()=>{
    console.log("Server running on port : ",port)
})
