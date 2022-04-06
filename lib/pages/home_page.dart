import 'package:flutter/material.dart';
import 'package:rest_api/services/remote_services.dart';

import '../models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _addpostcontroller = TextEditingController();
  List<Post>? Posts;
  var isloaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getdata();
  }

  getdata() async {
    Posts = await RemoteServices().getPosts();
    if (Posts != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REST API POST"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text("add a post"),
                    content: Column(
                      children: [
                        TextField(
                          controller: _addpostcontroller,
                        ),
                        ElevatedButton(
                          onPressed: () async{
                            final userinput = _addpostcontroller.text;
                            await RemoteServices().addPosts(userinput);
                            Navigator.pop(context);
                            setState(() {
                              
                            });
                          },
                          child: Text("Add"),
                        ),
                      ],
                    ),
                  ));
        },
        child: Icon(Icons.add),
      ),
      body: Visibility(
        visible: isloaded,
        child: ListView.builder(
          itemCount: Posts?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Posts![index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          Posts![index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
