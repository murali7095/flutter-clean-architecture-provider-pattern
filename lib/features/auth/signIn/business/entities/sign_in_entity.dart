class SignInEntity {
  final String email;
  final String idToken;

  SignInEntity({required this.email, required this.idToken});

  SignInEntity.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        idToken = json["idToken"];
}
