const pool = require("../../config/database")

module.exports={
    getFlipFacts:callBack=> {
        pool.query (
            "SELECT category FROM cards GROUP BY category HAVING COUNT(DISTINCT card_id) > 0",
            [],
            (err,result,field)=>{
                if(err){
                   return callBack(err)
                }
                return callBack(null,result);
            }
        )
    },
    getThreeFlipFacts:callBack=>{
        pool.query(
            "SELECT * FROM cards ORDER BY card_id ASC LIMIT 3",
            [],
            (err,result,field)=>{
                if(err){
                    return callBack(err)
                }
                return callBack(null,result)
            }
        )
    },
    getByCategory:(data,callBack)=>{
        pool.query(`SELECT * FROM cards WHERE category=?`,
        [data.category],
        (err,result,field)=>{
            if(err){
                return callBack(err);
            }
            return callBack(null,result)
        }
        )
    }
}