import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_practice/model/post_model.dart';
import 'package:http/http.dart'as http;

class PostRepository{
  
  Future<List<PostModel>> fetchPost()async{
    try{
      final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
      if(response.statusCode==200){
        //if response list form then json decode required
        final body = jsonDecode(response.body) as List;
        //run body List loop
        return body.map((e){
          return PostModel(
            postId: e['postId'] as int,
            email: e['email'] as String,
            body: e['body'] as String
          );
        }).toList();
      }
    }on SocketException{
      throw Exception('error while fetching data');
    }on TimeoutException{
      throw Exception('error while fetching data');
    }
    throw Exception('error while fetching data');
  }
}