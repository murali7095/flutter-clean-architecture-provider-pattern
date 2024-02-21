class SignInRequestModel {
  String? idToken;
  String? email;
  String? password;

  SignInRequestModel({this.email, this.idToken, this.password});

  SignInRequestModel.fromJson(Map<String, dynamic> json)
      : idToken = json['idToken'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {'email': email, 'isToken': idToken, 'password': password};
}
