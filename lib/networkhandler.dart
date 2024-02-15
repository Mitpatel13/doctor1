import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart'; // logger used for arrange the result and error

class NetworkHandler {
  GetStorage box = GetStorage();
  //  String baseurl = "http://fda.intertoons.com/api/V1";
  String baseurl = "https://vaidhya421.herokuapp.com/doctors";
  // String baseurl = "http://192.168.205.82:3000/doctors";
  var log = Logger(); // creating instance  for logger

  Future get(dynamic url) async {
    var id = box.read("token");
    url = formatter(url);
    var response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $id"});
    if (response.statusCode == 200 || response.statusCode == 202) {
      return json.decode(response.body);
    }
  }

  Future post(dynamic url, var body) async {
    url = formatter(url);
    var uri = Uri.parse(url);
    var response = await http.post(uri,
        headers: {
          "Content-type": "application/json"
          // "Access-Control-Allow-Headers":
          //     "Origin, X-Requested-With, Content-Type, Accept"
        },
        body: jsonEncode(body));
    return (response);
    // return json.decode(response.body);
  }

  Future post2(dynamic url, var body) async {
    var id = box.read("token");
    url = formatter(url);
    var uri = Uri.parse(url);
    var response = await http.post(uri,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $id"
          // "Access-Control-Allow-Headers":
          //     "Origin, X-Requested-With, Content-Type, Accept"
        },
        body: jsonEncode(body));
    // log.i(response.statusCode);
    return (response);
    // return json.decode(response.body);
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    var uri = formatter(url);
    var request = http.MultipartRequest(
        'PATCH', Uri.parse(uri)); // sending the long files
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type": "application/json",
    });

    var response = request.send();
    // log.i(response);
    return response;
  }

  NetworkImage getImage(String path) {
    // path = "http://192.168.109.82:3000$path";
    return NetworkImage(path);
  } // this is for accessing image from backend

  String formatter(String url) {
    return baseurl + url;
  }
}
