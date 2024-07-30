import 'package:flutter/material.dart';
import 'package:waroengsederhana/colors.dart';

class ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;
  const ProfileListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: whiteColor,
          child: ListTile(
            onTap: onTap,
            leading: Icon(
              icon,
              color: tabColor,
            ),
            title: Text(
              title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: tabColor),
            ),
            subtitle: Text(subtitle),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
        ),
        const Divider(
          thickness: 2,
          color: blackColor,
        )
      ],
    );
  }
}
