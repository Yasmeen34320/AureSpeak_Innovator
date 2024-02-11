import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grd_projecttt/Screens/test_screen.dart';
import 'package:grd_projecttt/Shared/card_camera.dart';
import 'package:grd_projecttt/Shared/card_category.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size; // Color(0xFFF7F5F5)
    var color = Colors
        .white; //Color.fromARGB(255, 160, 64,64); //Color(0xFF5164BF); //Color.fromARGB(255, 31, 122, 207);
    List<String> datacolor = ["Color Recognition", "Money Recognition"];
    List<String> databreif = [
      "involves the capability to identify and process colors within images or through the device's camera.",
      "simply point your device's camera at banknotes, and it  will identify the currency denomination."
    ];
    List<String> dataimage = ["lib/assest/color1.jpg", "lib/assest/money1.jpg"];
    List<dynamic> p = [Testscreen(), Testscreen()];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Auraspeak Innovator',
          style: GoogleFonts.nunito(
            fontSize: 25,
            color: Color.fromRGBO(7, 7, 7, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: color,
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
                print('Back button pressed');
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            "lib/assest/1 (6).png",
            fit: BoxFit.cover,
            color: Color(0xFF6b5ba0),
          ),
          SizedBox(
            height: 18,
          ),
          Expanded(
              child: Column(children: [
            for (var i = 0; i < dataimage.length!; i++)
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Testscreen()),
                  );
                },
                child: CardCamera(
                  Images: dataimage[i],
                  TestName: datacolor[i],
                  brief: databreif[i],
                  path: p[i],
                ),
              )
          ]))
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 2, // Replace with your actual item count
          //     itemBuilder: (context, index) {
          //       // Replace with your list item widget
          //       return InkWell(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => DetailsScreen()),
          //           );
          //         },
          //         child: CardCategory(
          //           Images: dataimage[index],
          //           TestName: datacolor[index],
          //           brief: databreif[index],
          //           path: p[index],
          //         ),
          //       );
          //     },
          //   ),
          // ),
          ,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12.0),
                      topRight: Radius.circular(12.0)),
                  child: Image.asset(
                    "lib/assest/1 (1).png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12.0),
                      topRight: Radius.circular(12.0)),
                  child: Image.asset(
                    "lib/assest/1 (4).png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
