class AdminModel {
  String name;
  String email;
  String birthday;
  String address;
  String contact;
  String userType;

  AdminModel({
    required this.name,
    required this.email,
    required this.birthday,
    required this.address,
    required this.contact,
    required this.userType,
  });

  AdminModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name'] as String,
          email: json['email'] as String,
          birthday: json['birthday'] as String,
          address: json['address'] as String,
          contact: json['contact'] as String,
          userType: json['userType'] as String,
        );

  AdminModel copyWith({
    String? name,
    String? email,
    String? birthday,
    String? address,
    String? contact,
    String? userType,
  }) {
    return AdminModel(
      name: name ?? this.name,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      userType: userType ?? this.userType,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'birthday': birthday,
      'address': address,
      'contact': contact,
      'userType': userType,
    };
  }
}
