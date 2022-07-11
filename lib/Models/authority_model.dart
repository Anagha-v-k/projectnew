class Authority {
  Authority({
    required this.AuthorityType,
    required this.name,
    required this.district,
    required this.state,
    required this.numberOfWards,
    required this.phoneNumber,
  });
  late final String AuthorityType;
  late final String name;
  late final String district;
  late final String state;
  late final int numberOfWards;
  late final String phoneNumber;

  Authority.fromJson(Map<String, dynamic> json) {
    AuthorityType = json['Authority_type'];
    name = json['name'];
    district = json['district'];
    state = json['state'];
    numberOfWards = json['number_of_wards'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Authority_type'] = AuthorityType;
    _data['name'] = name;
    _data['district'] = district;
    _data['state'] = state;
    _data['number_of_wards'] = numberOfWards;
    _data['phone_number'] = phoneNumber;
    return _data;
  }
}
