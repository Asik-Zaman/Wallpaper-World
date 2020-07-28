

class WallpaperModel {
  String photographer;
  String photographer_url;
  int photographer_id;
  SrcModel src;

  WallpaperModel(
      {this.photographer,
      this.photographer_url,
      this.photographer_id,
      this.src});

  factory WallpaperModel.formJson(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      src: SrcModel.formMap(jsonData["src"]),
      photographer: jsonData["photographer"],
      photographer_id: jsonData["photographer_id"],
      photographer_url: jsonData["photographer_url"],
    );
  }
}

class SrcModel {
  String original;
  String small;
  String portrait;

  SrcModel({this.original, this.small, this.portrait});

  factory SrcModel.formMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      original: jsonData["original"],
      small: jsonData["small"],
      portrait: jsonData["portrait"],
    );
  }
}
