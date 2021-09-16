# API Documentation

## Backend is built using NodeJs and MySQL.

Base URL is `http://localhost:3000/apis`

Check out [`connection.js`](connection.js) file to understand how to connect to the MySQL database.

Request for connecting to database is made from inside the individual file after initial routing i.e., after [`apis/user`](app.js), [`apis/clubs`](app.js) etc. For more information about initial routing check out [`app.js`](app.js).

## Endpoints:

### Add New User:
**POST** `/user/add-new-user`

Example request body:
```JSON
{
    "body":{
        "userId": "YfQgZzeNTHMKWPwckZAsdU4",
        "name": "Rishikesh Shede",
        "email": "rishi@gmail.com",
        "phone": "1234567890",
        "age": 22,
        "gender": "male",
        "userCategory": "customer",
    }
}
```
Example response body:
```JSON
{
    "message": "Sign up successful",
    "success": true,
    "data": null,
}
```

### Update User Details:
**POST** `/user/update-user`

Example request body:
```JSON
{
    "body":{
        "userId": "YfQgZzeNTHMKWPwckZAsdU4",
        "name": "Rishikesh Shede",
        "email": "rishi@gmail.com",
        "phone": "1234567890",
        "age": 22,
    }
}
```
Example response body:
```JSON
{
    "message": "Sign up successful",
    "success": true,
    "data": null,
}
```

### Get User Details:
**GET** `/user/get-user-details`

