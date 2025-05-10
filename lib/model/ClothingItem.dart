class ClothingItem {
  final String? id;
  final String name;
  final String color;
  final int category;
  final String imageUrl;
  final int material;
  final String? note;

  ClothingItem({
    this.id,
    required this.name,
    required this.color,
    required this.category,
    required this.imageUrl,
    required this.material,
    required this.note,
  });

  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    return ClothingItem(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      color: json['color'] ?? '',
      category: json['category']??'',
      imageUrl: json['imageUrl'] ?? '',
      material: json['material'] ?? '',
      note: json['note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color,
      'category': category,
      'imageUrl': imageUrl,
      'material': material,
      'note': note,
    };
  }
}
