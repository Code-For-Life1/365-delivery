class DriverOrderDetailsModel {
  int id;
  final String city;
  final String street;
  final String building;
  final String floor;
  final String receiverFullName;
  final String receiverPhoneNumber;

  DriverOrderDetailsModel(this.id, this.city, this.street, this.building, this.floor,
      this.receiverFullName, this.receiverPhoneNumber);
}