Example request body:
```
/user/get-user-details/?userId=YfQgZzeNTHMKWPwckZAsdU4
```
Returns a [User](#add-new-user "User").

---

### Add New Club:
**POST** `/clubs/add-club`

Example request body:
```JSON
{
    "body":{
        "userId": "YfQgZzeNTHMKWPwckZAsdU0",
        "name": "Night Club",
        "location": "Hinjewadi",
        "description": "REAL EVENTS are back! Join us at Pune Pupper Party  2.0 at Classic Rock Cafe, Kalyani Nagar, for fun games to play with your pups, stand a chance to win exciting gifts for them, get delicious doggy meal plus free goodies for every pet! Humans also get a FREE food & drinks coupon worth Rs. 100 on every ticket!",
        "coverPhoto": "storage0/photos/myClubImage.jpeg",
        "address": "Near Abc shop, Hinjewadi",
    }
}
```
Example response body:
```JSON
{
    "message": "Club Details Entered",
    "success": true,
    "data": null,
}
```

### Update Club:
**POST** `/clubs/update-club`

Example request body:
```JSON
{
    "body":{
        "clubId": "YfQgZzeNTHMKWPwckZAsdU1",
        "name": "Night Club 1",
        "location": "Hinjewadi",
        "description": "REAL EVENTS are back! Join us at Pune Pupper Party  2.0 at Classic Rock Cafe, Kalyani Nagar, for fun games to play with your pups, stand a chance to win exciting gifts for them, get delicious doggy meal plus free goodies for every pet! Humans also get a FREE food & drinks coupon worth Rs. 100 on every ticket!",
        "coverPhoto": "storage0/photos/myClubImage.jpeg",
        "address": "Near Abc shop, Hinjewadi",
    }
}
```
Example response body:
```JSON
{
    "message": "Club Details Updated",
    "success": true,
    "data": null,
}
```

### Delete Club:
**GET** `/clubs/delete-club`

Example request body:
```
/clubs/delete-club?clubId=YfQgZzeNTHMKWPwckZAsdU1
```
Example response body:
```JSON
{
    "message": "Club Details Entered",
    "success": true,
    "data": null,
}
```

### Get User Club:
**GET** `/clubs/get-user-club`

Example request body:
```
/clubs/get-user-club?userId=YfQgZzeNTHMKWPwckZAsdU0&limit=10&offset=0
```
Example response body:
```JSON
{
    "message": "Club Details",
    "success": true,
    "data": [
        {
            "clubId": 13,
            "name": "Night Club",
            "userId": "YfQgZzeNTHMKWPwckZAsdU0",
            "location": "Hinjewadi",
            "address": "Near Abc shop, Hinjewadi",
            "image": "http://localhost/file/myClubImage.jpeg",
            "description": "REAL EVENTS are back! Join us at Pune Pupper Party  2.0 at Classic Rock Cafe, Kalyani Nagar, for fun games to play with your pups, stand a chance to win exciting gifts for them, get delicious doggy meal plus free goodies for every pet! Humans also get a FREE food & drinks coupon worth Rs. 100 on every ticket!"
        }
    ],
}
```

### Get Club Details:
**GET** `/clubs/get-club-details`

Example request body:
```
/clubs/get-club-details?clubId=YfQgZzeNTHMKWPwckZAsdU1
```
Returns a [Club](#get-user-club "Club").

### Get All Clubs:
**GET** `/clubs/get-all-clubs`

Example request body:
```
/clubs/get-all-clubs?limit=10&offset=0
```
Example response body:
```JSON
{
    "message": "Club Details",
    "success": true,
    "data": [
        {
            "clubId": 13,
            "name": "Night Club",
            "userId": "YfQgZzeNTHMKWPwckZAsdU0",
            "location": "Hinjewadi",
            "address": "Near Abc shop, Hinjewadi",
            "image": "http://localhost/file/myClubImage.jpeg",
            "description": "REAL EVENTS are back! Join us at Pune Pupper Party  2.0 at Classic Rock Cafe, Kalyani Nagar, for fun games to play with your pups, stand a chance to win exciting gifts for them, get delicious doggy meal plus free goodies for every pet! Humans also get a FREE food & drinks coupon worth Rs. 100 on every ticket!"
        },
        {
            "clubId": 14,
            "name": "Publiq",
            "userId": "a5q7UqOqQxa288cQqmnbylCI3qq1",
            "location": "Magerpatta",
            "address": "White Square, 9th Floor, 901, Hinjewadi Phase 1 Road, Hinjewadi, Pune",
            "image": "http://localhost/file/myClubImage2.jpg",
            "description": "Publiq has free entry through the week and offers ladies night on Wednesdays. If you are one who loves dancing to Bollywood songs, then you must hit the club on a Friday night. Publiq has three locations in Pune, each offering a refined crowd that is both fun."
        }
    ],
}
```
---

---

### Add New Event:
**POST** `/events/add-event`

Example request body:
```JSON
{
    "body":{
        "name": "Abc",
        "userId": "7ZiZxPFXC5Oaa2SK4loTzr2",
        "clubId": 1,
        "description": "ajc fafakcadnca  e f ec  aecje ke ner",
        "coverPhoto": "http://bookario.com/file/myImage1.jpg",
        "maleCount": 30,
        "femaleCount": 30,
        "coupleCount": 10,
        "capacity": 80,
        "isPremium": 0, // 0=False default
        "stagWithCouple": 1, //0=Male Stag, 1=Female Stag, 2=None
        "mfRatio": "1:2",
        "date": "2020/12/12",
        "priceDescription": "{\"maleStag\":\"{\\\"Basic Pass\\\":\\\"850\\\",\\\"Cover type 1\\\":\\\"Not Available\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\",\"femaleStag\":\"{\\\"Basic Pass\\\":\\\"800\\\",\\\"Cover type 1\\\":\\\"Not Available\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\",\"couples\":\"{\\\"Basic Pass\\\":\\\"1200\\\",\\\"Cover type 1\\\":\\\"Not Available\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\"}" // Encoded and converted to string
    }
}
```
Example response body:
```JSON
{
    "message": "Event Details Entered",
    "success": true,
    "data": null,
}
```

### Get All Events:
**GET** `/events/get-all-events`

Example request body:
```
/events/get-all-events?limit=10&offset=0
```
Example response body:
```JSON
{
    "message": "Event Details",
    "success": true,
    "data": [
        {
            "eventId": 25,
            "name": "Valentine's Day Special",
            "image": "http://localhost/file/image1.jpg",
            "userId": "YfQgZzeNTHMKWP5MDNDwckZ1",
            "priceDescription": "{\"maleStag\":\"{\\\"Basic Pass\\\":\\\"850\\\",\\\"Cover type 1\\\":\\\"Not Available\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\",\"femaleStag\":\"{\\\"Basic Pass\\\":\\\"800\\\",\\\"Cover type 1\\\":\\\"Not Available\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\",\"couples\":\"{\\\"Basic Pass\\\":\\\"1200\\\",\\\"Cover type 1\\\":\\\"Not Available\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\"}", // Decoded back to JSON when fetched
            "maleCount": 40,
            "femaleCount": 40,
            "mfRatio": "1:1",
            "description": "REAL EVENTS are back! Join us at Pune Pupper Party 2.0 at Classic Rock Cafe, Kalyani Nagar, for fun games to play with your pups, stand a chance to win exciting gifts for them, get delicious doggy meal plus free goodies for every pet! Humans also get a FREE food & drinks coupon worth Rs. 100 on every ticket!",
            "capacity": 200,
            "clubId": 15,
            "date": "2020/02/14",
            "coupleCount": 60,
            "stagWithCouple": 1,
            "isPremium": 0,
            "time": "20:00"
        },
        {
            "eventId": 24,
            "name": "Friday Night",
            "image": "http://localhost/file/image2.jpg",
            "userId": "a5q7UqOqQxa288cQqmnbq1",
            "priceDescription": "{\"maleStag\":\"{\\\"Basic Pass\\\":\\\"1200\\\",\\\"Cover type 1\\\":\\\"Not Available\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\",\"femaleStag\":\"{\\\"Basic Pass\\\":\\\"1150\\\",\\\"Cover type 1\\\":\\\"1250\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\",\"couples\":\"{\\\"Basic Pass\\\":\\\"1600\\\",\\\"Cover type 1\\\":\\\"Not Available\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\"}",
            "maleCount": 40,
            "femaleCount": 80,
            "mfRatio": "1:2",
            "description": "REAL EVENTS are back! Join us at Pune Pupper Party 2.0 at Classic Rock Cafe, Kalyani Nagar, for fun games to play with your pups, stand a chance to win exciting gifts for them, get delicious doggy meal plus free goodies for every pet! Humans also get a FREE food & drinks coupon worth Rs. 100 on every ticket!",
            "capacity": 200,
            "clubId": 14,
            "date": "2021/02/10",
            "coupleCount": 40,
            "stagWithCouple": 1,
            "isPremium": 0,
            "time": "20:30"
        }
    ],
}
```


### Get a particular event:
**GET** `/events/get-event`

Example request body:
```
/events/get-event?eventId=25
```
Example response body:
```JSON
{
    "message": "Event Details Entered",
    "success": true,
    "data": [
        {
            "eventId": 25,
            "name": "Valentine's Day Special",
            "image": "http://localhost/file/image1.jpg",
            "userId": "YfQgZzeNTHMKWP5MDNDwckZ1",
            "priceDescription": "{\"maleStag\":\"{\\\"Basic Pass\\\":\\\"850\\\",\\\"Cover type 1\\\":\\\"Not Available\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\",\"femaleStag\":\"{\\\"Basic Pass\\\":\\\"800\\\",\\\"Cover type 1\\\":\\\"Not Available\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\",\"couples\":\"{\\\"Basic Pass\\\":\\\"1200\\\",\\\"Cover type 1\\\":\\\"Not Available\\\",\\\"Cover type 2\\\":\\\"Not Available\\\",\\\"Cover type 3\\\":\\\"Not Available\\\",\\\"Cover type 4\\\":\\\"Not Available\\\"}\"}", // Decoded back to JSON when fetched
            "maleCount": 40,
            "femaleCount": 40,
            "mfRatio": "1:1",
            "description": "REAL EVENTS are back! Join us at Pune Pupper Party 2.0 at Classic Rock Cafe, Kalyani Nagar, for fun games to play with your pups, stand a chance to win exciting gifts for them, get delicious doggy meal plus free goodies for every pet! Humans also get a FREE food & drinks coupon worth Rs. 100 on every ticket!",
            "capacity": 200,
            "clubId": 15,
            "date": "2020/02/14",
            "coupleCount": 60,
            "stagWithCouple": 1,
            "isPremium": 0,
            "time": "20:00"
        }
    ],
}
```

### Get premium events:
**GET** `/events/get-premium-event`

Example request body:
```
/events/get-premium-event?limit=10&offset=0
```
Returns the list of all [Premium Events](#get-all-events)

### Get all events of a club:
**GET** `/events/get-club-event`

Example request body:
```
/events/get-club-event?clubId=2&limit=10&offset=0
```
Returns the list of all [Events](#get-all-events) of a club.

### Get event locations for filtering:
**GET** `/events/get-unique-locations`

Example request body:
```
/events/get-unique-locations
```
Example response body:
```JSON
{
    "message": "Unique locations",
    "success": true,
    "data": [
        {
            "location": "Vadgaonsheri"
        },
        {
            "location": "Magerpatta"
        },
        {
            "location": "Hinjewadi"
        },
        {
            "location": "Kharadi"
        }
    ]
}
```

### Get events by location:
**GET** `/events/get-events-by-location`

Example request body:
```
/events/get-events-by-location?location=Hinjewadi&limit=10&offset=0
```
Returns the list of [Events](#get-all-events) in that area.


### Get premium events by location:
**GET** `/events/get-events-by-location`

Example request body:
```
/events/get-events-by-location?location=Hinjewadi&limit=10&offset=0
```
Returns the list of [Premium Events](#get-all-events) in that area.
