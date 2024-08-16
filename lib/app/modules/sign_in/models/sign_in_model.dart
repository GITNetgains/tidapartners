class LoginResponseModel {
  String? token;
  String? userEmail;
  String? image;
  String? userDisplayName;
  int? id;
  String? phone_number;

  LoginResponseModel(
      {this.id,
      this.token,
      this.userEmail,
      this.image,
      this.userDisplayName,
      this.phone_number});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    phone_number = json["phone_number"];
    token = json['token'];
    userEmail = json['email'];
    image = json['image'];
    userDisplayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["ID"] = this.id;
    data['token'] = this.token;
    data['user_email'] = this.userEmail;
    data['image'] = this.image;
    data['display_name'] = this.userDisplayName;
    data["phone_number"] = this.phone_number;
    return data;
  }
}
