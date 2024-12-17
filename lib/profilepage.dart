import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://www.w3schools.com/howto/img_avatar.png'), // Placeholder image URL
            ),
            SizedBox(height: 20),
            // Name
            Text(
              'Md Aidul Islam',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Email
            Text(
              'johndoe@example.com',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            // Profile Details
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.blue),
                    title: Text('Phone'),
                    subtitle: Text('+1 123 456 7890'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.red),
                    title: Text('Location'),
                    subtitle: Text('Tampere, Finland'),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today, color: Colors.green),
                    title: Text('Joined'),
                    subtitle: Text('January 2024'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.grey),
                    title: Text('Settings'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Add navigation to settings page here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
