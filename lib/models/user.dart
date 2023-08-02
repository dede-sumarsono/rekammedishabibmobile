
class User{
  int id;
  String email;
  String name;
  String username;
  String poli;
  int jabatan;

  String created_at;

  User ({required this.id,required this.email, required this.name, required this.username, required this.poli,  required this.jabatan, required this.created_at});

  User.fromJson(Map<String,dynamic> json)
  : id = json['id'],
    email = json['email'],
    name = json['name'],
    username = json['username'],
    jabatan = json['jabatan'],
    poli = json['poli'],
    created_at = json['created_at'];
}
