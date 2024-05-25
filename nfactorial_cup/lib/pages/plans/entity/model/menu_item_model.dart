class MenuItemModel {
  final String id;
  final String title;
  final String description;
  final String price;
  final String volume;
  final String? explanation;
  MenuItemModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.volume,
      this.explanation});

  MenuItemModel copyWith(
      {String? id,
      String? title,
      String? description,
      String? price,
      String? volume,
      String? explanation}) {
    return MenuItemModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        volume: volume ?? this.volume,
        explanation: explanation ?? this.explanation);
  }

  static MenuItemModel fromJson(Map<String, dynamic> data) {
    return MenuItemModel(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        price: data['price'] ?? '',
        volume: data['volume'] ?? '');
  }
}

class GetMenuContext {
  final List<MenuItemModel> context;

  GetMenuContext({required this.context});
  static GetMenuContext fromJson(Map<String, dynamic> data) {
    return GetMenuContext(
        context: (data['context'] as List)
            .map((e) => MenuItemModel.fromJson(e))
            .toList());
  }
}
