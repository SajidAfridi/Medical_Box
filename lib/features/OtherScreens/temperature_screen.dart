import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/widgets/header_of_all_screens.dart';

import '../../utils/app_colors.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/drawer.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({Key? key}) : super(key: key);

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: ScreenUtil().setWidth(163),
        child: drawer(context),
      ),
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(17, 4, 13, 5),
        child: Column(children: [
          header(
            context,
            "Temperature",
            const Icon(
              Icons.scale,
              color: Colours.drawerColor,
              size: 22,
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // replace with the length of your data list
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Card(
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 1.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        tileColor: Colours.listTileColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                              color: Colors.grey.shade300, width: 1.0),
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
                        isThreeLine: true,
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.pushNamed(context, 'details_temperature');
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
