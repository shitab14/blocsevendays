import '../domain/key_entity.dart';

class KeyModel {
  final String? key;

  KeyModel({
    required this.key,
  });

  factory KeyModel.fromJson(Map<String, dynamic> json) {
    final key = json['ap1_key0'] as String;
    return KeyModel(
      key: key,
    );
  }

  Map<String, dynamic> toJson() => {
    'ap1_key0': key,
  };

  KeyEntity toEntity() => KeyEntity(key: key ?? "");



}

/*
https://shitab14.github.io/jsons/keys.json

{
"ap1_key0" : "67fa82e7140b456f8a17d09d56025686"
}
 */