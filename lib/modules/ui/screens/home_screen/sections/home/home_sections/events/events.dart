part of '../home_section_collection.dart';

class Events extends StatelessWidget {
  Events({super.key});

  final HomePageApiService _apiService = HomePageApiService();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: state.events.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Tile click functionality (currently none)
              },
              child: Container(
                padding: const EdgeInsets.all(Config.paddingSixteen),
                margin: const EdgeInsets.all(Config.paddingEight),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // shadow direction
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Section: Name and Description
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.events[index].name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                state.events[index].description.isNotEmpty
                                    ? state.events[index].description
                                    : '${state.events[index].name} is an exciting event. Stay tuned for more details!',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white38,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // Right Section: Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: FutureBuilder<ImageProvider>(
                            future: state.eventLogos[index] == null ? null : Future.value(NetworkImage('https:${state.eventLogos[index]!.url}')), 
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError || !snapshot.hasData) {
                                return const Icon(Icons.error_outline);
                              } else {
                                return Image(
                                  width: 80,
                                  height: 80,
                                  image: snapshot.data!,
                                  fit: BoxFit.cover,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left Section: Start and End Times
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              const Icon(Icons.schedule,size: 16, color: Colors.grey),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: Text(
                                  'Start: ${DateFormat('EEE, MMM d, yyyy • h:mm a').format(DateTime.fromMillisecondsSinceEpoch(state.events[index].startTime * 1000))}\n'
                                  'End  : ${DateFormat('EEE, MMM d, yyyy • h:mm a').format(DateTime.fromMillisecondsSinceEpoch(state.events[index].endTime * 1000))}',
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Right Section: Live Stream Link
                        if (state.events[index].liveStreamUrl.isNotEmpty)
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              onPressed: () async {
                                final Uri uri = Uri.parse(state.events[index].liveStreamUrl);
                                try {
                                  if (!await launchUrl(uri)) {
                                    throw Exception('Could not launch ${state.events[index].liveStreamUrl}');
                                  }
                                } catch (e) {
                                  log(e.toString());
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.video_camera_front,
                                      size: 16, color: Colors.blue),
                                  SizedBox(width: 4.0),
                                  Text(
                                    'Live Stream',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
