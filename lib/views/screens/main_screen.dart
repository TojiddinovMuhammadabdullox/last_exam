import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Overview"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              child: Icon(
                Icons.person,
              ),
            ),
          )
        ],
      ),
      body: const Column(
        children: [

        ],
      ),
    );
  }
}
