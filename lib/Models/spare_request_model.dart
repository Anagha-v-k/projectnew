class SpareRequest {
  SpareRequest({
    required this.product,
    required this.customer,
    required this.address,
    required this.pincode,
    required this.product1,
    required this.customerName,
    required this.status,
  });
  late final int product;
  late final int customer;
  late final String address;
  late final String pincode;
  late final String product1;
  late final String customerName;
  late final String status;

  SpareRequest.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    customer = json['customer'];
    address = json['address'];
    pincode = json['pincode'];
    product1 = json['product1'];
    customerName = json['customer_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product;
    _data['customer'] = customer;
    _data['address'] = address;
    _data['pincode'] = pincode;
    _data['product1'] = product1;
    _data['customer_name'] = customerName;
    _data['status'] = status;
    return _data;
  }
}
