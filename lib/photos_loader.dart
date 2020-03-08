import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get('https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9');

  return compute(parsePhotos, response.body);
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String title;
  final String author;
  final String small;
  final String large;

  Photo({this.title, this.author, this.small, this.large});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      title: (json['description'] != null ? json['description'] : json['alt_description']) as String,
      author: json['user']['name'] as String,
      small: json['urls']['small'] as String,
      large: json['urls']['regular'] as String,
    );
  }
}