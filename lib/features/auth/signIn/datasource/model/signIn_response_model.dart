class SignInResponseModel {
  String? idToken;
  String? email;

  SignInResponseModel({this.email, this.idToken});

  SignInResponseModel.fromJson(Map<String, dynamic> json)
      : idToken = json['idToken'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'isToken': idToken,
      };
}
