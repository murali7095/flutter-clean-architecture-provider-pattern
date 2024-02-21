class SignUpEntity {
  final String email;
  final String idToken;

  SignUpEntity({required this.email, required this.idToken});

  SignUpEntity.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        idToken = json["idToken"];
}
