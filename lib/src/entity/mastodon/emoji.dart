class Emoji {
  final String shortcode;
  final String url;
  final bool visibleInPicker;

  Emoji({
    required this.shortcode,
    required this.url,
    required this.visibleInPicker,
  });

  factory Emoji.fromJson(Map<String, dynamic> json) {
    return Emoji(
      shortcode: json['shortcode'],
      url: json['url'],
      visibleInPicker: json['visible_in_picker'] ?? false,
    );
  }
}
