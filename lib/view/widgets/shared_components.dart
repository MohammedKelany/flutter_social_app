import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStates {
  SUCCESS,
  WIRNINNG,
  ERROR,
}

void getToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Widget customButton({
  required VoidCallback? onPressed,
  required Color color,
  required String text,
  double? width,
}) {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
    ),
    child: MaterialButton(
      onPressed: onPressed,
      textColor: Colors.white,
      minWidth: width,
      child: Text(text),
    ),
  );
}

Color chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.ERROR:
      return Colors.red;
    case ToastStates.WIRNINNG:
      return Colors.yellow;
  }
}

Widget emptyBody({
  required String text,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.queue,
          size: 100,
          color: Colors.black12,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Please Add Some Items in $text',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: Colors.black54,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}
