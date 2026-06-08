class Room {
  final String id;
  final String name;
  final String image;
  final String location;
  final String roomNo;
  final double price;
  final double rating;
  final List<String> features;

  Room({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.roomNo,
    required this.price,
    required this.rating,
    required this.features,
  });
}