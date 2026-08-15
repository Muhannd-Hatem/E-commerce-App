class CategoryTabModel {
  final String title;
  final int count;
  final String imgUrl;

  CategoryTabModel({
    required this.title,
    required this.count,
    required this.imgUrl,
  });
}

List<CategoryTabModel> category = [
  CategoryTabModel(
    title: "New Arrivals",
    count: 208,
    imgUrl:
        "https://images.pexels.com/photos/9594952/pexels-photo-9594952.jpeg",
  ),
  CategoryTabModel(
    title: "Clothes",
    count: 358,
    imgUrl:
        "https://images.pexels.com/photos/9594682/pexels-photo-9594682.jpeg",
  ),
  CategoryTabModel(
    title: "Bags",
    count: 160,
    imgUrl:
        "https://images.pexels.com/photos/22434775/pexels-photo-22434775.jpeg",
  ),
  CategoryTabModel(
    title: "Shoes",
    count: 230,
    imgUrl:
        "https://images.pexels.com/photos/10954912/pexels-photo-10954912.jpeg",
  ),
  CategoryTabModel(
    title: "Electronics",
    count: 248,
    imgUrl:
        "https://images.pexels.com/photos/5479765/pexels-photo-5479765.jpeg",
  ),
  CategoryTabModel(
    title: "Kids",
    count: 189,
    imgUrl:
        "https://images.pexels.com/photos/8613183/pexels-photo-8613183.jpeg",
  ),
];
