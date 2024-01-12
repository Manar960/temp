// ignore: camel_case_types
class cardsprand {
  final String title, title2, image1;

  cardsprand({required this.title, required this.image1, required this.title2});
}

List<cardsprand> cards = [
  cardsprand(
      title: "FIAT", image1: "assets/images/fiatlogo.png", title2: "20 موديل"),
  cardsprand(
      title: "BMW", image1: "assets/images/bmw-logo.png", title2: "35 موديل"),
  cardsprand(
      title: "Mercedes",
      image1: "assets/images/mercedeslogo.png",
      title2: "30 موديل"),
  cardsprand(
      title: "HYUNDAI",
      image1: "assets/images/hondalogo.png",
      title2: "25 موديل"),
];
