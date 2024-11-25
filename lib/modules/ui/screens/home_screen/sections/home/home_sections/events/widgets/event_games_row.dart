part of 'show_event_details_bottomsheet.dart';

class EventGamesRow extends StatelessWidget {
  EventGamesRow({super.key, required this.gamesId});

  final List<int> gamesId;
  final CommonService _service = CommonService();

  @override
  Widget build(BuildContext context) {
    // Take only the first 5 game IDs
    final limitedGames = gamesId.take(5).toList();

    return FutureBuilder<List<Cover>>(
      future: _service.getCovers(coverIds: limitedGames,parameter: "game").then((covers) => covers ?? []),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Failed to load game images'),
          );
        } else if (snapshot.hasData) {
          final List<Cover> covers = snapshot.data!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...covers.map((cover) {
                // log(cover.url);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0), 
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('https://images.igdb.com/igdb/image/upload/t_1080p/${cover.imageId}.jpg'),
                  ),
                );
              }),

               if (gamesId.length > 5) 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,  // Background color for the avatar
                    child: Text(
                      '+${gamesId.length - 5}',  // Show the number of additional covers
                    ),
                  ),
                ),
            ]
          );
        } else {
          return const Center(
            child: Text('No data available'),
          );
        }
      },
    );
  }
}