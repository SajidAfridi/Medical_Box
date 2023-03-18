import 'package:flutter/material.dart';
import 'package:medical_box/utils/app_colors.dart';

final listView = ListView.builder(
  itemCount: 2, // replace with the length of your data list
  itemBuilder: (BuildContext context, int index) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      tileColor: Colours.drawerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
      title: const Text(
        'Item title',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      subtitle: const Text(
        'Item subtitle',
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      dense: true,
      isThreeLine: true,
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        // add your onTap logic here
      },
    );
  },
);
