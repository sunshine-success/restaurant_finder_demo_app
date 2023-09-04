class RestaurantModel {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final String location;
  final String city;
  final int averageCostForTwo;
  final int totalRatings;
  final int offerPercentage;
  final bool freeDelivery;
  final List<String> menuList;
  final String menuDescription;
  final String hours;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.location,
    required this.city,
    required this.averageCostForTwo,
    required this.totalRatings,
    required this.offerPercentage,
    required this.freeDelivery,
    required this.menuList,
    required this.menuDescription,
    required this.hours,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      rating: json['rating'],
      location: json['location'],
      city: json['city'],
      averageCostForTwo: json['averageCostForTwo'],
      totalRatings: json['totalRatings'],
      offerPercentage: json['offerPercentage'],
      freeDelivery: json['freeDelivery'],
      menuList: List<String>.from(json['menuList']),
      menuDescription: json['menuDescription'],
      hours: json['hours'],
    );
  }
}
