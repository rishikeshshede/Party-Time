const express = require("express");
const bodyParser = require("body-parser");

var app = express();
app.use(bodyParser.json());

// import
const UserRoutes = require('./routes/user');
const ClubRoutes = require('./routes/clubs');
const EventsRoutes = require('./routes/events');
const BookingRoutes = require('./routes/bookings');
const PromoterRoutes = require('./routes/promoter');
const CouponRoutes = require("./routes/coupons");
const FileRoutes = require('./routes/upload-file');


// api routes to endpoints
app.use('/apis/user', UserRoutes);
app.use('/apis/clubs', ClubRoutes);
app.use('/apis/events', EventsRoutes);
app.use('/apis/file', FileRoutes);
app.use('/apis/bookings', BookingRoutes);
app.use('/apis/promoters', PromoterRoutes);
app.use('/apis/coupons', CouponRoutes);


app.listen(3000);
