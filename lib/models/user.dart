class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}