class UserLogin{
  String? _username;
  String? _password;

  String? get username => _username;
  String? get password => _password;

  UserLogin({
    String? username,
    String? password
  }){
    _username = username;
    _password = password;
  }

}