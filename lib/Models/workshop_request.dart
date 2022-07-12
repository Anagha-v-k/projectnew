class WorkshopRequest {
  WorkshopRequest({
    required this.customer,
    required this.workshop,
    required this.location,
    required this.date,
    required this.time,
    required this.status,
    required this.phoneNumber,
    required this.problem,
    required this.vehicleModel,
  });
  late final int customer;
  late final int workshop;
  late final String location;
  late final String date;
  late final String time;
  late final String status;
  late final String phoneNumber;
  late final String problem;
  late final String vehicleModel;

  WorkshopRequest.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    workshop = json['workshop'];
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
    _data['customer'] = customer;
    _data['workshop'] = workshop;
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
