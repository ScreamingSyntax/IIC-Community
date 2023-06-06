const pool = require("../../config/database")

module.exports={
    postThreads: (data,filePath, callBack) => {
      console.log(data)
        pool.query(
          "INSERT INTO thread (thread_title, thread_description, image_path, user_id, creation_date) VALUES (?,?,?,?,?)",
          [
            data.thread_title,
            data.thread_description,
            filePath,
            data.user_id,
            data.creationDate
          ],
          (err, result, field) => {
            if (err) {
              return callBack(err);
            }
            return callBack(null, result);
          }
        );
      },
      viewThreads:callBack=>{
        pool.query("Select * from thread",
        [],
        (err,result,field)=>{
          if(err){
            return callBack(err);
          }
          return callBack
          (null,result)
        }
        )
      }
}