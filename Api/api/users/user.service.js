const pool = require("../../config/database")

module.exports = {
    create: (data,filePath, callback)=>{
        console.log(filePath);
        pool.query(
            "Insert into user(name,email,password,image) values(?,?,?,?)",
            [
            data.name,
            data.email,
            data.password,
            filePath
            ],
            (error,result,field) =>{
                if(error){
                return callback(error);
                }
                return callback(null,result);
                 
            }
        )
    },
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
    viewChat:(data,callBack)=>{
        pool.query("SELECT * from chat where (sender_id=? and reciever_id=?) or (reciever_id=? and sender_id=?)",
        [data.sender_id,data.reciever_id,data.sender_id,data.reciever_id],
        (err,result,field)=>{
            console.log()
            if(err){
                return callBack(err);
            }
            return callBack(null,result);
        }
        )
    },
    send_messages:(data,callBack)=>{
        pool.query("Insert into chat(sender_id,reciever_id,message) values (?,?,?)",
        [data.sender_id,data.reciever_id,data.message],
        (err,result,field)=>{
            if(err){
                return callBack(err);
            }
            return callBack(null,result);
        }
        )
    },
    viewFriends: (id,callBack)=>{
        pool.query(
            "select * from user where id!=?",
            [id],
            (err,result,field)=>{
                if(err){
                    return callBack(err);
                }
                return callBack(null,result);
            }
        );
    },
    getUsers : callBack=> {
        pool.query (
            "select id,name,email from user",
            [],
            (err,result,field)=>{
                if(err){
                   return callBack(err)
                }
                return callBack(null,result);
            }
        )
    },
    getUserByID : (id, callBack) => {
        pool.query (
            "select name from user where id = ?",
            [id],
            (err,result,field)=>{
                if(err){
                    return callBack(err)
                }
                return callBack(null,result);
            }
        )
    },
    getUserByEmail :(email,callBack)=>{
        console.log(email);
        pool.query('Select * from user where email = ?',
        [email],
        (err,result,fields)=>{
            // console.log(result[0].password)
            if(err){
                return callBack(err);
            }
            return callBack(null,result[0]);
        }
        );
    }
    ,
    getUserDetailsByEmail:(email,callback)=>{
        pool.query("Select * from user where email = ?",[email],
        (err,result,fields)=>{
            if(err){
                return callback(err);
            }

            return callback(null,result);
        }
        
        )
    },
    updateUsers : (data, callBack) => {
        pool.query (
            "update user set name = ?, email = ? ,password = ? where id = ?",
            [
                data.name,
                data.email,
                data.password,
                data.id,
            ],
            (err,result,field)=>{
                if(err){
                    return callBack(err)
                }
                console.log(data.id)
                console.log(data.name);
                return callBack(null,result);
            }
        )
    },
    deleteUsers: (id, callBack) => {
        pool.query(
            "delete from user where id = ?",
            [id],
            (err, result, field) => {
                if (err) {
                    return  callBack(err)
                }
                return callBack(null, result);
            }
        )
    },
    
    
}
