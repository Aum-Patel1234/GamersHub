library settings_body.dart;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_hub/modules/theme/bloc/theme_bloc.dart';
import 'package:gamers_hub/modules/ui/screens/auth/bloc/auth_bloc.dart';
import 'package:gamers_hub/utils/config/color_config.dart';

part 'about_dialog.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,                             // to eliminate inherited padding
      children: [
        ListTile(
          leading: ClipOval(
            child: Image.network(
              "https://static.vecteezy.com/system/resources/thumbnails/033/129/417/small/a-business-man-stands-against-white-background-with-his-arms-crossed-ai-generative-photo.jpg",
              fit: BoxFit.cover,
              width: 60,
              height: 60,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.read<AuthBloc>().state.userModel!.username??"",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                context.read<AuthBloc>().state.userModel!.email,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  // debounce the notifications
                },
                icon: const Icon(Icons.edit),
                color: const Color(ColorConfig.submitButtonGreen),
              ),
            ],
          ),
        ),
        const Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Colors.green.withOpacity(0.1), // Light shade of green
            child: const Icon(Icons.payment, color: Colors.green),
          ),
          title: const Text('Payment Methods'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 15,),
          onTap: () {
            // Handle tap
          },
          
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Colors.blue.withOpacity(0.1), // Light shade of blue
            child: const Icon(Icons.subscriptions, color: Colors.blue),
          ),
          title: const Text('Subscriptions'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 15,),
          onTap: () {
            // Handle tap
          },
          
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Colors.orange.withOpacity(0.1), // Light shade of orange
            child: const Icon(Icons.network_cell, color: Colors.orange),
          ),
          title: const Text('Network Preferences'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 15,),
          onTap: () {
            // Handle tap
          },
          
        ),
        const Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Colors.purple.withOpacity(0.1), // Light shade of purple
            child: const Icon(Icons.person, color: Colors.purple),
          ),
          title: const Text('Profile'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 15,),
          onTap: () {
            // Handle tap
          },
          
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red.withOpacity(0.1), // Light shade of red
            child: const Icon(Icons.notifications, color: Colors.red),
          ),
          title: const Text('Notification'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 15,),
          onTap: () {
            // Handle tap
          },
          
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(ColorConfig.submitButtonGreen).withOpacity(0.1), // Light shade of grey
            child: const Icon(Icons.security, color: Color(ColorConfig.submitButtonGreen)),
          ),
          title: const Text('Security'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 15,),
          onTap: () {
            // Handle tap
          },
          
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.teal.withOpacity(0.1), // Light shade of teal
            child: const Icon(Icons.language, color: Colors.teal),
          ),
          title: const Text('Language'),
          subtitle: const Text('English (US)'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 15,),
          onTap: () {
            // Handle tap
          },
          
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor:Colors.orangeAccent.withOpacity(0.1), // Light shade of black
            child: const Icon(Icons.dark_mode, color: Colors.orangeAccent),
          ),
          title: const Text('Dark Mode'),
          trailing: BlocBuilder<ThemeBloc,ThemeState>(
            builder: (context,state) {
              return Switch(
                value: state.themeData == ThemeData.light() ? false : true, // Add your state management here
                onChanged: (value) {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
              );
            }
          ),
          
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor:Colors.lightBlue.withOpacity(0.1), // Light shade of light blue
            child: const Icon(Icons.help, color: Colors.lightBlue),
          ),
          title: const Text('Help Center'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 15,),
          onTap: () {
            // Handle tap
          },
          
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor:Colors.cyan.withOpacity(0.1), // Light shade of cyan
            child: const Icon(Icons.person_add, color: Colors.cyan),
          ),
          title: const Text('Invite Friends'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 15,),
          onTap: () {
            // Handle tap
          },
          
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor:Colors.indigo.withOpacity(0.1), // Light shade of indigo
            child: const Icon(Icons.info, color: Colors.indigo),
          ),
          title: const Text('About GamersHub'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 15,),
          onTap: () {
            customAboutDialog(context);
          },
          
        ),
        const Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor:Colors.redAccent.withOpacity(0.1), // Light shade of redAccent
            child: const Icon(Icons.logout, color: Colors.redAccent),
          ),
          title: const Text('Logout'),
          onTap: () {
            context.read<AuthBloc>().add(AuthEventLogout());
          },
          
        ),
      ],
    );
  }
}