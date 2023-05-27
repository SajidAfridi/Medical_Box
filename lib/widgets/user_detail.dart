import 'package:flutter/material.dart';
class UserDetailsScreen extends StatelessWidget {
  final String userId;
  final Map<String, dynamic> userDetails;

  const UserDetailsScreen(this.userId, this.userDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User ID: $userId'),
          Text('Current Temperature: ${userDetails['info']['CurrentTemperature']}'),
          Text('High Temperature: ${userDetails['info']['HighTemperature']}'),
          Text('Is Under Threshold: ${userDetails['info']['isUnderThreshold']}'),
          Text('Low Temperature: ${userDetails['info']['lowTemperature']}'),
          Text('Location: ${userDetails['location']}'),
          // Add more details here as needed
        ],
      ),
    );
  }
}
