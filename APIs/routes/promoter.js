const { response } = require("express");
const express = require("express");
const { connect } = require("../connection");
const router = express.Router();
const mysqlConnection = require("../connection");



// add a booking
router.post("/add-promoter", (req, res, err) => {
  let data = req.body;
  let promoterEmail = data.promoterEmail;
  let clubId = data.clubId;
  

  let check="select * from user where email=?";
  mysqlConnection.query(check,[promoterEmail],(error,rows,fields)=>{
    if(rows.length === 0){
        res.json({success:false,message:"Promoter must be a registered user."})
    }else{
        let promoterId = promoterEmail.split("@")[0]+"_"+clubId;
        let query =
            "insert into promoters(clubId,promoterEmail,promoterId,usersOnboarded) values (?,?,?,?)";
        mysqlConnection.query(query,[clubId,promoterEmail,promoterId,0], (err, rows,fields) => {
            if (!err) {
            res.json({
                message: "Promoter added",
                success: true,
                data: promoterId,
            });
            } else {
            res.json({
                message: "An error occured: " + err.code,
                success: false,
                data: null,
            });
            }
        });
    }
  });
});

// add a booking
router.get("/get-promoter-coupon", (req, res, err) => {
    let data = req.query;
    let promoterId = data.promoterId;
    let clubId = data.clubId;
    let eventId = data.eventId;
    
    let check="select * from promoters where promoterId=? and clubId=?";
    mysqlConnection.query(check,[promoterId,clubId],(error,rows,fields)=>{
      if(rows.length > 0){
        
        let query =
            "select * from coupons where eventId=?";
        mysqlConnection.query(query,[eventId], (err, rows,fields) => {
            if (!err) {
            res.json({
                message: "Coupon Details",
                success: true,
                data: rows,
            });
            } else {
            res.json({
                message: "An error occured: " + err.code,
                success: false,
                data: null,
            });
            }
        });
      }else{
          
        res.json({success:false,message:"You are not a promoter of this club."});
        
          
      }
    });
  });
  

module.exports = router;