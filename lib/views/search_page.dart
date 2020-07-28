import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/wallpaper_model.dart';
import '../data/local_data.dart';
import '../widget/widget.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  final String searchQuery;
  SearchPage({@required this.searchQuery});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<WallpaperModel> wallpapers = List();
  TextEditingController searchController = new TextEditingController();

  Map<String, dynamic> jsonData;
  getSearchResponse(String query) async {
    http.Response response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1",
        headers: {"Authorization": apiKey});

    jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.formJson(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {
      jsonData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    getSearchResponse(widget.searchQuery);
    searchController.text = widget.searchQuery;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appbar(),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'Search Photo Here',
                            border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          getSearchResponse(searchController.text);
                        },
                        child: Icon(Icons.search)),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              wallpaperTile(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
