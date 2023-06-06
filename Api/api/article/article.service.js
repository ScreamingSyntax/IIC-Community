const pool = require("../../config/database")

module.exports={
    getArticle:callBack=> {
        pool.query (
            "select * from articles",
            [],
            (err,result,field)=>{
                if(err){
                   return callBack(err)
                }
                return callBack(null,result);
            }
        )
    },
    getCommunityService:callBack=>{
        pool.query(
            "Select * from communities",
            [],
            (err,result,field)=>{
                if(err){
                    return callBack(err)
                }
                return callBack(null,result);
            }
        )
    },
    getNotification:callBack=>{
        pool.query("Select * from notification",
        [],
        (err,result,field)=>{
            if(err){
                return callBack(err);
            }   
            return callBack(null,result);
        }
        )
    }
}