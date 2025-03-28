import 'package:devup/widgets/Forms/form_input_with_label.dart';
import 'package:devup/widgets/dummy/profile_dummy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Done",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ProfileDummy(
                    color: Colors.blueAccent,
                    dummyType: ProfileDummyType.Image,
                    scale: 3.0,
                    image: "assets/icon/user-icon.png",
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        FeatherIcons.camera,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LabelledFormInput(
                label: "Your Name",
                placeholder: "User user",
                keyboardType: "text",
                controller: _nameController,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              LabelledFormInput(
                label: "Your Email",
                placeholder: "mmmmm@gmail.com",
                keyboardType: "emailAddress",
                controller: _emailController,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              LabelledFormInput(
                label: "Your Password",
                placeholder: "112233445566",
                keyboardType: "text",
                controller: _passController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              LabelledFormInput(
                label: "Role",
                placeholder: "Frontend developer",
                keyboardType: "text",
                controller: _roleController,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              LabelledFormInput(
                label: "About Me",
                placeholder: "Junior frontend developer",
                keyboardType: "text",
                controller: _aboutController,
                obscureText: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
