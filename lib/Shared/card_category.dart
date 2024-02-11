// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Import statements remain the same

class CardCategory extends StatelessWidget {
  final String? Images;
  final String? TestName;
  final String? brief;
  final dynamic? path;
  const CardCategory(
      {Key? key, this.Images, this.TestName, this.brief, required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var color = Color(
        0xFF6b5ba0); //Color(0xFF5164BF); //Color.fromARGB(255, 31, 122, 207);
    return InkWell(
      onTap: () {
        print("sdsdsdsdsdsd");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => path!),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 5, bottom: 15),
        child: Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            // color: Colors.amber,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 242, 237),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2.0,
                  blurRadius: 10.0,
                  offset: const Offset(0, 10),
                ),
              ],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12.0),
                  topRight: Radius.circular(12.0)),
            ),

            child: Row(children: [
              Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12.0),
                      topRight: Radius.circular(12.0)),
                  child: Image.asset(
                    this.Images!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, bottom: 8, top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TestName!,
                          style: GoogleFonts.pangolin(
                              fontSize: 22,
                              color: color,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        brief!,
                        // Set the maximum number of lines
                        softWrap: true,
                        style: GoogleFonts.nunito(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
