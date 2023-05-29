import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/features/OtherScreens/maps_screen.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> users = [];
  List<String> filteredUsers = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataOnce();
  }

  void fetchDataOnce() async {
    final SharedPreferences adminIDInstance =
        await SharedPreferences.getInstance();
    final adminID = adminIDInstance.getString('adminID');
    //print(adminID);
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child(adminID!);

    DatabaseEvent event = await reference.once();

    List<String> fetchedUsers = [];

    for (var element in event.snapshot.children) {
      fetchedUsers.add(element.key.toString());
    }

    setState(() {
      users = fetchedUsers;
      filteredUsers = fetchedUsers;
    });
  }

  void refreshData() {
    fetchDataOnce();
  }

  void filterUsers(String query) {
    setState(() {
      filteredUsers = users
          .where((user) => user.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<String?> getUserName(String userID) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('All_Users')
            .doc(userID)
            .get();

    if (snapshot.exists) {
      final userData = snapshot.data();
      return userData?['Username'];
    }

    return null;
  }

  Future<String?> getUserBoxID(String userID) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('All_Users')
            .doc(userID)
            .get();

    if (snapshot.exists) {
      final userData = snapshot.data();
      return userData?['BoxId'];
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.w, 4.h, 0.w, 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.blue.withOpacity(0.8),
                height: 100.h,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'profile_screen');
                        },
                        child: Container(
                          height: 50,
                          width: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/doctor_profile.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              filterUsers(value);
                            },
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              fixSizedBox10,
              Expanded(
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.symmetric(vertical: 10.0.h),
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            refreshData();
                          },
                          child: ListView.separated(

                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    Divider(height: 5.h),
                            itemCount: filteredUsers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FutureBuilder<String?>(
                                future: getUserName(filteredUsers[index]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 80.h,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12.0.w,
                                          vertical: 2.0.h,
                                        ),
                                        tileColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0.r),
                                          side: BorderSide(
                                            color: Colors.blueGrey,
                                            width: 1.0.w,
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                          radius: 25.sp,
                                          backgroundImage: const AssetImage(
                                              'assets/images/img.png'),
                                        ),
                                        title: Text(
                                          'Loading...',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Loading...',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward,
                                          size: 20.sp,
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MapScreen(userID: filteredUsers[index])
                                                      .toString()
                                                  as Route<Object?>);
                                        },
                                      ),
                                    );
                                  }

                                  if (snapshot.hasError) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 80.h,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12.0.w,
                                          vertical: 2.0.h,
                                        ),
                                        tileColor: Colours.listTileColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0.r),
                                          side: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1.0.w,
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                          radius: 25.sp,
                                          backgroundImage: const AssetImage(
                                              'assets/images/img.png'),
                                        ),
                                        title: Text(
                                          'Error',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Failed to load user data',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward,
                                          size: 20.sp,
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, 'map_screen');
                                        },
                                      ),
                                    );
                                  }

                                  final userName = snapshot.data ?? '';

                                  return SizedBox(
                                    width: double.infinity,
                                    height: 80.h,
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.0.w,
                                        vertical: 2.0.h,
                                      ),
                                      tileColor: Colors.blue.withOpacity(0.4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0.r),
                                        side: BorderSide(
                                          color: Colors.blueGrey.shade300,
                                          width: 1.0.w,
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                        radius: 25.sp,
                                        backgroundImage: const AssetImage(
                                            'assets/images/img.png'),
                                      ),
                                      title: Text(
                                        userName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: FutureBuilder<String?>(
                                        future:
                                            getUserBoxID(filteredUsers[index]),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Text(
                                              'Loading...',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.black,
                                              ),
                                            );
                                          }

                                          final boxID = snapshot.data ?? '';

                                          return Text(
                                            'Box ID: $boxID',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                            ),
                                          );
                                        },
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward,
                                        size: 20.sp,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MapScreen(
                                                userID: filteredUsers[index]),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
