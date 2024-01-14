// ignore_for_file: constant_identifier_names

enum City {
  Jenin,
  Qalqilya,
  Hebron,
  Jericho,
  Nablus,
  Salfit,
  Jerusalem,
}

class DenemoModel {
  String name;
  City location;

  DenemoModel({
    required this.name,
    required this.location,
  });
}

List<DenemoModel> denemoList = [
  DenemoModel(name: "دينموميتر بلدية عرابة", location: City.Jenin),
  DenemoModel(name: "دينيموميتر بلدية جنين", location: City.Jenin),
  DenemoModel(name: "دينيموميتر بلدية قلقيلية", location: City.Qalqilya),
  DenemoModel(
      name: "دينيموميتر جنين - شركة الحوار للاستثمار ", location: City.Jenin),
  DenemoModel(name: "دينيموميتر بلدية يطا", location: City.Nablus),
  DenemoModel(name: "دينيموميتر بلدية أريحا", location: City.Jericho),
  DenemoModel(name: "سالم وشركاه", location: City.Nablus),
  DenemoModel(name: "دينيموميتر بلدية سلفيت", location: City.Salfit),
  DenemoModel(name: "دينيموميتر القدس", location: City.Jerusalem),
];
