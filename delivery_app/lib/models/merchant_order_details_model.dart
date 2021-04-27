class MerchantOrderDetailsModel {
  int id;
  final String receiverFullName;
  final String receiverPhoneNumber;
  final String merchantPhoneNumber;
  final String driverPhoneNumber;
  final String driverName;
  final String status;
  final String city;
  final String street;
  final String building;
  final String floor;

  MerchantOrderDetailsModel(
      this.id,
      this.receiverFullName,
      this.receiverPhoneNumber,
      this.merchantPhoneNumber,
      this.driverPhoneNumber,
      this.driverName,
      this.status,
      this.city,
      this.street,
      this.building,
      this.floor);
}
