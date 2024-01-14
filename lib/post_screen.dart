import 'package:dummy/add_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'Login&SignUp/login_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Text("Post Screen", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.yellow),),

        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.yellow,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())));
              },
              icon: Icon(Icons.logout, size: 30,)
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        height: 500,
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                  query: databaseRef,
                  itemBuilder: (context, snapshot, animation, index){
                    String title = snapshot.child('title').value.toString();
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              child: ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  showMyDialog(title, snapshot.child('id').value.toString());
                                },
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              )
                          ),
                          PopupMenuItem(
                              child: ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  databaseRef.child(snapshot.child('id').value.toString()).remove();
                                },
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              )
                          ),
                        ],
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async{
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(
                  hintText: 'Edit'
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);
                databaseRef.child(id).update({
                  'title': editController.text.toLowerCase()
                });
              }, child: Text('Update')),
            ],
          );
        }
    );
  }
}
