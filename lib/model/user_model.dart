class User {
  final String userId;
  final String fullName;
  final String email;
  final String phoneNumber;
  String? profileImg;

  User({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.profileImg
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profileImg: json['profileImg'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImg': profileImg
    };
  }

  @override
  String toString() {
    return 'User(userId: $userId, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, profileImg: $profileImg)';
  }
}