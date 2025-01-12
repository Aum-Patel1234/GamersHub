import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gamers_hub/modules/models/user/user_model.dart';
import 'package:gamers_hub/modules/ui/screens/auth/bloc/auth_bloc.dart';
import 'package:gamers_hub/utils/config/config.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  String? imgPath;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = context.read<AuthBloc>().state.userModel!;
    _nameController.text = userModel.username;
    const double borderRadius = 12.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),

                // Profile Picture with Animation
                GestureDetector(
                  onTap: () {
                    // Add logic for picking an image
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<AuthBloc,AuthState>(                           // use consumer to listen as well as rebuild at same time 
                        buildWhen: (previous, current) => previous != current,
                        builder: (context, state) {
                          final userModel = state.userModel!;

                          return CircleAvatar(
                            radius: 60,
                            backgroundImage: userModel.profilePicture == null
                                ? null
                                : NetworkImage(userModel.profilePicture!),
                            child: userModel.profilePicture == null
                                ? ClipOval(
                                    child: SvgPicture.asset(
                                      'assets/images/default-user-profileImg.svg',
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 120,
                                    ),
                                  )
                                : null,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () async {
                            final XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
                            final String? path = xFile?.path;

                            if (path == null) return;

                            log(path);

                            // Guard the use of context with a mounted check
                            // mounted is a property available on State objects that indicates whether the widget associated with the State is still part of the widget tree.
                            if (context.mounted) {
                              context.read<AuthBloc>().add(AuthEventUpdateUserImg(filePath: path));
                            }
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6A11CB), // Purple background for the button
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.edit,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Email Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.email, color: Colors.white70),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          userModel.email,
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Name TextField
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(Config.paddingEight),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white70),
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person, color: Colors.white70),                      
                    ),
                    onChanged: (value) {
                      // Add logic to handle name change
                    },
                  ),
                ),
                const SizedBox(height: 16),                

                // Phone Number
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(Config.paddingEight),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _phoneNumberController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.white70),
                      hintText: 'Enter your phone number',
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.phone, color: Colors.white70),
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      // Add logic to handle phone number change
                    },
                  ),
                ),
                const SizedBox(height: 32),                
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // save the contact in firebase
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
