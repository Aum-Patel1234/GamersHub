import 'package:flutter/material.dart';

class HeroCover extends StatelessWidget {
  const HeroCover(
      {super.key,
      required this.heroTag,
      required this.coverUrl,});

  final String heroTag;
  final String coverUrl;
  // final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(),
                body: Hero(
                  tag: heroTag,
                  child: Center(
                    child: Image.network(
                      coverUrl,
                      width: double.infinity, // Same width as the source image
                      // height: width, // Keeping height and width consistent
                      fit: BoxFit.cover, // Use BoxFit.cover for both screens
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: Hero(
          tag: heroTag,
          child: SizedBox(
            // width: width, // Fixed width to ensure consistent sizing
            // height: width, // Fixed height to match the aspect ratio
            child: Image.network(
              coverUrl,
              fit: BoxFit.cover, // Use BoxFit.cover for both screens
            ),
          ),
        ),
      ),
    );
  }
}
