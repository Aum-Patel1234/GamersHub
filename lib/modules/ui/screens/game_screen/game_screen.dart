import 'package:flutter/material.dart';
import 'package:gamers_hub/modules/models/games/games.dart';

class GameScreen extends StatelessWidget {
  final Games game;

  const GameScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name ?? "Game Details"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            if (game.cover != null)
              Hero(
                tag: "game_cover_${game.id}",
                child: Image.network(
                  "https://images.igdb.com/igdb/image/upload/t_cover_big/${game.cover}.jpg",
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating
                  Text(
                    game.name ?? "Unknown Game",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                  ),
                  if (game.rating != null)
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 5),
                        Text(
                          "${game.rating!.toStringAsFixed(1)} / 100",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),

                  // Storyline Section
                  if (game.storyline != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Storyline",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.deepPurple),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          game.storyline!,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),

                  // Summary Section
                  if (game.summary != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Summary",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.deepPurple),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          game.summary!,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),

                  // Additional Information
                  if (game.genres != null)
                    InfoTile(
                      title: "Genres",
                      content: game.genres?.join(", ") ?? "N/A",
                    ),
                  if (game.platforms != null)
                    InfoTile(
                      title: "Platforms",
                      content: game.platforms?.join(", ") ?? "N/A",
                    ),
                  if (game.firstReleaseDate != null)
                    InfoTile(
                      title: "First Release Date",
                      content: DateTime.fromMillisecondsSinceEpoch(
                              game.firstReleaseDate! * 1000)
                          .toLocal()
                          .toString()
                          .split(' ')[0],
                    ),
                  if (game.aggregatedRating != null)
                    InfoTile(
                      title: "Aggregated Rating",
                      content: "${game.aggregatedRating?.toStringAsFixed(1)}",
                    ),
                  if (game.totalRating != null)
                    InfoTile(
                      title: "Total Rating",
                      content: "${game.totalRating?.toStringAsFixed(1)}",
                    ),
                  const SizedBox(height: 16),

                  // Screenshots Section
                  if (game.screenshots != null && game.screenshots!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Screenshots",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.deepPurple),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: game.screenshots!.length,
                            itemBuilder: (context, index) {
                              final screenshot = game.screenshots![index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Image.network(
                                  "https://images.igdb.com/igdb/image/upload/t_screenshot_big/$screenshot.jpg",
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String content;

  const InfoTile({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
