import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../entity/mastodon/status.dart';

class StatusContentView extends StatelessWidget {
  const StatusContentView({super.key, required this.status});

  final Status status;

  @override
  Widget build(BuildContext context) {
    var content = status.content;
    for (final emoji in status.emojis) {
      final re = RegExp(r':' + emoji.shortcode + r':');
      content = content.replaceAll(
          re, '<img src="${emoji.url}" class="emoji"></img>');
    }
    return Html(
      data: content,
      style: {
        '.emoji': Style(
          height: Height(1, Unit.rem),
        ),
      },
    );
  }
}
