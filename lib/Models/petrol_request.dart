class PetrolRequest {
  PetrolRequest({
    required this.id,
    required this.customer,
    required this.Petrolpumb,
    required this.Petrolpumb1,
    required this.name,
    required this.product,
    required this.amount,
    required this.location,
    required this.date,
    required this.time,
    required this.status,
    required this.phoneNumber,
  });
  late final int id;
  late final int customer;
  late final int Petrolpumb;
  late final String Petrolpumb1;
  late final String name;
  late final String product;
  late final String amount;
  late final String location;
  late final String date;
  late final String time;
  late final String status;
  late final String phoneNumber;

  PetrolRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'];
    Petrolpumb = json['Petrolpumb'];
    Petrolpumb1 = json['Petrolpumb1'];
    name = json['name'];
    product = json['product'];
    amount = json['amount'];
    location = json['location'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['customer'] = customer;
    _data['Petrolpumb'] = Petrolpumb;
    _data['Petrolpumb1'] = Petrolpumb1;
    _data['name'] = name;
    _data['product'] = product;
    _data['amount'] = amount;
    _data['location'] = location;
    _data['date'] = date;
    _data['time'] = time;
    _data['status'] = status;
    _data['phone_number'] = phoneNumber;
    return _data;
  }
}
