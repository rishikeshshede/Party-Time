const { Router } = require("express");
const express = require("express");
const router = express.Router();
const mysqlConnection = require("../connection");



// get all clubs present
router.get("/get-coupon", (req, res, err) => {
  let eventId=req.query.eventId;
  // let limit = req.query.limit;
  // let offset = req.query.offset;
  let query = "select * from coupons where eventId="+eventId;

  mysqlConnection.query(query, (err, rows, fields) => {
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
});

const characters ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

function generateString(length) {
    let result = '';
    const charactersLength = characters.length;
    for ( let i = 0; i < length; i++ ) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }

    return result;
}

//add user
router.post("/add-coupon", (req, res) => {
  let data = req.body;
  let couponName = data.couponName;
  let couponAmount = data.couponAmount;
  let couponQuantity = data.couponQuantity;
  let eventId = data.eventId;
  
  let query = "insert into coupons(eventId,couponName,couponAmount,couponQuantity,couponCode) values (?,?,?,?,'"+generateString(15)+"')";

  mysqlConnection.query(query, [eventId,couponName,couponAmount,couponQuantity],function (err, rows, fields) {
    if (!err) {
      res.json({
        message: "Sign up Successfull",
        success: true,
        data: null,
      });
    } else {
      res.json({
        message: "An error occured: " + err.code,
        success: false,
        data: null,
      });
    }
  });
});

module.exports = router;
