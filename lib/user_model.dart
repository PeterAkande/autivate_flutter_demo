class User {
  final String emailAddress;
  final bool isVerified;
  final DateTime dateCreated;
  final String firstName;
  final String lastName;
  final String userUniqueId;

  User({
    required this.emailAddress,
    required this.isVerified,
    required this.dateCreated,
    required this.firstName,
    required this.lastName,
    required this.userUniqueId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      emailAddress: json['user_record']['email_address'],
      isVerified: json['user_record']['is_verified'],
      dateCreated: DateTime.parse(json['user_record']['date_created']),
      firstName: json['user_record']['first_name'],
      lastName: json['user_record']['last_name'],
      userUniqueId: json['user_record']['user_unique_id'],
    );
  }
}
