class Akun {
  int? id;
  String? username;
  String? password;

  Akun(this.username, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['password'] = password;
    return map;
  }

  Akun.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    username = map['username'];
    password = map['password'];
  }
}
