import 'dart:io';

import 'package:day_manager/constFiles/colors.dart';
import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  static File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
              color: profileContainer,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: imageFile == null
              ? Icon(Icons.person, size: 35, color: profileBG)
              : Image.file(imageFile!, fit: BoxFit.contain),
        ),
        SizedBox(width: 15.0),
        Expanded(
          child: Container(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back,",
                  style:
                      TextStyle(color: greyText, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Mohammed Azhar",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
