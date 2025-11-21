class Food {
  String name;
  String price;
  String imagePath;
  String ratting;
  String description;

  Food({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.ratting,
    required this.description,
  });

  String get _name =>name ;
  String get _price =>price ;
  String get _imagePath =>imagePath ;
  String get _ratting =>ratting ;
  String get _description=>description ;


}
