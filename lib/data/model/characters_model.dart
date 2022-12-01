class CharactersModel {
  int? characterId;
  String? name;
  String? birthday;
  List<String>? jobs;
  String? image;
  String? status;
  String? nickname;
  List<int>? appearanceInSeasons;
  String? portrayed;
  String? category;
  List<dynamic>? betterCallSaulAppearance;

  CharactersModel({this.characterId,
        this.name,
        this.birthday,
        this.jobs,
        this.image,
        this.status,
        this.nickname,
        this.appearanceInSeasons,
        this.portrayed,
        this.category,
        this.betterCallSaulAppearance});

  CharactersModel.fromJson(Map<String, dynamic> json) {
    characterId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    jobs = json['occupation'].cast<String>();
    image = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    appearanceInSeasons = json['appearance'].cast<int>();
    portrayed = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance=json['better_call_saul_appearance'];
  }
}