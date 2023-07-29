class ProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int priceHighToLow = 2;
  static const int priceLowToHigh = 3;

  static const List<String> sortNames = [
    'آخرین محصولات',
    'مشهورترین محصولات',
    'بر اساس قیمت کم به زیاد',
    'بر اساس قیمت زیاد به کم',
  ];
}

class ProductEntity {
  final int id;
  final String title;
  final String imageUrl;
  final int price;
  final int discount;
  final int previousPrice;

  ProductEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['image'],
        price = json['price'],
        discount = json['discount'],
        previousPrice = json['previous_price'] ??
            json['price'] + json['discount'] ??
            json['price'];
}
