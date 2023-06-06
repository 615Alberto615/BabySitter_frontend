class User {
  final String name;
  final String lastname;
  final String email;
  final String password;
  final String phone;
  final String address;

  User({
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastname': lastname,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
    };
  }
}
