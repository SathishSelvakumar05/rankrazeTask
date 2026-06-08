import 'package:flutter/material.dart';
import '../model/room_model.dart';

class RoomDetailsScreen extends StatefulWidget {
  final Room room;

  const RoomDetailsScreen({
    super.key,
    required this.room,
  });

  @override
  State<RoomDetailsScreen> createState() =>
      _RoomDetailsScreenState();
}

class _RoomDetailsScreenState
    extends State<RoomDetailsScreen> {
  final List<String> times = [
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
    "06:00 PM",
    "07:00 PM",
    "08:00 PM",
    "09:00 PM",
  ];

  String? fromTime;
  String? toTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xffF5F7FB),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor:
            Colors.indigo,
            flexibleSpace:
            FlexibleSpaceBar(
              background: Hero(
                tag: widget.room.id,
                child: Image.network(
                  widget.room.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding:
              const EdgeInsets.all(
                20,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [
                  Text(
                    widget.room.name,
                    style:
                    const TextStyle(
                      fontSize: 28,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.room.location,
                      ),
                      const Spacer(),
                      Text(
                        "Room ${widget.room.roomNo}",
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  const Text(
                    "Facilities",
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Wrap(
                    spacing: 10,
                    children: widget
                        .room.features
                        .map(
                          (e) => Chip(
                        label:
                        Text(e),
                      ),
                    )
                        .toList(),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Container(
                    padding:
                    const EdgeInsets
                        .all(20),
                    decoration:
                    BoxDecoration(
                      color:
                      Colors.white,
                      borderRadius:
                      BorderRadius
                          .circular(
                        24,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        const Text(
                          "Select Time",
                          style:
                          TextStyle(
                            fontSize:
                            18,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        DropdownButtonFormField<
                            String>(
                          value:
                          fromTime,
                          decoration:
                          InputDecoration(
                            labelText:
                            "From Time",
                            border:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(
                                16,
                              ),
                            ),
                          ),
                          items: times
                              .map(
                                (e) =>
                                DropdownMenuItem(
                                  value:
                                  e,
                                  child:
                                  Text(
                                    e,
                                  ),
                                ),
                          )
                              .toList(),
                          onChanged:
                              (value) {
                            setState(
                                  () {
                                fromTime =
                                    value;
                              },
                            );
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        DropdownButtonFormField<
                            String>(
                          value:
                          toTime,
                          decoration:
                          InputDecoration(
                            labelText:
                            "To Time",
                            border:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(
                                16,
                              ),
                            ),
                          ),
                          items: times
                              .map(
                                (e) =>
                                DropdownMenuItem(
                                  value:
                                  e,
                                  child:
                                  Text(
                                    e,
                                  ),
                                ),
                          )
                              .toList(),
                          onChanged:
                              (value) {
                            setState(
                                  () {
                                toTime =
                                    value;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),


                  const SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    width:
                    double.infinity,
                    height: 55,
                    child:
                    ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors
                            .indigo,
                      ),
                      onPressed:
                      fromTime !=
                          null &&
                          toTime !=
                              null
                          ? () {
                        showDialog(
                          context:
                          context,
                          builder:
                              (_) =>
                              AlertDialog(
                                title:
                                const Text(
                                  "Booking Confirmed 🎉",
                                ),
                                content:
                                Text(
                                  "Room booked from\n\n$fromTime\n\nto\n\n$toTime",
                                ),
                              ),
                        );
                      }
                          : null,
                      child:
                      const Text(
                        "Book Room",
                        style:
                        TextStyle(
                          color: Colors
                              .white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}