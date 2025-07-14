import 'dart:ui';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lost_found_app/Providers/apiProviders.dart';
import 'package:lost_found_app/account.dart';
import 'package:lost_found_app/add_details.dart';
import 'package:lost_found_app/catagories.dart';
import 'package:lost_found_app/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => ApiProviders(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost and Found',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thickness: MaterialStateProperty.all(1.0),
          thumbColor: MaterialStateProperty.all(
            const Color.fromARGB(0, 255, 153, 0),
          ),
          trackColor: MaterialStateProperty.all(
            const Color.fromARGB(0, 255, 255, 255),
          ),
          radius: Radius.circular(8.0),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            fontFamily: "poppins",
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 18, 0, 177),
        ),
      ),
      home: const MyHomePage(title: 'Lost and Found'),
      //  home: const Practice(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Map<String, dynamic> myFutureData;
  late List<dynamic> myFutureCatData;
  dynamic deadBodies;
  List<Widget> widgetlist = [];
  bool navbar = true;
  int my_index = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    load_data();
  }

  Future<void> load_data() async {
    myFutureData = await ApiProviders.apicall();
    myFutureCatData = await ApiProviders.cat_api();
    deadBodies = await ApiProviders.deadBodies();

    setState(() {
      widgetlist = [
        Home(myFuture: myFutureData["data"], myFutureCat: myFutureCatData,deadBodiesData:deadBodies),
        categories(myFuture: myFutureData, myFutureCat: myFutureCatData),
        add_details(myFutureCat: myFutureCatData),
        account(),
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 18, 0, 177),
        animationDuration: const Duration(milliseconds: 500),
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.list, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.account_circle, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            my_index = index;
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 0, 177),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: Colors.white,
              onPressed: () {
                setState(() {
                  navbar = !navbar;
                });
              },
              icon: navbar ? const Icon(Icons.menu) : const Icon(Icons.close),
            ),
            Center(
              child: Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              color: Colors.white,
              onPressed: () {},
              icon: const Icon(Icons.lightbulb),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background blur and image
          Positioned(
            top: 100,
            height: 600,
            width: 600,
            right: -200,
            child: Image.asset("assets/images/Spline.png"),
          ),

          //  RiveAnimation.asset(
          //     "assets/animations/shapes.riv",
          //     fit: BoxFit.cover,
          //   ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(height: double.infinity),
          ),

          // Show loading spinner if data not ready
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            widgetlist[my_index],

          // Transparent tap to close navbar
          if (!navbar)
            GestureDetector(
              onTap: () {
                setState(() {
                  navbar = true;
                });
              },
              child: Container(color: Colors.transparent),
            ),

          // Side menu
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: navbar ? -250 : 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  width: 250,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                    color: Color.fromARGB(174, 18, 0, 177),
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Home",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Text(
                            "About us",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Text(
                            "Categories",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Text(
                            "Contact us",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
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
