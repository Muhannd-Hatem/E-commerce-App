enum ProductSize { S, M, L, XL }

class ProductItemModel {
  final String id;
  final String imgUrl;
  final String name;
  final int price;
  final String category;
  final bool isFavorite;
  final String description;
  final double avarageRate;
  final int quantity;
  final ProductSize? size;

  ProductItemModel({
    required this.id,
    required this.imgUrl,
    required this.name,
    required this.price,
    required this.category,
    this.isFavorite = false,
    this.description =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
        "when an unknown printer took a galley of type and scrambled it to make a type "
        "specimen book. It has survived not only five centuries, but also the leap into "
        "electronic typesetting, remaining essentially unchanged. It was popularised in "
        "the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, "
        "and more recently with desktop publishing software like Aldus PageMaker "
        "including versions of Lorem Ipsum.",
    this.avarageRate = 4.5,
    this.quantity = 1,
    this.size,
  });

  ProductItemModel copyWith({
    String? id,
    String? imgUrl,
    String? name,
    int? price,
    String? category,
    bool? isFavorite,
    String? description,
    double? avarageRate,
    int? quantity,
  }) {
    return ProductItemModel(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      description: description ?? this.description,
      avarageRate: avarageRate ?? this.avarageRate,
      quantity: quantity ?? this.quantity,
    );
  }
}

List<ProductItemModel> products = [
  ProductItemModel(
    id: '1',
    imgUrl:
        "https://images.pexels.com/photos/22432991/pexels-photo-22432991.jpeg",
    name: "Luxury Leather Bags",
    price: 25000,
    category: "Women's Fashion",
    isFavorite: false,
    description:
        "True luxury isn't just seen—it is felt. Our leather bags are designed for the discerning individual who appreciates understated sophistication. Every edge is hand-finished, every seam intentionally placed, creating a silhouette that balances modern aesthetic with heritage artistry",
  ),

  ProductItemModel(
    id: '2',
    imgUrl:
        "https://images.pexels.com/photos/22434769/pexels-photo-22434769.jpeg",
    name: "Leather Bags",
    price: 30000,
    category: "Women's Fashion",
    isFavorite: true,
    description:
        "True luxury isn't just seen—it is felt. Our leather bags are designed for the discerning individual who appreciates understated sophistication. Every edge is hand-finished, every seam intentionally placed, creating a silhouette that balances modern aesthetic with heritage artistry.",
  ),

  ProductItemModel(
    id: '3',
    imgUrl:
        "https://images.pexels.com/photos/27835292/pexels-photo-27835292.jpeg",
    name: "Luxury Handbags",
    price: 45000,
    category: "Women's Fashion",
    isFavorite: false,
    description:
        "True luxury isn't just seen—it is felt. Our leather bags are designed for the discerning individual who appreciates understated sophistication. Every edge is hand-finished, every seam intentionally placed, creating a silhouette that balances modern aesthetic with heritage artistry.",
  ),

  ProductItemModel(
    id: '4',
    imgUrl:
        "https://images.pexels.com/photos/22434759/pexels-photo-22434759.jpeg",
    name: "Elegant Handbags",
    price: 50000,
    category: "Women's Fashion",
    isFavorite: false,
    description:
        "True luxury isn't just seen—it is felt. Our leather bags are designed for the discerning individual who appreciates understated sophistication. Every edge is hand-finished, every seam intentionally placed, creating a silhouette that balances modern aesthetic with heritage artistry.",
  ),

  ProductItemModel(
    id: '5',
    imgUrl:
        "https://images.pexels.com/photos/15432831/pexels-photo-15432831.jpeg",
    name: "Stylish Handbag",
    price: 65000,
    category: "Women's Fashion",
    isFavorite: false,
    description:
        "True luxury isn't just seen—it is felt. Our leather bags are designed for the discerning individual who appreciates understated sophistication. Every edge is hand-finished, every seam intentionally placed, creating a silhouette that balances modern aesthetic with heritage artistry.",
  ),

  ProductItemModel(
    id: '6',
    imgUrl:
        "https://images.pexels.com/photos/27835299/pexels-photo-27835299.jpeg",
    name: "Stylish Leather",
    price: 70000,
    category: "Women's Fashion",
    isFavorite: false,
    description:
        "True luxury isn't just seen—it is felt. Our leather bags are designed for the discerning individual who appreciates understated sophistication. Every edge is hand-finished, every seam intentionally placed, creating a silhouette that balances modern aesthetic with heritage artistry.",
  ),
];
