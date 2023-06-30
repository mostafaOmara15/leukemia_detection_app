class UserModel {
  String? name;
  String? email;
  String? uId;
  String? nationalId;
  String? role;

  UserModel({
    required this.name,
    required this.email,
    required this.uId,
    required this.nationalId,
    required this.role,
  });

  UserModel.fromJson(Map<String, dynamic>? json){
    email = json!['email'];
    name = json!['name'];
    uId = json!['uId'];
    nationalId = json!['nationalId'];
    role = json!['role'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'email' : email,
      'uId' : uId,
      'nationalId' : nationalId,
      'role' : role,
    };
  }
}