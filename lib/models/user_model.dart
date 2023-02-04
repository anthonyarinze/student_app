class UserData {
  String? firstName;
  String? lastName;
  String? profilePicture;

  UserData(this.firstName, this.lastName, this.profilePicture);

  UserData.fromJSON(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profilePicture'] = profilePicture;

    return data;
  }
}
