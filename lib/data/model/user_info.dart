class UserInfo {
  String name;
  String email;
  String role;

  UserInfo({
    required this.name,
    required this.email,
    required this.role,
    
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'role': role,
      
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      
    );
  }
}