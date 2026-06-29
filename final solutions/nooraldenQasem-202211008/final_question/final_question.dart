import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save & Delete API Demo',
      home: PostScreen(),
    );
  }
}

class PostScreen extends StatefulWidget {
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  List posts = [];


  void fetchPosts() async {
    final response =
    await http.get(Uri.parse("http://universities.hipolabs.com/search?country=jordan"));
    if (response.statusCode == 200) {
      print("succsase");
      setState(() {
        posts = jsonDecode(response.body).take(10).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }


  void savePost() async {
    final response = await http.post(
      Uri.parse("http://universities.hipolabs.com/search?country=jordan"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'title': titleController.text,
        'body': bodyController.text,
        'userId': 1,
      }),
    );

    if (response.statusCode == 201) {
      final newPost = jsonDecode(response.body);
      setState(() {
        posts.insert(0, newPost);
        titleController.clear();
        bodyController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save post')),
      );
    }
  }


  void deletePost(int id) async {
    final response = await http.delete(
      Uri.parse("http://universities.hipolabs.com/search?country=jordan"),
    );

    if (response.statusCode == 200) {
      setState(() {
        posts.removeWhere((post) => post['id'] == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post deleted')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete post')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle:true, title: Text("Jordan university"),),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(labelText: 'Body'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: savePost,
                child: Text('Save Post'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    return Card(

                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(post['name'] ?? 'ee'),
                        subtitle: Column(children: [
                          Row(
                            children: [
                              Image(width: 20, height: 20,image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxhZygxsGh_d6Ps_7FxBz6AksipUK54b0Pb0AeFACGR6vP_AvvGl_GIK0&s=10")),
                              Column(
                                children: [
                                  Text(post['domains'][0] ?? ''),
                                  Row(
                                    children: [

                                      Text("web pages"),
                                      SizedBox(width: 10,),
                                      Text(post['web_pages'][0] ?? ''),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),

                        ],),


                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
