import 'dart:io';

import 'package:contact_app/core/assets_manager.dart';
import 'package:contact_app/core/colors_manager.dart';
import 'package:contact_app/screens/home/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({super.key});

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  final formKey = GlobalKey<FormState>();
  File? selectedImage;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void saveUser() {
    if (formKey.currentState!.validate()) {
      Navigator.pop(
          context,
          Contact(
            email: emailController.text,
            name: nameController.text,
            phone: phoneController.text,
            image: selectedImage,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: ColorsManager.darkBlue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildUserInfo(),
                const SizedBox(height: 20),
                buildTextField("Enter User Name", nameController),
                buildTextField("Enter User Email", emailController,
                    keyboardType: TextInputType.emailAddress),
                buildTextField("Enter User Phone", phoneController,
                    keyboardType: TextInputType.phone),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: saveUser,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    backgroundColor: ColorsManager.gold,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "Enter user",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserInfo() {
    return Row(
      children: [
        GestureDetector(
          onTap: pickImage,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            child: selectedImage == null
                ? Lottie.asset(AssetsManager.imagePicker, repeat: false)
                : ClipOval(
                    child: Image.file(
                      selectedImage!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nameController.text.isEmpty ? "User Name" : nameController.text,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: ColorsManager.gold),
              ),
              const Divider(
                color: ColorsManager.gold,
              ),
              Text(
                emailController.text.isEmpty
                    ? "example@email.com"
                    : emailController.text,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: ColorsManager.gold),
              ),
              const Divider(color: ColorsManager.gold),
              Text(
                phoneController.text.isEmpty
                    ? "+200000000000"
                    : phoneController.text,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: ColorsManager.gold),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          return null;
        },
        controller: controller,
        keyboardType: keyboardType,
        onChanged: (value) => setState(() {}),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: ColorsManager.lightBlue),
          filled: true,
          fillColor: ColorsManager.darkBlue,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
