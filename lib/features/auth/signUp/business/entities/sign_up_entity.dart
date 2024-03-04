class SignUpEntity {
  final String email;
  final String idToken;
  final String localId;

  SignUpEntity(
      {required this.email, required this.idToken, required this.localId});

  SignUpEntity.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        localId = json['localId'],
        idToken = json["idToken"];
}
