import 'dart:convert';

import 'package:http/http.dart' as http;

String baseUrl = 'https://bookario.com/endpoints/';

class Networking {
  static dynamic post(String route, Map<dynamic, dynamic> parameters) async {
    print('POST: Sending Post Request');
    var response = await http.post(
      baseUrl + route,
      body: parameters,
    );

    if (response.statusCode == 200) {
      var body;
      try {
        body = jsonDecode(response.body);
      } catch (e) {
        print(e.toString());
        return null;
      }

      return body;
    } else {
      print(response.body);
      print('An error occured.');
      return null;
    }
  }
}
