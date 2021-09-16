const { Router } = require("express");
const express = require("express");
const router = express.Router();
const mysqlConnection = require("../connection");

// get all clubs present
router.get("/get-all-clubs", (req, res, err) => {

    let limit = req.query.limit;
    let offset = req.query.offset;
    let query = "select * from club" + " limit " + limit + " offset " + offset;

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

// get a club by id
router.get("/get-club-details", (req, res, err) => {
    let clubId = req.query.clubId;
    let query = "select * from club where clubId=" + clubId;

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

// get a club by user id
router.get("/get-user-club", (req, res, err) => {
    let userId = req.query.userId;
    let limit = req.query.limit;
    let offset = req.query.offset;
    let query = "select * from club where userId='" + userId + "' limit " + limit + " offset " + offset;

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "Club Details",
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

// add a club
router.post("/add-club", (req, res, err) => {
    let data = req.body;
    let name = data.name;
    let userId = data.userId;
    let location = data.location;
    let description = data.description;
    let coverPhoto = data.coverPhoto;
    let address = data.address;

    let query =
        "insert into club(userId,name,location,address,image,description) values ('" +
        userId +
        "',?,?,?,'" +
        coverPhoto +
        "',?)";
    mysqlConnection.query(query, [name, location, address, description], (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "Club Details Entered",
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

// update a club details
router.post("/update-club", (req, res, err) => {
    let data = req.body;
    let name = data.name;
    let clubId = data.clubId;
    let location = data.location;
    let description = data.description;
    let coverPhoto = data.coverPhoto;
    let address = data.address;
    let query =
        "update club set name= ?, location =?,description=?,image='" +
        coverPhoto +
        "',address=? where clubId = " +
        clubId;

    mysqlConnection.query(query, [name, location, description, address], (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "Club Details Updated",
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

// delete a club data by date and id
router.post("/delete-club", (req, res, err) => {
    let data = req.query;
    let clubId = data.clubId;

    let query = "delete from club where clubId = " + clubId;

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "Club Deleted" + date,
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