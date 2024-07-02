import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.width,
      required this.height,
      required this.buttontextsize,
      required this.icon});

  final String text;
  final Function() onPressed;
  final double width;
  final double height;
  final double buttontextsize;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor:
                Colors.transparent, // Change this to the text color you prefer
            elevation: 0, // You can adjust the elevation as needed
            minimumSize: Size(double.infinity, 50),
            textStyle: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            onPressed();
          },
          child: Text(this.text,
              style: TextStyle(
                fontSize: this.buttontextsize,
                color: Colors.white,
              ))),
    );
  }
}
