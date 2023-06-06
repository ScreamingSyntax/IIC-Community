const {
    getFlipFacts,getThreeFlipFacts,getByCategory
  } = require("./flips.service");
module.exports={
    getFlips: (req, res) => {
        getFlipFacts((err, results) => {
          if (err) {
            console.log(err);
            return res.status(500).json({
              success: 0,
              message: "Database connection error",
            });
          }
          return res.json({
            success: 1,
            data: results,
          });
        });
      },
      getThreeFlip: (req, res) => {
        getThreeFlipFacts((err, results) => {
          if (err) {
            console.log(err);
            return res.status(500).json({
              success: 0,
              message: "Database connection error",
            });
          }
          return res.json({
            success: 1,
            data: results,
          });
        });
      },
      getFlipsByCategory:(req,res)=>{
        const data= req.body;
        getByCategory(data,(err,results)=>{
          if(err){
            console.log(err);
            return;
          }
          return res.json({
            success:1,
            data:results
          })
        })
      }
      
}