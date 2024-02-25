class SignInModel {
  String? returnSecureToken;
  String? email;
  String? password;

  SignInModel({this.email, this.returnSecureToken, this.password});

  SignInModel.fromJson(Map<String, dynamic> json)
      : returnSecureToken = json['returnSecureToken'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'returnSecureToken': returnSecureToken,
        'password': password
      };
}
