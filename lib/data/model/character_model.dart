class CharacterModel {
  late int id;
  late String name;
  late String status;
  late String species;
  late String gender;
  late String image;
  static List<CharacterModel> occasionTypelist(dynamic extradata) {
    final List<CharacterModel> productlist = [];

    for (var i in extradata) {
      productlist.add(CharacterModel.fromJson(i as Map<String, dynamic>));
    }
    return productlist;
  }

  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    status = json["status"];
    species=json['species'];
    gender=json['gender'];
  }
}
