import 'package:flutter/material.dart';

class AvatarView extends StatelessWidget {
  const AvatarView({
    Key? key,
    required this.url,
    this.size = 40.0,
  }) : super(key: key);

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.network(
        url,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const Center(child: CircularProgressIndicator());
        },
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
