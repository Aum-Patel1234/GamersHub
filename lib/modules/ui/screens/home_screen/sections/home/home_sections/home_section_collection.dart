library home_section_collection.dart;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/models/games/games.dart';
import 'package:gamers_hub/modules/theme/bloc/theme_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/home/home_sections/events/bloc/event_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/home/home_sections/events/widgets/show_event_details_bottomsheet.dart';
import 'package:gamers_hub/modules/ui/screens/home_screen/sections/home/home_sections/topcharts/bloc/top_charts_bloc.dart';
import 'package:gamers_hub/utils/config/config.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

part 'kids.dart';
part 'events/events.dart';
part 'for_you.dart';
part 'categories/categories.dart';
part 'topcharts/top_charts.dart';