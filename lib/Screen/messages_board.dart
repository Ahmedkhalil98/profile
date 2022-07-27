import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MessagesBoard extends StatefulWidget {
  const MessagesBoard({Key? key}) : super(key: key);

  @override
  State<MessagesBoard> createState() => _MessagesBoardState();
}

class _MessagesBoardState extends State<MessagesBoard> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "MESSAGES",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),

              //Stream builder
              Container(
                height: 400,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: _db.collection("messages").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading ...");
                      }
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            List<QueryDocumentSnapshot<Map<String, dynamic>>>
                                data = snapshot.data!.docs;
                            return Container(
                              width: 350,
                              height: 120,
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 2, color: Colors.green),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].data()["full Name"].toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      data[index].data()["message"].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 250,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 1, color: Colors.grey))),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "SEND ME A MESSAGE",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color: Colors.grey),
                ),
                child: TextFormField(
                  controller: messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Your message..."),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 50,
                      // width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1.5, color: Colors.grey),
                      ),
                      child: TextFormField(
                        controller: nameController,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Your Name"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          addMessageToFirebase(
                            message: messageController.value.text,
                            name: nameController.value.text,
                          );
                          messageController.clear();
                          nameController.clear();
                        },
                        icon: Icon(
                          Icons.send,
                          size: 40,
                          color: Colors.greenAccent,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<DocumentReference<Map<String, dynamic>>> addMessageToFirebase(
      {String? message, String? name}) async {
    DocumentReference<Map<String, dynamic>> add =
        await _db.collection("messages").add({
      'full Name': name,
      'message': message,
    });
    return add;
  }
}
