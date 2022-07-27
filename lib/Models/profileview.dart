class ProfileView {
  ProfileView({
    required this.username,
    required this.address,
    required this.phoneNumber,
    required this.licenceNumber,
  });
  late final String username;
  late final String address;
  late final String phoneNumber;
  late final String licenceNumber;

  ProfileView.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    licenceNumber = json['licence_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['address'] = address;
    _data['phone_number'] = phoneNumber;
    _data['licence_number'] = licenceNumber;
    return _data;
  }
}
