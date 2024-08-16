class DetailsModel {
  final String imagePath;
  final String name;
  final String location;
  final int noOfBookings;
  final String customerName;

  DetailsModel(
      {required this.imagePath,
      required this.name,
      required this.location,
      required this.noOfBookings, required this.customerName});
}
