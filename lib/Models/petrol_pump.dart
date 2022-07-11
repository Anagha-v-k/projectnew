class PetrolPump {
  PetrolPump({
    required this.id,
    required this.companyName,
    required this.address,
    required this.district,
    required this.type,
    required this.authorityType,
    required this.authorityName,
    required this.location,
    required this.phoneNumber,
    required this.ownerName,
    required this.licenceNumber,
  });
  late final int id;
  late final String companyName;
  late final String address;
  late final String district;
  late final String type;
  late final String authorityType;
  late final String authorityName;
  late final String location;
  late final String phoneNumber;
  late final String ownerName;
  late final String licenceNumber;

  PetrolPump.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    address = json['address'];
    district = json['district'];
    type = json['type'];
    authorityType = json['authority_type'];
    authorityName = json['authority_name'];
    location = json['location'];
    phoneNumber = json['phone_number'];
    ownerName = json['owner_name'];
    licenceNumber = json['licence_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['company_name'] = companyName;
    _data['address'] = address;
    _data['district'] = district;
    _data['type'] = type;
    _data['authority_type'] = authorityType;
    _data['authority_name'] = authorityName;
    _data['location'] = location;
    _data['phone_number'] = phoneNumber;
    _data['owner_name'] = ownerName;
    _data['licence_number'] = licenceNumber;
    return _data;
  }
}
