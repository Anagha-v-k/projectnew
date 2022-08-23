class SpareViewModel {
  SpareViewModel({
    required this.id,
    required this.workshop,
    required this.workshop1,
    required this.name,
    required this.vehicleModel,
    required this.price,
    required this.image,
  });
  late final int id;
  late final int workshop;
  late final String workshop1;
  late final String name;
  late final String vehicleModel;
  late final String price;
  late final String image;

  SpareViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workshop = json['workshop'];
    workshop1 = json['workshop1'];
    name = json['name'];
    vehicleModel = json['vehicle_model'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['workshop'] = workshop;
    _data['workshop1'] = workshop1;
    _data['name'] = name;
    _data['vehicle_model'] = vehicleModel;
    _data['price'] = price;
    _data['image'] = image;
    return _data;
  }
}
