class LocationModel {
  final String id;
  final String city;
  final String country;
  final String imageUrl;
  final bool isChosen;

  LocationModel({
    required this.id,
    required this.city,
    required this.country,
    this.isChosen = false,
    this.imageUrl = 'https://www.nissui.co.jp/corporate/img/img01_01.jpg',
  });

  LocationModel copyWith({
    String? id,
    String? city,
    String? country,
    String? imageUrl,
    bool? isChosen,
  }) {
    return LocationModel(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      imageUrl: imageUrl ?? this.imageUrl,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<LocationModel> locations = [
  LocationModel(id: '1', city: 'Cairo', country: 'Cairo, Egypt'),
  LocationModel(id: '2', city: 'Giza', country: 'Giza, Egypt'),
  LocationModel(id: '3', city: 'Alexandria', country: 'Alexandria, Egypt'),
];
