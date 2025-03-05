
class SignInBody{
  String username;
  String password;

  SignInBody({
    required this.username,
    required this.password
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["username"] = username;
    data["password"] = password;
    return data;
  }
}