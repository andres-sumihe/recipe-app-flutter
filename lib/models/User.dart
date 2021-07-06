class User {
  int? userId;
  String email;
  // String? password;
  String username;
  String? phoneNumber;
  String? gender;
  String? pictureUrl;
  String? dateOfBirt;
  String? name;

// `user_id`, `username`, `password`, `email`, `phone_number`, `gender`, `picture_url`, `date_of_birth`, `name`
  User({
    this.userId,
    required this.email,
    // this.password,
    required this.username,
    this.phoneNumber,
    this.gender,
    this.pictureUrl,
    this.dateOfBirt,
    this.name,
  });

  User.fromMap(Map snapshot)
      : email = snapshot['recipe_name'],
        // password = snapshot['recipe_picture_url'],
        username = snapshot['username'],
        phoneNumber = snapshot['phone_number'],
        userId = snapshot['user_id'],
        gender = snapshot['gender'],
        pictureUrl = snapshot['picture_url'],
        dateOfBirt = snapshot['date_of_birt'],
        name = snapshot['name'];

  Map<String, dynamic> toJson() => {
        'recipe_name': email,
        // 'recipe_picture_url': password,
        'username': username,
        'phone_number': phoneNumber,
        'user_id': userId,
        'gender': gender,
        'picture_url' : pictureUrl,
        'date_of_birt' : dateOfBirt,
        'name' : name
      };
}
