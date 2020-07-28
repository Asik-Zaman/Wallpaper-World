import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_world/model/wallpaper_model.dart';
import 'package:wallpaper_world/views/category_view.dart';
import '../widget/widget.dart';
import '../data/local_data.dart';
import '../model/catagorymodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import '../views/search_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = List();
  List<WallpaperModel> wallpapers = List();

  TextEditingController searchController = new TextEditingController();

  Map<String, dynamic> jsonData;
  getCouratedResponse() async {
    http.Response response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=15&page=1",
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

  Future fetchData() async {
    getCouratedResponse();
    categories = getCategory();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appbar(),
      ),
      body: jsonData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: fetchData,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 15),
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SearchPage(
                                      searchQuery: searchController.text,
                                    );
                                  }));
                                },
                                child: Icon(Icons.search)),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                imgUrl: categories[index].imgUrl,
                                title: categories[index].catagoryName,
                              );
                            }),
                      ),
                      wallpaperTile(wallpapers: wallpapers, context: context)
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrl, title;
  CategoryTile({@required this.imgUrl, @required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryView(categoryPicture: title.toLowerCase());
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                alignment: Alignment.center,
                color: Colors.black26,
                height: 60,
                width: 120,
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
