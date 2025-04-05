import 'package:contact_app/core/assets_manager.dart';
import 'package:contact_app/screens/home/widgets/bottom_sheet_body.dart';
import 'package:contact_app/screens/home/widgets/build_contact_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/colors_manager.dart';
import 'models/contact.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Contact> contactsList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsManager.darkBlue,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLogo(),
            contactsList.isEmpty ? buildEmptyState() : buildContactGrid(),
          ],
        ),
        floatingActionButton: buildFloatingButtons(),
      ),
    );
  }

  Widget buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Image.asset(
        AssetsManager.route,
        width: 117,
        height: 39,
      ),
    );
  }

  Widget buildEmptyState() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Lottie.asset(AssetsManager.emptyList),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              child: Text(
                "There is No Contacts Added Here",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: ColorsManager.gold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContactGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          childAspectRatio: 0.68,
        ),
        itemCount: contactsList.length,
        itemBuilder: (context, index) => BuildContactCard(
          contact: contactsList[index],
          onClick: () {
            setState(() {
              contactsList.removeAt(index);
            });
          },
        ),
      ),
    );
  }

  Widget buildFloatingButtons() {
    if (contactsList.isEmpty) {
      return FloatingActionButton(
        onPressed: () => showAddContactSheet(context),
        backgroundColor: ColorsManager.gold,
        child: const Icon(Icons.add, color: ColorsManager.darkBlue),
      );
    } else if (contactsList.length >= 6) {
      return FloatingActionButton(
        onPressed: () {
          setState(() {
            contactsList.removeLast();
          });
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete, color: ColorsManager.white),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                contactsList.removeLast();
              });
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete, color: ColorsManager.white),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => showAddContactSheet(context),
            backgroundColor: ColorsManager.gold,
            child: const Icon(Icons.add, color: ColorsManager.darkBlue),
          ),
        ],
      );
    }
  }

  void showAddContactSheet(BuildContext context) async {
    final newContact = await showModalBottomSheet<Contact>(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorsManager.darkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const BottomSheetBody(),
    );

    if (newContact != null) {
      setState(() {
        contactsList.add(newContact);
      });
    }
  }
}
