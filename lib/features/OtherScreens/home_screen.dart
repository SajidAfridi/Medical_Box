import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box/features/OtherScreens/maps_screen.dart';
import 'package:medical_box/utils/app_colors.dart';
import 'package:medical_box/utils/app_sizebox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
      backgroundColor: Colors.blue.withOpacity(0.9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.w, 4.h, 0.w, 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100.h,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'profile_screen');
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                'assets/images/doctor_profile.jpeg',
                                height: 50,
                                width: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
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
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            const SizedBox(height: 10),
                            itemCount: filteredUsers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                key: UniqueKey(),
                                background: Container(
                                  color: Colors.red,
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.orange,
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                onDismissed: (direction) {
                                  if (direction == DismissDirection.endToStart) {
                                    // edit action
                                    editItem(index,filteredUsers[index]);

                                  } else if (direction ==
                                      DismissDirection.startToEnd) {
                                    // delete action
                                    deleteItem(index, filteredUsers[index]);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(10),
                                    leading: CircleAvatar(
                                      backgroundColor: _getRandomColor(),
                                      child: Text(
                                        filteredUsers[index]
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    title: FutureBuilder<String?>(
                                      future: getUserName(filteredUsers[index]),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text(
                                            'Loading...',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          );
                                        }

                                        if (snapshot.hasError) {
                                          return const Text(
                                            'Error',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          );
                                        }

                                        final userName = snapshot.data ?? '';

                                        return Text(
                                          userName.toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        );
                                      },
                                    ),
                                    subtitle: FutureBuilder<String?>(
                                      future:
                                      getUserBoxID(filteredUsers[index]),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text(
                                            'Loading...',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          );
                                        }

                                        final boxID = snapshot.data ?? '';

                                        return Text(
                                          'Box ID: $boxID',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        );
                                      },
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.info),
                                          onPressed: () {

                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.call),
                                          onPressed: () {

                                          },
                                        ),
                                      ],
                                    ),
                                    // trailing: const Icon(
                                    //   Icons.arrow_forward_ios,
                                    //   size: 20,
                                    //   color: Colors.blue,
                                    // ),
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
                                ),
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

  void deleteItem(int index, String userID) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.redAccent,
          title: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'User will be deleted',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        deleteUser(index, userID);
      }
    });
  }

  Future<void> deleteUser(index, String userID) async {
    try {
      // Delete user from Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }
    } catch (error) {
      print('Failed to delete user from Firebase Authentication');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete user')),
      );
      return;
    }

    try {
      // Delete user from Firebase Realtime Database
      final SharedPreferences adminIDInstance =
      await SharedPreferences.getInstance();
      final adminID = adminIDInstance.getString('adminID');
      DatabaseReference reference =
      FirebaseDatabase.instance.ref().child(adminID!).child(userID);
      await reference.remove();
    } catch (error) {
      print('Failed to delete user from Firebase Realtime Database');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete user')),
      );
      return;
    }

    try {
      // Delete user from Firestore
      await FirebaseFirestore.instance
          .collection('All_Users')
          .doc(userID)
          .delete();
    } catch (error) {
      print('Failed to delete user from Firestore');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete user')),
      );
      return;
    }

    setState(() {
      filteredUsers.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User deleted successfully')),
    );
  }

  void editItem(int index, String userID) async {
    final TextEditingController highTempController = TextEditingController();
    final TextEditingController lowTempController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: highTempController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Set High Temperature',
                ),
              ),
              TextField(
                controller: lowTempController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Set Low Temperature',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                final highTemp = highTempController.text;
                final lowTemp = lowTempController.text;

                // Perform necessary actions with the edited values
                // For example, update the high and low temperatures in the database

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Color _getRandomColor() {
    final random = Random();
    final colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    return colorList[random.nextInt(colorList.length)];
  }
}
