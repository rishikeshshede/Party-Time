const { Router } = require("express");
const express = require("express");
const router = express.Router();
const mysqlConnection = require("../connection");



// get all clubs present -- unused API
router.get("/get-all-users", (req, res, err) => {

    let query = "select * from user";

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "Club Details",
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

// get user details
router.get("/get-user-details", (req, res) => {
    let data = req.query;
    let userId = data.userId;
    let query = "select * from user where userId = '" + userId + "'";
    console.log(req);
    mysqlConnection.query(query, function(err, rows, fields) {
        if (!err) {
            res.json({
                message: "Details Recieved",
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

//add user
router.post("/add-new-user", (req, res) => {
    let data = req.body;
    let userId = data.userId;
    let name = data.name;
    let gender = data.gender;
    let email = data.email;
    let phone = data.phone;
    let userCategory = data.userCategory;
    let age = data.age;

    let query = "insert into user(userId,name,email,phone,gender,age,userCategory) values ('" + userId + "','" + name + "','" + email + "','" + phone + "','" + gender + "','" + age + "','" + userCategory + "')";

    mysqlConnection.query(query, function(err, rows, fields) {
        if (!err) {
            res.json({
                message: "Sign up Successful",
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

//add user
router.post("/update-user", (req, res) => {
    let data = req.body;
    let userId = data.userId;
    let name = data.name;
    let age = data.age;
    let email = data.email;
    let phone = data.phone;

    let query = "update user set name ='" + name + "' , email ='" + email + "' , phone ='" + phone + "', age= '" + age + "' where userId = '" + userId + "'";

    mysqlConnection.query(query, function(err, rows, fields) {
        if (!err) {
            res.json({
                message: "Details Updated",
                success: true,
                data: null,
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

module.exports = router;