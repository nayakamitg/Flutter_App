import 'package:flutter/material.dart';
import 'package:lost_found_app/Providers/apiProviders.dart';
import 'package:lost_found_app/details.dart';
import 'package:lost_found_app/ui_helper/utils.dart';
import 'package:provider/provider.dart';

class details extends StatefulWidget {
  final dynamic myFuture;

  const details({super.key, required this.myFuture});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> myFuture = {};
    // void apicalls(BuildContext context) async{
    //   myFuture = await Provider.of<ApiProviders>(context).getPerson();
    // }

    // apicalls(context);
    // List<dynamic> persons = myFuture["data"];

    final provider = Provider.of<ApiProviders>(context);
    List<dynamic> persons = provider.persons;

    dynamic textController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(title: Text("All Missing Person")),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    width: 450,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: textController,

                            decoration: InputDecoration(
                              label: Text(
                                "Search",
                                style: TextStyle(fontSize: 18),
                              ),
                              prefix: Icon(Icons.search),
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    textController.text = "";
                                  });
                                },
                                icon: Icon(Icons.close),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),

                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 0, 255, 21),
                            ),
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Search",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),
                  Wrap(
                    // Horizontal gap
                    runSpacing: 8, // Vertical gap
                    direction: Axis.horizontal,
                    children: persons.map((person) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MissingPersonDetail(person),
                            ),
                          );
                        },
                       
                          child: cards(context, person: person),
                      );
                    }).toList(),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ElevatedButton(
                            onPressed: () {
                              provider.prevData();
                            },
                            child: Icon(
                              Icons.arrow_circle_left_sharp,
                              size: 40,
                            ),
                          ),
                        ),

                        Text("Page no. : ${provider.getpage()}",style: TextStyle(fontSize: 18),),

                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ElevatedButton(
                            onPressed: () {
                              provider.nextData();
                            },
                            child: Icon(
                              Icons.arrow_circle_right_sharp,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (provider.isLoading)
            Positioned(child: Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}
