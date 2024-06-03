// To parse this JSON data, do
//
//     final categoryModal = categoryModalFromJson(jsonString);

import 'dart:convert';

CategoryModal categoryModalFromJson(String str) =>
    CategoryModal.fromJson(json.decode(str));

String categoryModalToJson(CategoryModal data) => json.encode(data.toJson());

class CategoryModal {
  final String? slug;
  final String? name;
  final String? url;

  CategoryModal({
    this.slug,
    this.name,
    this.url,
  });

  factory CategoryModal.fromJson(Map<String, dynamic> json) => CategoryModal(
        slug: json["slug"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "url": url,
      };

  static List<CategoryModal>? fromJsonList(List? list) {
    if (list == null) return null;
    return list.map((item) => CategoryModal.fromJson(item)).toList();
  }
}
