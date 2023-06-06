const {
  create,
  getUserByID,
  getUsers,
  updateUsers,
  deleteUsers,
  getUserByEmail,
  send_messages,
  getUserDetailsByEmail,
  viewFriends,
  getFlipFacts,
  viewChat
} = require("./user.service");
const { genSaltSync, hashSync, compareSync } = require("bcrypt");
const { sign } = require("jsonwebtoken");

module.exports = {

  createUser: (req, res) => {
    console.log(req.bodyldname)
    console.log(req.file);
    if(!req.file){
      return res.json({
        success:0,
        message:"No image Provided"
      })
    }
    const filePath =req.file.filename;
    const body = req.body;
    getUserByEmail(body.email,(err,results)=>{
      if(err){
        return res.json({
          success:0,
          message:"Error inserting values"
        })
      }
      if(results !== undefined){
        return res.json({
          success:0,
          message:"The email already exists"
        })
      }
      else{
        console.log(body)
        const salt = genSaltSync(10);
        body.password = hashSync(body.password, salt);
        create(body, filePath,(err, results) => {
          if (err) {
            console.log(err);
            return res.status(500).json({
              success: 0,
              message: "Database connection error"
            });
          }
          return res.status(200).json({
            success: 1,
            data: results
          })
        })
      }
    });
   
  },
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
  send_messages:(req,res)=>{
    // console.log(req.body);
    const data = req.body;
    send_messages(data,(err,results)=>{
      if(err){
        console.log(err);
        return;
      }
      return res.json({
        success:1,
        data:results
      })
    });
  },
  viewChat:(req,res)=>{
    console.log("hello")
    const data = req.body;
    console.log(data);
    // console.log(`This is data ${data`);
    viewChat(data,(err,results)=>{
      if(err){
        console.log(err);
        return;
      }
      return res.json({
        success:1,
        data:results
      })
    });
  },
  viewFriends:(req,res)=>{
    const id = req.params.id;
    console.log(id)
    viewFriends(id,(err,results)=>{
      if(err){
        console.log(err);
        return;
      }
      return res.json({
        success:0,
        data:results
      })
    })
  },
  getUserByID: (req, res) => {

    const id = req.params.id;
    getUserByID(id, (err, results) => {
      if (err) {
        console.log(err);
        return;
      }
      if (!results) {
        return res.json({
          success: 0,
          message: "Record Not Found"
        })
      }
      return res.json({
        success: 1,
        data: results
      })
    })
  },
getUsers: (req, res) => {
    getUsers((err, results) => {
      if (err) {
        console.log(err);
        return;
      }
      return res.json({
        success: 1,
        data: results
      })
    })
  },
  updateUsers: (req, res) => {
    const body = req.body;
    const salt = genSaltSync(10);
    body.password = hashSync(body.password, salt);
    updateUsers(body, (err, results) => {
      if (err)
       {
        console.log(err);
        return;
      }
      if(results.affectedRows == 0 || !results){
        return res.json({
            success : 0,
            message: "Failed to Update User"
        })
      }
      return res.json({
        success: 1,
        message: "Updated successfully"
      })
    });
  },
  deleteUsers: (req, res) => {
    const id = req.params.id;
    // const data = req.body;
    console.log(id);
    deleteUsers(id, (err, results) => {
        console.log("This is results",results)
    //   console.logs()
      if (err) {
        console.log(err);
        return;
      }
      if (results .affectedRows===0) {
        return res.json({
          success: 0,
          message: "Record Not Found or Failed to Delete"
        })
      }
      return res.json({
        success: 1,
        message: "User Deleted Successfully"
      });
    });
  },
  getUserByEmail : (req,res)=>{
    const data = req.body;
    getUserByEmail(data,(err,results)=>{
        if (err){
            console.log(err);
            return;
        }
        if(!results){
            return res.json({
                success:0,
                message:"Record Not Found"
            })
        }
        return res.json({
            success : 1,
            message : "Got Email Successfully"
        })
    })
  },
  getUserDetailsByEmail: (req,res)=>{
    // const dataOne = req.body.email;
    const data = req.params.email;
    console.log(data);
    // console.log(dataOne);
    getUserDetailsByEmail(data, (err,results)=>{
      if(err){
        console.log(err);
        return;
      }
      if(!results){
        return res.json({
          success:0,
          message:"Record Not Found"
        })
      }
      return res.json({
        success:1,
        message: results
      })

    })
  },
  login: (req,res)=>{
    const body = req.body;
    // console.log(body);
    getUserByEmail(body.email,(err,results)=>{
        if(err){
            console.log(err);
        }
        if(!results){
            return res.json({
                success:0,
                data:"Invalid email or password"
            });
        }
        console.log(results.password);
        if(body.email!='' && body["password"]!=''){
        const result= compareSync(body.password,results.password);
        if(result){
            // results.password = undefined;
            const jsontoken = sign({result: results}, "key test",{
                expiresIn: "1h"
            });
            return res.json({
                success :1,
                message:"Login Successfully",
                token : jsontoken,
                email:body.email
            });
        }
        else{
            return res.json({
                success:0,
                data : "Invalid email or password"
            });

        }
        }
        else{
          return res.json({
            success:0,
            data: "Null Values are not allowed"
          })
        }
    })}}
