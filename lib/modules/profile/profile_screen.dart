import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Avatar size
  final double avatarWidth = 200;
  final double avatarHeight = 200;

  // Holds the picked image file
  File? _avatarFile;

  // Editable profile fields
  String _fullName = "Juan Dela Cruz";
  String _phoneNumber = "+639123456789";
  String _password = "*****";

  // Show bottom sheet to choose image source
  Future<void> _showImageSourceActionSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Pick image from specified source
  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _avatarFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  // Show a dialog to edit a profile field
  Future<void> _editField({
    required String title,
    required String currentValue,
    required ValueChanged<String> onSaved,
    bool obscureText = false,
  }) async {
    final TextEditingController controller =
        TextEditingController(text: currentValue);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $title"),
          content: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(hintText: "Enter new $title"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                onSaved(controller.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // A helper widget for each editable row
  Widget _buildEditableRow({
    required String value,
    required String label,
    required VoidCallback onEdit,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Centered text
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'Alumni Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Alumni Sans',
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
              // Edit icon on the right (overlapping)
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with camera icon overlay using a container with adjustable size
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: avatarWidth,
                height: avatarHeight,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _avatarFile != null
                        ? FileImage(_avatarFile!) as ImageProvider
                        : const AssetImage(
                            'assets/images/copartner-noname.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: _showImageSourceActionSheet,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Full Name Row (centered text with edit icon)
          _buildEditableRow(
            value: _fullName,
            label: "Full Name",
            onEdit: () {
              _editField(
                title: "Full Name",
                currentValue: _fullName,
                onSaved: (value) {
                  setState(() {
                    _fullName = value;
                  });
                },
              );
            },
          ),
          const SizedBox(height: 20),

          // Phone Number Row (centered text with edit icon)
          _buildEditableRow(
            value: _phoneNumber,
            label: "Phone Number",
            onEdit: () {
              _editField(
                title: "Phone Number",
                currentValue: _phoneNumber,
                onSaved: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
              );
            },
          ),
          const SizedBox(height: 20),

          // Password Row (centered text with edit icon)
          _buildEditableRow(
            value: _password,
            label: "Password",
            onEdit: () {
              _editField(
                title: "Password",
                currentValue: _password,
                obscureText: true,
                onSaved: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              );
            },
          ),
          const SizedBox(height: 40),

          // Save Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD62229),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontFamily: 'Alumni Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                // Handle save action (e.g., update profile API)
              },
              child: const Text("I-save"),
            ),
          ),
        ],
      ),
    );
  }
}
