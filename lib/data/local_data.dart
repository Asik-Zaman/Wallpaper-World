import '../model/catagorymodel.dart';

String apiKey = '563492ad6f917000010000017f33ef9b40124760899dc8c2d73e7155';

List<CategoryModel> getCategory() {
  List<CategoryModel> category = List();
  CategoryModel categoryModel = CategoryModel();

  categoryModel.catagoryName = "Street Art";
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.catagoryName = "Wild Life";
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.imgUrl =
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.catagoryName = "Nature";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.catagoryName = "City";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categoryModel.catagoryName = "Motivation";

  category.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.catagoryName = "Bikes";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.catagoryName = "Cars";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;
}
