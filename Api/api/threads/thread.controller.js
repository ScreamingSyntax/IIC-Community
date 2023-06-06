const {
    postThreads,viewThreads
  } = require("./thread.service");
module.exports={
    postThreadController: (req, res) => {
        // console.log(req.bodyldname)
        console.log(req.file);
        if(!req.file){
          return res.json({
            success:0,
            message:"No image Provided"
          })
        }
        const filePath =req.file.filename;
        const body = req.body;
        postThreads(body,filePath,(err, results) => {
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
      vewThreadController:(req,res)=>{
        viewThreads((err,results)=>{
          if(err){
            return res.json({
              success:0,
              message:"Error Fetching Data"
            })
      
          }
          return res.json({
            success:1,
            message:results
          })
        })
      }
      
}