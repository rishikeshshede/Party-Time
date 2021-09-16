const { Router } = require("express");
const express = require("express");
const router = express.Router();
const mysqlConnection = require("../connection");

// get all events present
router.get("/get-all-events", (req, res, err) => {
    let limit = req.query.limit;
    let offset = req.query.offset;
    let query =
        "select * from event order by date asc limit " +
        limit +
        " offset " +
        offset;

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "Event Details",
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

// get an event by id
router.get("/get-event", (req, res, err) => {
    let eventId = req.query.eventId;
    let query = "select * from event where eventId=" + eventId;

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "Event Details",
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

// get premium event
router.get("/get-premium-event", (req, res, err) => {
    let limit = req.query.limit;
    let offset = req.query.offset;
    let query = "select * from event where isPremium = 1 order by date asc limit " +
        limit +
        " offset " +
        offset;

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "Event Details",
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

// get an event by club id
router.get("/get-club-event", (req, res, err) => {
    let clubId = req.query.clubId;
    let limit = req.query.limit;
    let offset = req.query.offset;
    let query =
        "select * from event where clubId=" +
        clubId +
        " order by date desc limit " +
        limit +
        " offset " +
        offset;

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "Event Details",
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

// get user history -- unused
router.get("/get-user-history", (req, res, err) => {
    let clubId = req.query.userId;
    let limit = req.query.limit;
    let offset = req.query.offset;
    let query =
        "select * from event where userId=" +
        userId +
        " order by date desc limit " +
        limit +
        " offset " +
        offset;

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "event Details",
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

// get unique locations for filtering
router.get("/get-unique-locations", (req, res, err) => {
    let query = "select distinct location from club";

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "Unique locations",
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

// get event by location
router.get("/get-event-by-location", (req, res, err) => {
    let location = req.query.location;
    let limit = req.query.limit;
    let offset = req.query.offset;
    let query =
        "select * from event as e,club as c where e.clubId = c.clubId and c.location ='" +
        location +
        "' order by date asc limit " +
        limit +
        " offset " +
        offset;

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "events by location",
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

// get unique locations for filtering
router.get("/get-premium-event-by-location", (req, res, err) => {
    let location = req.query.location;
    let limit = req.query.limit;
    let offset = req.query.offset;
    let query =
        "select * from event as e,club as c where e.clubId = c.clubId and isPremium =1 and c.location ='" +
        location +
        "' order by date asc limit " +
        limit +
        " offset " +
        offset;

    mysqlConnection.query(query, (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "premium events by location",
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

// add an event
router.post("/add-event", (req, res, err) => {
    let data = req.body;
    let name = data.name;
    let userId = data.userId;
    let clubId = data.clubId;
    let description = data.description;
    let coverPhoto = data.coverPhoto;
    let priceDescription = data.priceDescription;
    var maleCount = data.maleCount;
    var femaleCount = data.femaleCount;
    let mfRatio = data.mfRatio;
    let coupleCount = data.coupleCount;
    let stagWithCouple = data.stagWithCouple;
    let isPremium = data.isPremium;
    let date = data.date;
    let time = data.time;
    var capacity = data.capacity;

    let query =
        "insert into event(userId,clubId,name,image,priceDescription,maleCount,femaleCount,mfRatio,description,capacity,date,coupleCount,stagWithCouple,isPremium,time) values ('" +
        userId +
        "',?,?,'" +
        coverPhoto +
        "',?,?,?,'" +
        mfRatio +
        "',?,?,'" +
        date +
        "',?,?," +
        isPremium +
        ",'" +
        time +
        "')";
    mysqlConnection.query(
        query, [
            clubId,
            name,
            priceDescription,
            maleCount,
            femaleCount,
            description,
            capacity,
            coupleCount,
            stagWithCouple,
        ],
        (err, rows, fields) => {
            if (!err) {
                res.json({
                    message: "Event Details Entered",
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
        }
    );
});

// update an event details
router.post("/update-event", (req, res, err) => {
    let data = req.body;
    let name = data.name;
    let eventId = data.eventId;
    let description = data.description;
    let coverPhoto = data.coverPhoto;
    let mfRatio = data.mfRatio;
    let coupleCount = data.coupleCount;
    let date = data.date;
    let time = data.time;
    let stagWithCouple = data.stagWithCouple;
    var priceDescription = data.priceDescription;
    var maleCount = data.maleCount;
    var femaleCount = data.femaleCount;
    var capacity = data.capacity;

    let query =
        "update event set name= ?,description=?,image='" +
        coverPhoto +
        "',priceDescription=?,maleCount=" +
        maleCount +
        ",date='" +
        date +
        "',time='" +
        time +
        "',femaleCount=" +
        femaleCount +
        ",mfRatio='" +
        mfRatio +
        "',capacity=" +
        capacity +
        ",coupleCount=" +
        coupleCount +
        " ,stagWithCouple=" +
        stagWithCouple +
        " where eventId = " +
        eventId;

    mysqlConnection.query(query, [name, description, priceDescription], (err, rows, fields) => {
        if (!err) {
            res.json({
                message: "Event Details Updated",
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

// delete a club data by id
router.post("/delete-event", (req, res, err) => {
    let data = req.body;
    let eventId = data.eventId;

    let query = "delete from event where eventId = " + eventId;

    mysqlConnection.query(query, function(err) {
        if (!err) {
            res.json({
                message: "Event Deleted",
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

// make event premium
router.post("/make-event-premium", function(req, res, err) {
    let data = req.body;
    let eventId = data.eventId;
    var query =
        "update event set isPremium= " + 1 + " where eventId = " + eventId;

    mysqlConnection.query(query, function(err, rows, fields) {
        if (!err) {
            res.json({
                message: "Event Updated successfully",
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