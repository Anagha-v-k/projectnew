class Workshop {
  Workshop({
    required this.id,
    required this.workshopName,
    required this.ownerName,
    required this.address,
    required this.type,
    required this.district,
    required this.location,
    required this.phoneNumber,
    required this.licenceNumber,
    required this.status,
  });
  late final int id;
  late final String workshopName;
  late final String ownerName;
  late final String address;
  late final String type;
  late final String district;
  late final String location;
  late final String phoneNumber;
  late final String licenceNumber;
  late final String status;

  Workshop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workshopName = json['workshop_name'];
    ownerName = json['owner_name'];
    address = json['address'];
    type = json['type'];
    district = json['district'];
    location = json['location'];
    phoneNumber = json['phone_number'];
    licenceNumber = json['licence_number'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['workshop_name'] = workshopName;
    _data['owner_name'] = ownerName;
    _data['address'] = address;
    _data['type'] = type;
    _data['district'] = district;
    _data['location'] = location;
    _data['phone_number'] = phoneNumber;
    _data['licence_number'] = licenceNumber;
    _data['status'] = status;
    return _data;
  }
}
