class SignUpModel {
  String? email;
  String? password;
  bool? returnSecureToken;

  SignUpModel({this.email, this.password, this.returnSecureToken});

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "returnSecureToken": returnSecureToken
      };
}
