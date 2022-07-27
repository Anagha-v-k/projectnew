class WorkshopRequest {
  WorkshopRequest({
    required this.id,
    required this.customer,
    required this.workshop1,
    required this.workshop,
    required this.name,
    required this.location,
    required this.date,
    required this.time,
    required this.status,
    required this.phoneNumber,
    required this.problem,
    required this.vehicleModel,
  });
  late final int id;
  late final int customer;
  late final String workshop1;
  late final int workshop;
  late final String name;
  late final String location;
  late final String date;
  late final String time;
  late final String status;
  late final String phoneNumber;
  late final String problem;
  late final String vehicleModel;

  WorkshopRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'];
    workshop1 = json['workshop1'];
    workshop = json['workshop'];
    name = json['name'];
    location = json['location'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    phoneNumber = json['phone_number'];
    problem = json['problem'];
    vehicleModel = json['vehicle_model'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['customer'] = customer;
    _data['workshop1'] = workshop1;
    _data['workshop'] = workshop;
    _data['name'] = name;
    _data['location'] = location;
    _data['date'] = date;
    _data['time'] = time;
    _data['status'] = status;
    _data['phone_number'] = phoneNumber;
    _data['problem'] = problem;
    _data['vehicle_model'] = vehicleModel;
    return _data;
  }
}
