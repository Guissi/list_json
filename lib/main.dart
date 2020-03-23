import 'package:flutter/material.dart';

import 'package:list_api/services/product_services.dart';
import 'package:list_api/services/photo_services.dart';
import 'package:list_api/services/address_services.dart';
import 'package:list_api/services/student_services.dart';
import 'package:list_api/services/shape_services.dart';
import 'package:list_api/services/bakery_services.dart';
import 'package:list_api/services/page_services.dart';
import 'package:list_api/services/post_services.dart';
import 'package:list_api/model/post_model.dart';

import 'exemple.dart';

List lstposts;

void main() { runApp(new MyHomePage());
  // loadProduct();
//  loadPhotos();
//  loadAddress();
//  loadStudent();
//  loadShape();
//  loadBakery();
//  loadPage();


}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: MyHomePage());
  }
}

class Home extends StatelessWidget {

  callAPI() {
    lstposts = new List();
    Post post = Post(body: 'Testing body body body', title: 'Flutter jam6');
    createPost(post).then((response) {
      if (response.statusCode > 200)
        print(response.body);
      else
        print(response.statusCode);

    }).catchError((error) {
      print('error : $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    getAllPosts();
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<List<Post>>(
            future: getAllPosts(),
            builder: (context, snapshot) {

              lstposts=snapshot.data;
              callAPI();
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error");
                }
                return ListView.builder(
                    itemCount: lstposts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(children: <Widget>[
                            Text(lstposts[index]['title'], style: TextStyle(fontSize: 16.0,color: Colors.black),),
                            SizedBox(height: 5.0,),
                            Text(lstposts[index]['body'], style: TextStyle(fontSize: 16.0,color: Colors.black),),

                          ]),
                        ),
                      );
                    });
                //return Text('Title from Post JSON : ${snapshot.data.title}');

//                return new Card(
//                  child: Padding(padding: EdgeInsets.all(10.0),child: Column(
//                    children: <Widget>[
//                      Text(snapshot.data.userId.toString()),
//                      Text(snapshot.data.id.toString()),
//                      Text(snapshot.data.title, style: TextStyle(fontSize: 16.0,color: Colors.black),),
//                      SizedBox(height: 5.0,),
//                      Text(snapshot.data.body),
//                    ],
//                  ),),
//                );

              } else
                return CircularProgressIndicator();
            }));
  }
}
