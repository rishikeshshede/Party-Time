import 'dart:convert';

import 'package:http/http.dart' as http;

String baseUrl = 'http://bookario.com/apis/';
String imageBaseUrl = 'http://bookario.com/';

Map<String, String> allHeaders = {
  "Content-Type": "application/json",
  "Accept": "application/json",
};

class Networking {
  static dynamic post(String route, Map<dynamic, dynamic> parameters) async {
    print('POST: Sending Post Request');

    var response = await http.post(baseUrl + route,
        body: json.encode(parameters), headers: allHeaders);

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
      print('Error: ' + response.body);
      return null;
    }
  }

  static dynamic getData(String route, Map<String, dynamic> parameters) async {
    print('Sending Get request...');
    String queryString = Uri(queryParameters: parameters).query;
    var requestUrl = baseUrl + route + '?' + queryString;
    var response = await http.get(requestUrl);

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
      print('Error: ' + response.body);
      return null;
    }
  }
}
