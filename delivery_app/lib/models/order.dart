class Order {
  final String receiver_name;
  final String receiver_phone_number;
  final String street;
  final String building;
  final String city;
  final String floor;
  final String driver_id;
  final String merchant_id;
  Order({this.receiver_name, this.receiver_phone_number, this.street, this.building, this.city, this.floor, this.driver_id, this.merchant_id});
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      receiver_name: json['receiver_full_name'],
      receiver_phone_number: json['receiver_phone_number'],
      street: json['street'],
      building: json['building'],
      city: json['city'],
      floor: json['floor'],
      driver_id: json['driver'],
      merchant_id: json['merchant']
    );
  }
}
