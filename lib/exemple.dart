
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_api/services/post_services.dart';

import 'model/post_model.dart';
List lstposts;
Future<List<Post>> post;


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  callAPI() {
    lstposts=new List();
    getAllPosts();
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
  void initState() {
    // TODO: implement initState
    lstposts = new List();
    super.initState();
    getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                      return Card(
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
