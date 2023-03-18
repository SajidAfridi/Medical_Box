import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/widgets/app_bar.dart';
import '../../widgets/drawer.dart';
import '../../widgets/header_of_all_screens.dart';

class DetailMap extends StatefulWidget {
  const DetailMap({Key? key}) : super(key: key);

  @override
  State<DetailMap> createState() => _DetailMapState();
}

class _DetailMapState extends State<DetailMap> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<String> items = <String>['User 1', 'User 2', 'User 3'];
  String selectedOption = ' ';

  @override
  void initState() {
    super.initState();
    selectedOption = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: ScreenUtil().setWidth(163),
        child: drawer(context),
      ),
      appBar: appBar,
      body: Column(
        children: [
          header(
            context,
            'Map',
            const Icon(
              Icons.location_on_outlined,
              color: Colours.drawerColor,
              size: 17,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.blueGrey,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Positioned(child: DropdownButton<String>(
                  value: selectedOption,
                  hint: Text(selectedOption,),
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                  items: items.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
