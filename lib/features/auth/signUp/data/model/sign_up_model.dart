class SignUpModel {
  String? email;
  String? password;
  String? username;
  String? phoneNumber;
  bool? returnSecureToken;

  SignUpModel(
      {this.email,
      this.password,
      this.returnSecureToken,
      this.phoneNumber,
      this.username});

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "returnSecureToken": returnSecureToken
      };
}
