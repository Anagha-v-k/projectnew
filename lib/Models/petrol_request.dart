class PetrolRequest {
  PetrolRequest({
    required this.customer,
    required this.Petrolpump,
    required this.product,
    required this.amount,
    required this.location,
    required this.date,
    required this.time,
    required this.status,
    required this.phoneNumber,
  });
  late final int customer;
  late final int Petrolpump;
  late final String product;
  late final String amount;
  late final String location;
  late final String date;
  late final String time;
  late final String status;
  late final String phoneNumber;

  PetrolRequest.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    Petrolpump = json['Petrolpump'];
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
    _data['customer'] = customer;
    _data['Petrolpump'] = Petrolpump;
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
