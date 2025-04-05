import 'dart:io';

class Contact {
  File? image;
  String name;
  String email;
  String phone;

  Contact(
      {this.image,
      required this.name,
      required this.email,
      required this.phone});
}
