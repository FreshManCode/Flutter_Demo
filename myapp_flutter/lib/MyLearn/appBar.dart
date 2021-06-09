import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyAppBarDemo"),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("This is a snackbar"),
                  duration:Duration(seconds:1) ,
                ));
              },
              icon: const Icon(Icons.add_alert)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.navigate_next)),
        ],
      ),
      body: const Center(
        child: Text(
          "This is the home page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
