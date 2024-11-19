part of 'show_event_details_bottomsheet.dart';

class EventGamesRow extends StatelessWidget {
  EventGamesRow({super.key, required this.gamesId});

  final List<int> gamesId;
  final Client _client = Client();

  // Fetch event logo details for a specific game ID
  // service for the event games
  Future<List<EventLogo>> fetchEventLogos(List<int> gameIds) async {
    final ApiClientIdBearerToken instance = await ApiClientIdBearerToken.getInstance();
    final List<EventLogo> logos = [];
    final Uri uri = Uri.parse('https://api.igdb.com/v4/event_logos');

    final String eventIDs = '(${gameIds.take(5).where((logo) => logo != 0).join(',')})';  

    final response = await _client.post(
      uri,
      headers: {
        'Client-ID': instance.clientId,
        'Authorization': 'Bearer ${instance.bearerToken}',
        'Content-Type': 'application/json',
      },
      body: 'fields event,url;  where id = $eventIDs;',
    );

    if (response.statusCode == 200) {

      final List<dynamic> data = json.decode(response.body);
      logos.addAll(data.map((event) => EventLogo.fromJson(event)).toList());

    } else {
      throw Exception('Failed to load event logo..');
    }
    return logos;
  }

  @override
  Widget build(BuildContext context) {
    // Take only the first 5 game IDs
    final limitedGames = gamesId.take(5).toList();

    return FutureBuilder<List<EventLogo>>(
      future: fetchEventLogos(limitedGames),
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
          final logos = snapshot.data!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: logos.map((logo) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(logo.url),
                ),
              );
            }).toList(),
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