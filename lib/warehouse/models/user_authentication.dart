class UserAuthentication{

  int? id;
  String? username;
  DateTime? valid;
  
  UserAuthentication({
    this.id,
    this.username,
    this.valid
  });

  factory UserAuthentication.fromJson(Map<String,dynamic> json) => UserAuthentication(
    id: json['id'],
    username: json['username'],
    valid: DateTime.tryParse(json['valid'])
  );

  Map<String,dynamic> toJson(){
    return {
      'id': id,
      'username':username,
      'valid':valid!.toIso8601String()
    };
  }
}