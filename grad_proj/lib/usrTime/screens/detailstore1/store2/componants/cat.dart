class Category {
  final String icon, title;

  Category({required this.icon, required this.title});
}

// ignore: non_constant_identifier_names
List<Category> demo_categories = [
  Category(
    icon: "assets/prod.json",
    title: "منتجات العناية",
  ),
  Category(
    icon: "assets/cal.json",
    title: "احسب موعد صيانتك",
  ),
];
