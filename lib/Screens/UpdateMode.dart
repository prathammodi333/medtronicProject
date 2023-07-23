import 'package:flutter/material.dart';

class UpdateMode extends StatefulWidget {
  const UpdateMode({super.key});

  @override
  State<UpdateMode> createState() => _UpdateModeState();
}

class _UpdateModeState extends State<UpdateMode> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Update Mode")),
    ));
  }
}
