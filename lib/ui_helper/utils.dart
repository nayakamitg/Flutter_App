import 'package:flutter/material.dart';
import 'package:lost_found_app/details.dart';

TextStyle headings() {
  return TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.bold,
    fontFamily: "poppins",
  );
}

TextStyle paragraph({
  Color textColor = Colors.black,
  FontWeight textWidth = FontWeight.bold,
}) {
  return TextStyle(fontSize: 20, color: textColor, fontWeight: textWidth);
}

Widget buildTextField(
  String placeholder,
  TextEditingController controller, {
  TextInputType keyboard = TextInputType.text,
  minlines = 1,
  maxlines = 10,
  String label = "",
  bool required = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(color: Colors.black,fontSize: 22),
              children: [
                if (required)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),

      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: TextFormField(
          minLines: minlines,
          maxLines: maxlines,
          keyboardType: keyboard,
          controller: controller,
          decoration: InputDecoration(
            hint: Text(placeholder, style: TextStyle(color: Colors.grey[700])),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please enter $placeholder";
            }
            return null; // valid case
          },
        ),
      ),
    ],
  );
}

Widget cards(BuildContext context, {required Map<String, dynamic> person}) {
  return Container(
    constraints: BoxConstraints(maxWidth: 240, minHeight: 350, maxHeight: 400),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    person["state"] ?? "Unknown",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.location_on, color: Colors.red),
              ],
            ),

            Center(
              child: Image.network(
                person["images"][0]["imageUrl"].toString(),
                height: 180,
                width: 180,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 10),
            Text(
              person["name"] ?? "No Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // SizedBox(height: 10),
            Text(
              "Age: ${person["age"] ?? 'N/A'}",
              style: TextStyle(fontSize: 14),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MissingPersonDetail(person),
                    ),
                  );
                },
                child: Text("Details"),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
