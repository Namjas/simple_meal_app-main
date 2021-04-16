import 'package:flutter/material.dart';
import 'package:meals_app/screens/globals.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          iconTheme: IconThemeData(color: Colors.grey[600]),
          title: Text(
            "Favorites",
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: name.length > 0
            ? ListView.builder(
                itemCount: name.length,
                itemBuilder: (context, i) {
                  return Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: Image.network(image[i]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(name[i]),
                      ),
                    ],
                  );
                })
            : Center(
                child: Container(
                child: Text("No favorites"),
              )));
  }
}
