import 'package:flutter/material.dart';
import 'package:rankraze_task/view/room_detail_screen.dart';

import '../model/room_model.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  String selectedLocation = "All";
  String searchQuery = "";
  final TextEditingController searchController =
  TextEditingController();

  List<Room> get filteredRooms {
    return rooms.where((room) {
      final locationMatch =
          selectedLocation == "All" ||
              room.location == selectedLocation;

      final priceMatch =
          room.price <= selectedPrice;

      final searchMatch = room.name
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      return locationMatch &&
          priceMatch &&
          searchMatch;
    }).toList();
  }
  void showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setBottom) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Filter Rooms",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Location",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      value: selectedLocation,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "All",
                          child: Text("All Locations"),
                        ),
                        DropdownMenuItem(
                          value: "Chennai",
                          child: Text("Chennai"),
                        ),
                        DropdownMenuItem(
                          value: "Bangalore",
                          child: Text("Bangalore"),
                        ),
                        DropdownMenuItem(
                          value: "Hyderabad",
                          child: Text("Hyderabad"),
                        ),
                      ],
                      onChanged: (value) {
                        setBottom(() {
                          selectedLocation = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Maximum Price",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "₹${selectedPrice.toInt()}",
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Slider(
                      value: selectedPrice,
                      min: 500,
                      max: 10000,
                      divisions: 19,
                      activeColor: Colors.indigo,
                      label: selectedPrice.toInt().toString(),
                      onChanged: (value) {
                        setBottom(() {
                          selectedPrice = value;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Booking Date",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final date =
                              await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                                initialDate:
                                DateTime.now(),
                              );

                              if (date != null) {
                                setBottom(() {
                                  checkInDate = date;
                                });
                              }
                            },
                            child: Container(
                              padding:
                              const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:
                                Colors.grey.shade100,
                                borderRadius:
                                BorderRadius.circular(
                                    16),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      checkInDate == null
                                          ? "Check In"
                                          : "${checkInDate!.day}/${checkInDate!.month}/${checkInDate!.year}",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final date =
                              await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                                initialDate:
                                DateTime.now(),
                              );

                              if (date != null) {
                                setBottom(() {
                                  checkOutDate = date;
                                });
                              }
                            },
                            child: Container(
                              padding:
                              const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:
                                Colors.grey.shade100,
                                borderRadius:
                                BorderRadius.circular(
                                    16),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.event,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      checkOutDate == null
                                          ? "Check Out"
                                          : "${checkOutDate!.day}/${checkOutDate!.month}/${checkOutDate!.year}",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.indigo,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                18),
                          ),
                        ),
                        onPressed: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Apply Filters",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  double selectedPrice = 5000;

  DateTime? checkInDate;
  DateTime? checkOutDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showFilters,
        backgroundColor: Colors.indigo,
        icon: const Icon(Icons.tune,color: Colors.white,),
        label: const Text("Filters",style: TextStyle(color: Colors.white),),
      ),      appBar: AppBar(title: const Text("Available Rooms")),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff4F46E5), Color(0xff7C3AED)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(35),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Find Your Perfect Room",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "${filteredRooms.length} rooms available",
                    style: const TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 14),

                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search rooms...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchQuery = "";
                          });
                        },
                      )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Featured Rooms",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: rooms.length,
                      itemBuilder: (_, index) {
                        final room = rooms[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RoomDetailsScreen(room: room),
                              ),
                            );
                          },
                          child: Container(
                            width: 270,
                            margin: const EdgeInsets.only(right: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Stack(
                                children: [
                                  Image.network(
                                    room.image,
                                    width: 280,
                                    height: 220,
                                    fit: BoxFit.cover,
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(.8),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 15,
                                    right: 15,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            room.rating.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    left: 15,
                                    bottom: 15,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          room.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          room.location,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final room = filteredRooms[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RoomDetailsScreen(room: room),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Hero(
                              tag: room.id,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(28),
                                ),
                                child: Image.network(
                                  room.image,
                                  height: 220,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Positioned(
                              top: 15,
                              left: 15,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(room.rating.toString()),
                                  ],
                                ),
                              ),
                            ),

                            Positioned(
                              top: 15,
                              right: 15,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red.shade400,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                room.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  Text(room.location),
                                  const Spacer(),
                                  Text("Room ${room.roomNo}"),
                                ],
                              ),

                              const SizedBox(height: 15),

                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: room.features
                                    .map(
                                      (e) => Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.indigo.shade50,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                              ),

                              const SizedBox(height: 20),

                              Row(
                                children: [
                                  Text(
                                    "₹${room.price}",
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo,
                                    ),
                                  ),

                                  const Text(
                                    "/hour",
                                    style: TextStyle(color: Colors.grey),
                                  ),

                                  const Spacer(),

                                  ElevatedButton(
                                    onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => RoomDetailsScreen(room: room),
                                          ),
                                        );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: const Text("Book Now",style: TextStyle(color: Colors.white),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
                  childCount: filteredRooms.length),
            ),
          ),
        ],
      ),
    );
  }
}

final rooms = [
  Room(
    id: "1",
    name: "Ocean Luxury Suite",
    image: "https://images.unsplash.com/photo-1566665797739-1674de7a421a",
    location: "Chennai",
    roomNo: "201",
    price: 1200,
    rating: 4.8,
    features: ["WiFi", "AC", "Breakfast"],
  ),
  Room(
    id: "2",
    name: "Royal Executive",
    image: "https://images.unsplash.com/photo-1582719508461-905c673771fd",
    location: "Chennai",
    roomNo: "203",
    price: 5000,
    rating: 4.9,
    features: ["Pool", "WiFi", "AC"],
  ),
  Room(
    id: "3",
    name: "Skyline Premium",
    image: "https://images.unsplash.com/photo-1631049307264-da0ec9d70304",
    location: "Bangalore",
    roomNo: "305",
    price: 1800,
    rating: 4.6,
    features: ["Gym", "Breakfast"],
  ),
  Room(
    id: "4",
    name: "Elite Residency",
    image: "https://images.unsplash.com/photo-1578683010236-d716f9a3f461",
    location: "Hyderabad",
    roomNo: "401",
    price: 2200,
    rating: 4.7,
    features: ["Pool", "Spa", "WiFi"],
  ),
  Room(
    id: "5",
    name: "Business Lounge",
    image: "https://images.unsplash.com/photo-1590490360182-c33d57733427",
    location: "Bangalore",
    roomNo: "405",
    price: 2500,
    rating: 4.5,
    features: ["Meeting Hall", "WiFi"],
  ),
];
