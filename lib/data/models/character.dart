class Character {
  late int id;
  late String name, gender, image, status;
  late List<dynamic> episode;

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    gender = json['gender'];
    episode = json['episode'];
  }
}
