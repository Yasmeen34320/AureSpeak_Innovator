import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardCamera extends StatefulWidget {
  final String? Images;
  final String? TestName;
  final String? brief;
  final dynamic path;
  const CardCamera(
      {Key? key, this.Images, this.TestName, this.brief, this.path})
      : super(key: key);

  @override
  State<CardCamera> createState() => _CardCameraState();
}

class _CardCameraState extends State<CardCamera> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: screenSize.width * 0.89,
        // height: screenSize.height * 0.4,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF6b5ba0), width: 1.0),
          color: Color.fromARGB(255, 250, 242, 237),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Expanded(
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Container(
                height: 100,
                width: 100,
                child: Image.asset(
                  widget.Images!,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.TestName!,
              style: GoogleFonts.nunito(
                fontSize: 19.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
