import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Screens/details_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Testscreen extends StatefulWidget {
  const Testscreen({super.key});

  @override
  State<Testscreen> createState() => _TestscreenState();
}

class _TestscreenState extends State<Testscreen> {
  @override
  Widget build(BuildContext context) {
    File? file;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Color Recognition',
          style: GoogleFonts.nunito(
            fontSize: 25,
            color: Color.fromRGBO(7, 7, 7, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF6b5ba0), // Color(0xFF5164BF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 25,
              color: Colors.white,
              onPressed: () {
                // Add your custom logic for handling the back button press
                // You can use Navigator.pop(context) to pop the current screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsScreen()),
                );
                print('Back button pressed');
              },
            ),
          ),
        ),
      ),
      body: Column(children: [
        Image.asset(
          "lib/assest/1 (6).png",
          fit: BoxFit.cover,
          color: Color(0xFF6b5ba0),
        ),
        SizedBox(
          height: 18,
        ),
        SizedBox(
          height: 30,
        ),
        Column(children: [
          Text("Option",
              style: GoogleFonts.pangolin(
                  fontSize: 22, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  print('Button Pressed');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Color.fromARGB(255, 102, 87, 153),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.text_format,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Text',
                      style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  print('Button Pressed');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Color.fromARGB(255, 102, 87, 153),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.record_voice_over_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      'Speech',
                      style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ])
      ]),
    );
  }
}
