
class SignUpBody{
  String email;
  String username;
  String password;

  SignUpBody({
   required this.email,
   required this.username,
   required this.password
});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["email"] = email;
    data["username"] = username;
    data["password"] = password;
    return data;
  }
}