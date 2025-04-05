import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/assets_manager.dart';
import '../../../core/colors_manager.dart';
import '../models/contact.dart';

class BuildContactCard extends StatelessWidget {
  const BuildContactCard(
      {super.key, required this.contact, required this.onClick});

  final Contact contact;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Card(
        color: ColorsManager.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: contact.image != null
                      ? Image.file(
                          contact.image!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 150,
                        )
                      : Lottie.asset(
                          repeat: false,
                          AssetsManager.imagePicker,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: ColorsManager.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(contact.name,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.darkBlue)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.email,
                        color: ColorsManager.darkBlue,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(contact.email,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.darkBlue)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_in_talk_rounded,
                        color: ColorsManager.darkBlue,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(contact.phone,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.darkBlue)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: onClick,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: ColorsManager.white,
                    ),
                    Text("Delete", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
