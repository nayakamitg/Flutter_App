import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  var textController = TextEditingController();
  var Database_store = "No data found";
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Practice Page")),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                height: 70,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(controller: textController),
              ),

              ElevatedButton(
                onPressed: () async {
                  var pref = await SharedPreferences.getInstance();
                  pref.setString("name", textController.text.toString());
                },
                child: Container(
                  color: Colors.green,
                  padding: const EdgeInsets.all(10),
                  child: Text("Add To Shared Preference"),
                ),
              ),

              Text("Stored Data"),
              Text(Database_store),
            ],
          ),
        ),
      ),
    );
  }

  void getData() async {
    var pref = await SharedPreferences.getInstance();
    var new_data = pref.getString("name");
    Database_store = new_data ?? "No data found";
    setState(() {
      
    });
  }
}
