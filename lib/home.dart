import 'package:flutter/material.dart';
import 'package:lost_found_app/details.dart';
import 'package:lost_found_app/see_all_screen.dart';
import 'package:lost_found_app/ui_helper/utils.dart';

class Home extends StatefulWidget {
  final List<dynamic> myFuture;
  final List<dynamic> myFutureCat;
  dynamic deadBodiesData;

   Home({
    super.key,
    required this.myFuture,
    required this.myFutureCat,
    required this.deadBodiesData,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<dynamic> persons;
  late List<dynamic> categories;

  @override
  void initState() {
    super.initState();

    // Deep copy of data to avoid modifying original reference
    persons = widget.myFuture.map((e) => Map<String, dynamic>.from(e)).toList();
    categories = widget.myFutureCat;

    for (var person in persons) {
      // Handle missing or empty images
      if (person["images"] == null || person["images"].isEmpty) {
        person["images"] = [
          {
            "imageUrl":
                "https://thumbs.dreamstime.com/b/no-image-available-like-missing-picture-no-image-available-like-missing-picture-linear-flat-simple-style-modern-logotype-graphic-255657435.jpg",
            "description": "No image available",
          },
        ];
      } else {
        // Prepend base URL to image path if needed
        for (var img in person["images"]) {
          if (!(img["imageUrl"] as String).startsWith("https://")) {
            img["imageUrl"] =
                "https://goplanup.dishaayein.com/${img["imageUrl"]}";
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, catIndex) {
          if (catIndex == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading and See More
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${categories[catIndex]["categoryName"]}",
                        style: headings(),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              barrierDismissible: true,
                              pageBuilder: (context, animation, _) =>
                                  details(myFuture: persons),
                              transitionsBuilder:
                                  (context, animation, _, child) {
                                    return ScaleTransition(
                                      scale: CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeInOutBack,
                                      ),
                                      child: child,
                                    );
                                  },
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 40),
                          child: Text(
                            "See more",
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Horizontal scroll of person cards
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: persons.length,
                    itemBuilder: (context, personIndex) {
                      if (categories[catIndex]["categoryId"] == "1") {
                        final person = persons[personIndex];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MissingPersonDetail(person),
                              ),
                            );
                          },
                          child: cards(context, person: person),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
