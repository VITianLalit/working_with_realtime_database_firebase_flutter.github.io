import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final postController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
          ),
          child: Text("Add Post", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.yellow),),

        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextFormField(
              maxLines: 5,
              controller: postController,
              decoration: InputDecoration(
                hintText: "What is in your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                databaseRef.child(id).set({
                  'title': postController.text.toString(),
                  'id': id,
                }).then((value) => null);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text("SUBMIT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
