library show_event_details_bottomsheet.dart;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gamers_hub/modules/models/events/event.dart';
import 'package:gamers_hub/modules/models/events/event_logo.dart';
import 'package:gamers_hub/modules/service/api_client_id_bearer_token.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

part 'event_games_row.dart';

void showEventDetailsBottomSheet(BuildContext context, Event event, String? imageLink) {
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
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: (imageLink == null)
                        ? const AssetImage('assets/images/80x80_error.png')
                        : NetworkImage(
                            'https:$imageLink'), // Replace with your asset path
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
              const Text(
                "Description:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                event.description,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoTile(context,
                      title: "Start Time",
                      value:
                          'Start: ${DateFormat('EEE, MMM d, yyyy • h:mm a').format(DateTime.fromMillisecondsSinceEpoch(event.startTime * 1000))}\n'),
                  _infoTile(
                    context,
                    title: "End Time",
                    value:
                        'End  : ${DateFormat('EEE, MMM d, yyyy • h:mm a').format(DateTime.fromMillisecondsSinceEpoch(event.endTime * 1000))}',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Games:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              EventGamesRow(gamesId:event.games),        // games logos in a row

              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  if (event.liveStreamUrl.isNotEmpty) {
                    final Uri uri = Uri.parse(event.liveStreamUrl);
                    try {
                      if (!await launchUrl(uri)) {
                        throw Exception(
                            'Could not launch ${event.liveStreamUrl}');
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
    {required String title, required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
      ),
    ],
  );
}
