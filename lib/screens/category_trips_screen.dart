import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../widgets/trip_item.dart';

class CategoryTripsScreen extends StatefulWidget {
  static const screenroute = '/category-trips';

  final List<Trip> availabeTrips;
  CategoryTripsScreen(this.availabeTrips);

  @override
  State<CategoryTripsScreen> createState() => _CategoryTripsScreenState();
}

class _CategoryTripsScreenState extends State<CategoryTripsScreen> {
  late String? categoryTitle;
  late List<Trip> displayTrips;

  @override
  void initState() {
    //....
    super.initState();
  }

  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      final routeArgument =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryId = routeArgument['id'];
      categoryTitle = routeArgument['title'];
      displayTrips = widget.availabeTrips.where((trip) {
        return trip.categories.contains(categoryId);
      }).toList();
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  void _removeTrip(String tripId) {
    setState(() {
      displayTrips.removeWhere((trip) => trip.id == tripId);
    });
  }

//final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle!,
          style: const TextStyle(color: Colors.white, fontFamily: 'ElMessiri'),
        ),
        backgroundColor: const Color.fromARGB(255, 104, 72, 233),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return TripItem(
            id: displayTrips[index].id,
            title: displayTrips[index].title,
            imageUrl: displayTrips[index].imageUrl,
            duration: displayTrips[index].duration,
            tripType: displayTrips[index].tripType,
            season: displayTrips[index].season,
            // removeItem: _removeTrip,
          );
        },
        // itemCount: displayTrips.length,
      ),
    );
  }
}
