const {
   getArticle,getCommunityService,
   getNotification
  } = require("./article.service");

  module.exports={
    getArticleController:(req,res)=>{
        getArticle((err,results)=>{
            if(err){
                return res.json({
                    success:0,
                    message:results
                })
            }
            return res.json({
                success:0,
                message:results
            })
        })
    },
    getCommunities:(req,res)=>{
        getCommunityService((err,results)=>{
            if(err){
                return res.json({
                    success:0,
                    message:results
                });
            }
            return res.json({
                success:0,
                message:results
            })
        })
  },
  getNotification:(req,res)=>{
    getNotification((err,results)=>{
        if(err){
            return res.json({
                success:0,
                message:results
            })
        }
        return res.json({
            success:0,
            message:results
        })

    })
  }
}