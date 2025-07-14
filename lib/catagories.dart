import 'package:flutter/material.dart';
import 'package:lost_found_app/see_all_screen.dart';

class categories extends StatefulWidget {
   final List<dynamic> myFutureCat;
   final Map<String,dynamic> myFuture;
const categories({
    super.key,
    required this.myFuture,
    required this.myFutureCat,
    
  });

 
  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  
  @override
  Widget build(BuildContext context) {
    List<dynamic> categories = widget.myFutureCat;
    return Scaffold(
       backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 20,
                children: [
                  for (var item in categories)
                    InkWell(
                      onTap: () {
                        if(item["categoryName"]=="Person"){
                            Navigator.of(context).push(
                                    PageRouteBuilder(
                                      opaque: false,
                                      barrierDismissible: true,
                                      pageBuilder: (context, animation, _) =>
                                          details(myFuture: widget.myFuture["data"]),
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
                        }
                      },
                      child: Card(
                        color: Color.fromARGB(122, 105, 128, 255),
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Center(
                            child: Text(
                              "${item["categoryName"]} ${item["icon"]}",
                              style: TextStyle(fontSize: 25,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
            }
     
}
