class SpareViewModel {
  int? workshop;
  String? workshopname;
  String? name;
  String? vehicleModel;
  String? price;
  String? image;

  SpareViewModel(
      {this.workshop,
      this.workshopname,
      this.name,
      this.vehicleModel,
      this.price,
      this.image});

  SpareViewModel.fromJson(Map<String, dynamic> json) {
    workshop = json['workshop'];
    workshopname = json['workshopname'];
    name = json['name'];
    vehicleModel = json['vehicle_model'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['workshop'] = this.workshop;
    data['workshopname'] = this.workshopname;
    data['name'] = this.name;
    data['vehicle_model'] = this.vehicleModel;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
