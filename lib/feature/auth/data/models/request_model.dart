


class UserRequestModel {
  final String email;

  UserRequestModel({required this.email});
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  factory UserRequestModel.fromJson(Map<String, dynamic> json) {
    return UserRequestModel(
      email: json['email'],
    );
  }
}
