import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String? text;
  const TextView({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amberAccent, width: 3),
        borderRadius:
        const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Text(text ?? ''),
    );
  }
}
