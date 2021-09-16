const express = require("express");
const router = express.Router();
const mysqlConnection = require("../connection");


  // get a event orders data by userid
router.get("/get-user-bookings", (req, res, err) => {
  let data = req.query;
  let userId = data.userId;
  let limit = req.query.limit;
  let offset = req.query.offset;

  let query = "select * from booking where userId ='"+userId+"' order by date desc limit " +
  limit +
  " offset " +
  offset;

  mysqlConnection.query(query, (err, rows, fields) => {
    if (!err) {
      res.json({
        message: "Booking details",
        success: true,
        data: rows,
      });
    } else {
      res.json({
        message: "An error occured: " + err,
        success: false,
        data: null,
      });
    }
  });
});


  // get a club data by date and id
router.get("/get-event-bookings", (req, res, err) => {
  let data = req.query;
  let date = data.date;
  let eventId = data.eventId;

  let query = "select * from booking where eventId = "+eventId+" order by date desc";

  mysqlConnection.query(query, (err, rows, fields) => {
    if (!err) {
      res.json({
        message: "Booking details as on "+date,
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


router.get("/get-booking-by-code", (req, res, err) => {
  let data = req.query;
  let passCode = data.passCode;

  let query = "select * from booking where passCode ='"+passCode+"'";

  mysqlConnection.query(query, (err, rows, fields) => {
    if (!err) {
      if(rows.length > 0){
        res.json({
          message: "Booking details",
          success: true,
          data: rows,
        });
      }else{
        res.json({
          message: "Invalid Code",
          success: false,
          data: null,
        });
      }
    } else {
      res.json({
        message: "An error occured: " + err,
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
// add a booking
router.post("/add-booking", (req, res, err) => {
  let data = req.body;
  let name = data.name;
  let userId = data.userId;
  let clubId = data.clubId;
  let eventId = data.eventId;
  let bookingDetails = data.bookingDetails;
  let amountPaid = data.amountPaid;
  let bookingDate = data.bookingDate;
  let maleCount = data.maleCount;
  let femaleCount = data.femaleCount;
  let coupleCount = data.coupleCount;

  let passCode = generateString(10)+clubId;
  let query =
    "insert into booking(userId,name,eventId,bookingDetails,bookingAmount,date,maleCount,femaleCount,coupleCount,clubId,passCode) values ('" +
    userId +
    "','" +
    name +
    "',?,'" +
    bookingDetails +
    "',?,'" +
    bookingDate +
    "',?,?,?,?,?)";
  mysqlConnection.query(query,[eventId,amountPaid,maleCount,femaleCount,coupleCount,clubId,passCode], (err, rows,fields) => {
    if (!err) {
      res.json({
        message: "Club Details Entered",
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