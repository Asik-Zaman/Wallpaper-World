import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_world/views/image_view.dart';
import '../model/wallpaper_model.dart';

Widget appbar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        'Wallpaper',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(
        'World',
        style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),
      )
    ],
  );
}

Widget wallpaperTile({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 13),
    child: GridView.count(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      crossAxisCount: 2,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ImageView(imgUrl: wallpaper.src.portrait);
              }));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: wallpaper.src.portrait,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
