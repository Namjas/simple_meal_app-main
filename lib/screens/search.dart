import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:meals_app/screens/globals.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchWord;
  var jsonResponse;
  var loaded = false;
  @override
  void initState() {
    super.initState();
  }

  callApi() async {
    setState(() {
      loaded = false;
    });
    String api =
        "https://www.themealdb.com/api/json/v1/1/search.php?s=$searchWord";

    var headers = {"Content-Type": "application/x-www-form-urlencoded"};
    // var url = Uri.https(singleMeal);
    var response = await http.get(api, headers: headers);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
      print((jsonResponse['meals']).length);
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
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.grey[600]),
        title: Text(
          "Search",
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                maxLines: 1,
                decoration: InputDecoration(hintText: "Search Food"),
                onChanged: (val) {
                  setState(() {
                    searchWord = val;
                  });
                },
              ),
              InkWell(
                onTap: () {
                  print("tapped");
                  callApi();
                },
                child: FlatButton(
                  onPressed: () {
                    print("tapped");
                    callApi();
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 15),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      color: Colors.grey[500],
                      child: Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              loaded
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (jsonResponse['meals']).length,
                          itemBuilder: (context, i) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        child: Image.network(
                                            jsonResponse['meals'][i]
                                                ['strMealThumb']),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(jsonResponse['meals'][i]
                                            ['strMeal']),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // name.add(
                                      //     jsonResponse['meals'][0]['strMeal']);
                                      // image.add(jsonResponse['meals'][0]
                                      //     ['strMealThumb']);
                                    },
                                    child: Icon(
                                      Icons.star,
                                      size: 30,
                                      color: Colors.yellow[800],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
