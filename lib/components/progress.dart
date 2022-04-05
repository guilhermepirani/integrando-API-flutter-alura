import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;

  const Progress({this.message = 'Loading', Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(message),
          ),
        ],
      ),
    );
  }
}
