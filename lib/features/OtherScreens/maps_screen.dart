import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/widgets/app_bar.dart';

import '../../widgets/drawer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<String> options = ['User 1', 'User 2', 'User 3', 'User 4'];
  String selectedOption = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: ScreenUtil().setWidth(163),
        child: drawer,
      ),
      appBar: appBar,
      body: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back),),
              const Text("Map"),
              const Icon(Icons.location_on_outlined),
            ],
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
                  items: options.map((String option) {
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
