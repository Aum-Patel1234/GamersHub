part of '../home_section_collection.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        }
        if (state.genres.isEmpty) {
          return const Center(
            child: Text('Failed to Load Categories....'),
          );
        }
        return ListView(
          children: state.genres.map((genre) {
            String capitalizedGenreSlug = '${genre.slug[0].toUpperCase()}${genre.slug.substring(1)}';
            return ListTile(
              title: Text(capitalizedGenreSlug),
              leading: Icon(getIconForGenre(genre.slug)),
              onTap: () async {
                final Uri uri = Uri.parse('https://www.igdb.com/genres/${genre.slug}');
                try {
                  if (!await launchUrl(uri)) {
                    throw Exception('Could not launch ${genre.slug}');
                  }
                } catch (e) {
                  log(e.toString());
                }
              },
            );
          }).toList(),
        );
      },
    );
  }

  IconData getIconForGenre(String genreSlug) {
    switch (genreSlug) {
      case 'point-and-click':
        return Icons.mouse;
      case 'fighting':
        return Icons.sports_kabaddi;
      case 'shooter':
        return Icons.sports_esports;
      case 'music':
        return Icons.music_note;
      case 'platform':
        return Icons.adb;
      case 'puzzle':
        return Icons.extension;
      case 'racing':
        return Icons.directions_car;
      case 'real-time-strategy-rts':
        return Icons.access_time;
      case 'role-playing-rpg':
        return Icons.person_outline;
      case 'simulator':
        return Icons.computer;
      case 'sport':
        return Icons.sports_baseball;
      case 'strategy':
        return Icons.leaderboard;
      case 'turn-based-strategy-tbs':
        return Icons.speaker_notes;
      case 'tactical':
        return Icons.grid_on;
      case 'hack-and-slash-beat-em-up':
        return Icons.punch_clock;
      case 'quiz-trivia':
        return Icons.help;
      case 'pinball':
        return Icons.games;
      case 'adventure':
        return Icons.explore;
      case 'indie':
        return Icons.create;
      case 'arcade':
        return Icons.videogame_asset;
      case 'visual-novel':
        return Icons.book;
      case 'card-and-board-game':
        return Icons.gamepad;
      case 'moba':
        return Icons.sports_esports;
      default:
        return Icons.help_outline;
    }
  }
}
