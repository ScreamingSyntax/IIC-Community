class Student {
  int? id;
  String? name;
  String? email;
  String? password;
  String? image;

  Student(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.image});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
  }
  factory Student.fromMap(Map<dynamic, dynamic> map) {
    return Student(
        id: map["id"],
        name: map["name"],
        email: map["email"],
        password: map["password"],
        image: map["image"]);
  }
}
