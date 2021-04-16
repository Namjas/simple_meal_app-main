import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meals_app/api.dart';
import 'package:meals_app/screens/favorites.dart';
import 'package:meals_app/screens/globals.dart';
import 'dart:convert' as convert;

import 'package:meals_app/screens/search.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var jsonResponse;
  bool loaded = false;
  bool favorite = false;

  @override
  void initState() {
    callApi();
    super.initState();
  }

  callApi() async {
    var headers = {"Content-Type": "application/x-www-form-urlencoded"};
    // var url = Uri.https(singleMeal);
    var response = await http.get(singleMeal, headers: headers);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse['meals'][0]['strMealThumb']);
      setState(() {
        loaded = true;
      });
    }
    print(response.body.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Search()));
                },
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 15.0),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => Search()));
            //     },
            //     child: Icon(
            //       Icons.favorite,
            //       color: Colors.grey,
            //     ),
            //   ),
            // )
          ],
          title: Text(
            "Meals",
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: loaded
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(30),
                      child: Card(
                        elevation: 3,
                        child: Image.network(
                          jsonResponse['meals'][0]['strMealThumb'],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: AutoSizeText(
                              jsonResponse['meals'][0]['strMeal'],
                              presetFontSizes: [25, 23, 22, 20, 19],
                              maxLines: 5,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  // fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // name.add(jsonResponse['meals'][0]['strMeal']
                              //     .toString());
                              // image.add(jsonResponse['meals'][0]['strMealThumb']
                              //     .toString());
                            },
                            child: Icon(
                              Icons.star,
                              size: 30,
                              color: Colors.yellow[800],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
