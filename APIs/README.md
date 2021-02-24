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
Example response body:
```JSON
{
    "message": "Details Recieved",
    "success": true,
    "data": [
        {
            "userId": "YfQgZzeNTHMKWPwckZAsdU4",
            "name": "Rishikesh Shede",
            "email": "rishi@gmail.com",
            "phone": "1234567890",
            "userCategory": "customer",
            "gender": "Male",
            "age": 22
        }
    ]
}
```
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
            "image": "http://bookario.com/apis/file/myClubImage.jpeg",
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
            "image": "http://bookario.com/apis/file/myClubImage.jpeg",
            "description": "REAL EVENTS are back! Join us at Pune Pupper Party  2.0 at Classic Rock Cafe, Kalyani Nagar, for fun games to play with your pups, stand a chance to win exciting gifts for them, get delicious doggy meal plus free goodies for every pet! Humans also get a FREE food & drinks coupon worth Rs. 100 on every ticket!"
        }
    ],
}
```

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
            "image": "http://bookario.com/apis/file/myClubImage.jpeg",
            "description": "REAL EVENTS are back! Join us at Pune Pupper Party  2.0 at Classic Rock Cafe, Kalyani Nagar, for fun games to play with your pups, stand a chance to win exciting gifts for them, get delicious doggy meal plus free goodies for every pet! Humans also get a FREE food & drinks coupon worth Rs. 100 on every ticket!"
        },
        {
            "clubId": 14,
            "name": "Publiq",
            "userId": "a5q7UqOqQxa288cQqmnbylCI3qq1",
            "location": "Magerpatta",
            "address": "White Square, 9th Floor, 901, Hinjewadi Phase 1 Road, Hinjewadi, Pune",
            "image": "http://bookario.com/apis/file/myClubImage2.jpg",
            "description": "Publiq has free entry through the week and offers ladies night on Wednesdays. If you are one who loves dancing to Bollywood songs, then you must hit the club on a Friday night. Publiq has three locations in Pune, each offering a refined crowd that is both fun."
        }
    ],
}
```
---
