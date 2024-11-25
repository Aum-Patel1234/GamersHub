library show_event_details_bottomsheet.dart;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/models/covers/cover.dart';
import 'package:gamers_hub/modules/models/events/event.dart';
import 'package:gamers_hub/modules/service/common_service.dart';
import 'package:gamers_hub/modules/theme/bloc/theme_bloc.dart';
import 'package:gamers_hub/modules/ui/shared/hero_cover.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

part 'event_games_row.dart';

void showEventDetailsBottomSheet(BuildContext context, Event event, String? imageLink) {
  final Color color =  context.read<ThemeBloc>().state.themeData == ThemeData.dark() ? Colors.white54 : Colors.black54; 

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    // color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Row(
                children: [
                  ClipOval(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: (imageLink == null)
                          ? const AssetImage('assets/images/80x80_error.png')
                          : NetworkImage(imageLink), // Replace with your asset path
                      child: HeroCover(heroTag: 'event_${event.id}', coverUrl: imageLink!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      event.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                event.description == '' ? '${event.name} is coming up with an exiting event. Stay Tuned for more updates...' : event.description,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: color),
              ),
              const SizedBox(height: 16),

              _infoTile(context,
                  title: "Start Time",
                  value:'Start: ${DateFormat('EEE, MMM d, yyyy • h:mm a').format(DateTime.fromMillisecondsSinceEpoch(event.startTime * 1000))}\n',
                  color: color),
              _infoTile(
                context,
                title: "End Time",
                value:'End  : ${DateFormat('EEE, MMM d, yyyy • h:mm a').format(DateTime.fromMillisecondsSinceEpoch(event.endTime * 1000))}',
                color:color,
              ),

              const SizedBox(height: 16),
              const Text(
                "Featured Games",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: EventGamesRow(gamesId:event.games)
              ),        // games logos in a row

              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  if (event.liveStreamUrl.isNotEmpty) {
                    final Uri uri = Uri.parse(event.liveStreamUrl);
                    try {
                      if (!await launchUrl(uri)) {
                        throw Exception('Could not launch ${event.liveStreamUrl}');
                      }
                    } catch (e) {
                      // log(e.toString());
                    }
                  }
                },
                icon: const Icon(Icons.video_library),
                label: const Text("Watch Live"),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _infoTile(BuildContext context,
    {required String title, required String value, required Color color}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(fontSize: 12, color: color),
      ),
    ],
  );
}
