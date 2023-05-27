import 'package:flutter/material.dart';

class UsersListPage extends StatefulWidget {
  final Map<String, dynamic> response;

  const UsersListPage({Key? key, required this.response}) : super(key: key);

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  List<String> userIds = [];

  @override
  void initState() {
    super.initState();
    extractUserIds();
  }

  void extractUserIds() {
    if (widget.response.containsKey('100012')) {
      Map<String, dynamic> userData = widget.response['100012'];
      userIds = userData.keys.toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: ListView.builder(
        itemCount: userIds.length,
        itemBuilder: (context, index) {
          String userId = userIds[index];
          return ListTile(
            title: Text('User ID: $userId'),
          );
        },
      ),
    );
  }
}
