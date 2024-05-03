import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leetcode_ranklist_generator/screens/profile_page.dart';

import '../constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> profiles = [];
  TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 161, 22, 0.4),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Text(profiles[index]),
                onTap: () async {
                  var response = await http.get(Uri.parse(
                      'https://leetcode-stats-api.herokuapp.com/${profiles[index]}'));
                  Map<String, dynamic> profileMap = jsonDecode(response.body);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfilePage(profileData: profileMap),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "Delete Profile?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                            "Are you sure to delete the profile ${profiles[index]}?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                profiles.remove(profiles[index]);
                              });
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
          itemCount: profiles.length,
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    buttonPadding: EdgeInsets.all(8),
                    title: Text("Enter Username"),
                    content: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(255, 161, 22, 0.3),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          if (_usernameController.text.isNotEmpty) {
                            showLoadingIndicator(context);
                            var response = await http.get(Uri.parse(
                                'https://leetcode-stats-api.herokuapp.com/${_usernameController.text}'));
                            print(response.body);
                            print(81);
                            Map<String, dynamic> responseData =
                                jsonDecode(response.body);
                            if (responseData['status'] == "error") {
                              Navigator.of(context, ).pop();

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Username not found"),
                                  content:
                                      Text("Please enter correct username"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Ok"),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              Navigator.of(context, rootNavigator: true).pop();
                              setState(() {
                                profiles.add(_usernameController.text);
                              });

                            }
                          }
                          _usernameController.text = "";
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text("Add"),
                      ),
                      TextButton(
                        onPressed: () {
                          _usernameController.text = "";
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                    actionsPadding: EdgeInsets.all(8),
                  );
                });
          },
        ),
      ),
    );
  }
}
