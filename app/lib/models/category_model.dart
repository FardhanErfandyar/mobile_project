class CategoryModel {
  String name;
  String image;

  CategoryModel({required this.name, required this.image});

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
        name: "Futsal", image: "assets/images/lines-football-field.jpg"));

    return categories;
  }
}
