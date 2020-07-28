import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_world/data/local_data.dart';
import 'package:wallpaper_world/model/wallpaper_model.dart';
import 'package:wallpaper_world/widget/widget.dart';

class CategoryView extends StatefulWidget {
  final String categoryPicture;
  CategoryView({@required this.categoryPicture});
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<WallpaperModel> wallpapers = List();

  Map<String, dynamic> jsonData;
  getCategoryResponse(String query) async {
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
    getCategoryResponse(widget.categoryPicture);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: jsonData==null? Center(
        child: CircularProgressIndicator(),
      ):SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20,bottom: 10),
          child: Column(
            children: <Widget>[
              wallpaperTile(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
