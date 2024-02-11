import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(

              radius: 70,
              backgroundImage: AssetImage("assets/images/my.jpeg"),
              backgroundColor: Colors.greenAccent,

            ),
            SizedBox(height: 20),
            Text(
              'Shubham Bandgar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'I am Shubham Bandgar,I am passionate about developing applications using Flutter. As an Android enthusiast, I enjoy exploring new technologies and creating innovative solutions. Flutter allows me to build beautiful, cross-platform apps with ease, empowering me to bring my ideas to life and reach a wider audience. ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
