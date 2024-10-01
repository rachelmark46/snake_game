import 'package:flutter/material.dart';

import 'package:snake_game/selectionPage.dart';
import 'package:snake_game/splash_screen_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'game_state.dart';
import 'package:flutter_donation_buttons/flutter_donation_buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreenPage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  openURL(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/snake_background.png'), // Add a background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Snake Game',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectionPage()),
                  );
                },
                child: Text('Start Game'),
              ),SizedBox(height: 80),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const SizedBox(width: 20),
              InkWell(
                  onTap: () => openURL("https://www.ppixel.org/snake"),
                  //child: const Text("About Us"),
                  child: Container(
                    height:20,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.yellowAccent,
                      ),
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                  child: Text('About Us',
                      selectionColor: Colors.black,
                      style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline))

                ),
              ),
                const SizedBox(width: 20),
            InkWell(
                      onTap: () => openURL("https://play.google.com/store/apps/developer?id=Puzzle+Pixel+Studio"),
                      //child: const Text("About Us"),
              child: Container(
                  height:20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.yellowAccent,
                    ),
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text('Check Other Apps',selectionColor: Colors.black,
                      style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              ),
                      ),

              ]),
            ],
          ),
        ),
      ),
    );
  }
}
