class WorkshopFeedback {
  WorkshopFeedback({
    required this.customer,
    required this.workshop,
    required this.comment,
    required this.rating,
    required this.date,
  });
  late final int customer;
  late final int workshop;
  late final String comment;
  late final String rating;
  late final String date;

  WorkshopFeedback.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    workshop = json['workshop'];
    comment = json['comment'];
    rating = json['rating'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customer'] = customer;
    _data['workshop'] = workshop;
    _data['comment'] = comment;
    _data['rating'] = rating;
    _data['date'] = date;
    return _data;
  }
}
