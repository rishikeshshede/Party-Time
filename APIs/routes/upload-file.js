const express = require("express");
const router = express.Router();
const mysqlConnection = require("../connection");
const path = require("path");
var multer = require("multer");
fs = require('fs');
var endpoint = "http://bookario.com/apis/file/";
var storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, "../public/"));
  },
  filename: (req, file, cb) => {
    var filetype = "";
    if (file.mimetype === "image/gif") {
      cb(null, "image-" + new Date().getTime() + "." + "gif");
    }
    if (file.mimetype === "image/png") {
      cb(null, "image-" + new Date().getTime() + "." + "png");
    }
    if (file.mimetype === "image/jpeg") {
      cb(null, "image-" + new Date().getTime() + "." + "jpg");
    }
  },
});
var upload = multer({ storage: storage });

router.post("/upload", upload.single("file"), function (req, res, next) {
  if (!req.file) {
    res.status(500);
    return next(err);
  } else {
    res.json({
      success: true,
      message: "File uploaded successfully",
      data: {
        url: endpoint + req.file.filename,
        name: req.file.filename,
      },
    });
  }
});

router.get("/:fileName", function (req, res) {
  var mime = {
    html: 'text/html',
    txt: 'text/plain',
    css: 'text/css',
    gif: 'image/gif',
    jpg: 'image/jpeg',
    png: 'image/png',
    svg: 'image/svg+xml',
    js: 'application/javascript'
};
  var fileName = req.params.fileName;
  var file = path.join(__dirname,"../public/"+ fileName);
    var type = mime[path.extname(file).slice(1)] || 'text/plain';
    var s = fs.createReadStream(file);
    s.on('open', function () {
        res.setHeader('Content-Type', type);
        s.pipe(res);
    });
    s.on('error', function () {
        res.setHeader('Content-Type', 'text/plain');
        res.statusCode = 404;
        res.end('Not found');
    });
});
module.exports = router;
