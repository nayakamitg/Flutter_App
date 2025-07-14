import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lost_found_app/ui_helper/utils.dart';

class add_details extends StatefulWidget {
  final List<dynamic> myFutureCat;

  const add_details({super.key, required this.myFutureCat});

  @override
  State<add_details> createState() => _add_details();
}

class _add_details extends State<add_details> {
  final _formKey = GlobalKey<FormState>();

  // Person Details
  var fullNameController = TextEditingController();
  var fatherNameController = TextEditingController();
  var genderController = TextEditingController();
  var ageController = TextEditingController();
  var nationalityController = TextEditingController();
  var addressController = TextEditingController();
  var mobileController = TextEditingController();
  var clothesController = TextEditingController();
  var fatherOccuController = TextEditingController();
  var religionController = TextEditingController();
  // var habitsAddictionsController = TextEditingController();
  // var studentInfoController = TextEditingController();
  // var placeOfRegularVisitController = TextEditingController();
  var qualificationController = TextEditingController();
  var missingSinceController = TextEditingController();
  var missingFromLocationController = TextEditingController();
  // var healthConditionsController = TextEditingController();
  var descriptionController = TextEditingController();
  // var statusController = TextEditingController();

  // // Contact Person
  var contactNameController = TextEditingController();
  // var contactAddressController = TextEditingController();
  var contactPhoneController = TextEditingController();
  // var contactIdController = TextEditingController();

  // // Physical Features
  var heightController = TextEditingController();
  // var hairController = TextEditingController();
  // var complexionController = TextEditingController();
  // var builtController = TextEditingController();
  // var faceController = TextEditingController();
  var identificationMarksController = TextEditingController();

  // // Photo
  List<PlatformFile> _pickedFiles = [];
  List<String> imageCodeStr = [];

  Future<void> pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      for (var index in result.files) {
        File file = File(index.path!);
        List<int> imageByte = await file.readAsBytes();
        String imageCode = base64Encode(imageByte);
        imageCodeStr.add(imageCode);
      }

      setState(() {
        _pickedFiles = result.files;
      });
    }
  }

  // var photoDescriptionController = TextEditingController();

  // // Languages
  var language1Controller = TextEditingController();
  // var language2Controller = TextEditingController();
  // var language3Controller = TextEditingController();

  dynamic selectedValue;
  @override
  Widget build(BuildContext context) {
    List<String> name = [];
    List<dynamic> category = widget.myFutureCat;
    for (dynamic item in category) {
      name.add(item["categoryName"]);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Center(
          child: Text("Add Details", style: TextStyle(fontSize: 28)),
        ),
      ),
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: SizedBox(
              height: double.infinity,
              child: Center(
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(),

                  child: ListView(
                    
                    children: [
                      Container(height: 50),
                      Container(
                        height: 60,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromARGB(199, 15, 15, 15),
                          ),
                        ),

                        child: DropdownButton<String>(
                          itemHeight: 50,
                          hint: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Select a Category",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          value: selectedValue,
                          items: name.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                      ),
                      if (selectedValue == "Person")
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              // Photos
                              // Divider(thickness: 3),
                              buildTextField(
                                "Full Name",
                                fullNameController,
                                label: "Full name",
                                required: true,
                              ),

                              buildTextField(
                                "Father Name",
                                fatherNameController,
                                label: "Father Name",
                                required: true,
                              ),

                              buildTextField(
                                "Age",
                                ageController,
                                label: "Age",
                                required: true,
                              ),

                              buildTextField(
                                "Mobile1,Mobile2,...",
                                mobileController,
                                label: "Mobile Number",
                                required: true,
                              ),

                              buildTextField(
                                "Missing from location",
                                missingFromLocationController,
                                label: "Missing from location",
                                required: true,
                              ),

                              buildTextField(
                                "Missing Date",
                                missingSinceController,
                                keyboard: TextInputType.datetime,
                                label: "Missing Date",
                                required: true,
                              ),

                              buildTextField(
                                "Father Occupation",
                                fatherOccuController,
                                label: "Father Occupation",
                              ),

                              buildTextField(
                                "Example: HINDU",
                                religionController,
                                label: "Relegion",
                              ),

                              buildTextField(
                                "Example: 5.5feet or 155cm",
                                heightController,
                                label: "Height",
                                required: true,
                              ),

                              buildTextField(
                                "Address",
                                addressController,
                                keyboard: TextInputType.multiline,
                                minlines: 3,
                                label: "Address",
                                required: true,
                              ),

                              buildTextField(
                                "Example: Color, Type etc",
                                clothesController,
                                keyboard: TextInputType.multiline,
                                minlines: 3,
                                label: "Clothes Description",
                              ),

                              buildTextField(
                                "Description",
                                descriptionController,
                                keyboard: TextInputType.multiline,
                                minlines: 3,
                                label: "Description",
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Upload images",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' *',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: pickImages,
                                child: const Text("Pick Images"),
                              ),

                              SizedBox(height: 10),
                              if (_pickedFiles.isNotEmpty)
                                SizedBox(
                                  height: 300,
                                  child: GridView.builder(
                                    padding: const EdgeInsets.all(10),
                                    itemCount: _pickedFiles.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                    itemBuilder: (_, index) {
                                      return Image.file(
                                        File(_pickedFiles[index].path!),
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),

                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Colors.greenAccent,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Sab kuch sahi hai
                                      print(
                                        "Form is valid: ${fullNameController.text}",
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 50,
                                      right: 50,
                                    ),
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(fontSize: 20),
                                    ),
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
            ),
          ),
        ],
      ),
    );
  }
}
