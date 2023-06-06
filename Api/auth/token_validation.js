const {verify} = require('jsonwebtoken');
module.exports={
    checkToken:(req,res,next)=>{
        let token = req.get("authorization");
        if(token){
          token = token.slice(7);
          verify(token,"key test",(err,decoded)=>{
            if(err){
                res.json({
                    sucess:0,
                    message: "Invalid Token"
                })
            }
            else{
                next();
            }
          })
        }
        else{
            res.json({
                sucess:0,
                message:"Access Denied!  unauthorized user"
            })
        }
    }
}