import 'package:flutter/material.dart';

class MissingPersonDetail extends StatelessWidget {
  dynamic AllDetails;

  MissingPersonDetail(Map name, {super.key}) {
    AllDetails = Map.from(name);
  }

  @override
  Widget build(BuildContext context) {
    dynamic photos =
        AllDetails["images"] ??
        [
          {
            "id": 2,
            "imageUrl":
                "https://t4.ftcdn.net/jpg/00/75/63/37/360_F_75633724_BmZ5n4jOMQAatvCmOLqQDspM5O1f8uM9.jpg",
            "description": "Jogging attire photo",
            "missingPersonId": "MP001",
            "missingPerson": null,
          },
          {
            "id": 3,
            "imageUrl":
                "https://t4.ftcdn.net/jpg/00/89/55/15/360_F_89551596_LdHAZRwz3i4EM4J0NHNHy2hEUYDfXc0j.jpg",
            "description": "Jogging attire photo",
            "missingPersonId": "MP001",
            "missingPerson": null,
          },
        ];
    AllDetails.remove("images");

    return Scaffold(
      appBar: AppBar(title: Text("Details Page")),
      body: ListView(
        children: [
          Container(
            color: const Color.fromARGB(216, 180, 220, 253),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              runAlignment: WrapAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(
                   
                    maxHeight: 600,
                    maxWidth: 700,
                  ),
                    height: 400,
                  color: const Color.fromARGB(255, 201, 201, 201),
                  child: Hero(
                    tag: "ImageDetails",
                    child: PageView.builder(
                      itemCount: photos.length,
                      controller: PageController(viewportFraction: 0.9),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 16,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              photos[index]["imageUrl"] ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Container(
                  constraints: BoxConstraints(minHeight: 100, maxWidth: 700),

                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "${AllDetails["name"] ?? "Not found"}",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sectionTitle("General Details..."),
                            infoTable(AllDetails),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Section Title
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Helper Widget for Info Table
  Widget infoTable(Map data) {
    return Table(
      children: [
        for (var entry in data.entries)
          if ((entry.value != null) && (entry.value.toString() != ""))
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "${entry.key} :",
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "${entry.value}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
      ],
    );
  }
}
