import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HeroCover extends StatelessWidget {
  const HeroCover({
    super.key,
    required this.heroTag,
    required this.coverUrl,
  });

  final String heroTag;
  final String coverUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              alignment: Alignment.center,
              type: PageTransitionType.fade,      // Transition Type
              child: Scaffold(
                appBar: AppBar(),
                body: Hero(
                  tag: heroTag,
                  child: Center(
                    child: Image.network(
                      coverUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                floatingActionButton:
                  heroTag != "profileImg"
                    ? null
                    : IconButton.filled(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                ),
              ),
            ),
          );
        },
        child: Hero(
          tag: heroTag,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              coverUrl,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
