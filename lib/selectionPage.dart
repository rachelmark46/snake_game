
import 'package:flutter/material.dart';
import 'about_page.dart';
import 'game_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_donation_buttons/flutter_donation_buttons.dart';


class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  int numPlayers = 1;
  String difficulty = 'Easy';

  openURL(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }

  @override
  Widget build(BuildContext context) {

    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //toolbarHeight : 20 ,
        toolbarHeight : screenHeight* 0.05 ,
        title: const Text(' Game Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Puzzle Pixel Studio:',
              style: TextStyle(//fontSize: 24,
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
           // const SizedBox(height: 10),
            SizedBox(
                height: screenHeight * 0.01), // 1% of available height

            // Row of Links (Website, Other Apps, Code)
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [InkWell(
                  onTap: () => openURL("https://www.ppixel.org/"),
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
                      child: Text('Website',
                          selectionColor: Colors.black,
                          style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  ),
                ),
                  const SizedBox(width: 10),
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
                      child: Text('Other Apps',selectionColor: Colors.black,
                          style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                  ),const SizedBox(width: 10),
                  InkWell(
                    onTap: () => openURL("https://github.com/rachelmark46/snake_game.git"),
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
                      child: Text('Code',selectionColor: Colors.black,
                          style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                  ),
            ]),
            SizedBox(
                height: screenHeight * 0.02),
            //const SizedBox(height: 30),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BuyMeACoffeeButton(
                  text: "Support Us!",
                  buyMeACoffeeName: "rachelmark",
                  color: BuyMeACoffeeColor.Green,
                  //Allows custom styling

                )]),
            //const SizedBox(height: 20),
            SizedBox(
                height: screenHeight * 0.02),
            Text(
              'Number of Players:',
              style: TextStyle(//fontSize: 24,
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
            //const SizedBox(height: 30),
            SizedBox(
                height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('1 Player', style: TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
                  selected: numPlayers == 1,
                  onSelected: (bool selected) {
                    setState(() {
                      numPlayers = 1;
                    });
                  },
                  selectedColor: Colors.green[700],
                  backgroundColor: Colors.grey[800],
                  labelStyle: TextStyle(
                    color: numPlayers == 1 ? Colors.white : Colors.grey,
                  ),
                ),
                const SizedBox(width: 30),
                ChoiceChip(
                  label: const Text('2 Players', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  selected: numPlayers == 2,
                  onSelected: (bool selected) {
                    setState(() {
                      numPlayers = 2;
                    });
                  },
                  selectedColor: Colors.green[700],
                  backgroundColor: Colors.grey[800],
                  labelStyle: TextStyle(
                    color: numPlayers == 2 ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
            //const SizedBox(height: 30),
            SizedBox(
                height: screenHeight * 0.02),
            Text(
              'Difficulty Level:',
              style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 24,
                  //fontSize: 24,
                 fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('Easy', style: TextStyle(//fontSize: 20,
                      fontSize: isSmallScreen ? 18 : 20,fontWeight: FontWeight.bold)),
                  selected: difficulty == 'Easy',
                  onSelected: (bool selected) {
                    setState(() {
                      difficulty = 'Easy';
                    });
                  },
                  selectedColor: Colors.green[700],
                  backgroundColor: Colors.grey[800],
                  labelStyle:  TextStyle(
                    color: difficulty == 'Easy' ? Colors.white : Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label:  Text('Medium', style: TextStyle(//fontSize:20,
                      fontSize: isSmallScreen ? 18 : 20,fontWeight: FontWeight.bold)),
                  selected: difficulty == 'Medium',
                  onSelected: (bool selected) {
                    setState(() {
                      difficulty = 'Medium';
                    });
                  },
                  selectedColor: Colors.green[700],
                  backgroundColor: Colors.grey[800],
                  labelStyle: TextStyle(
                    color: difficulty == 'Medium' ? Colors.white : Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Hard', style: TextStyle(//fontSize:20,
                      fontSize: isSmallScreen ? 18 : 20,fontWeight: FontWeight.bold)),
                  selected: difficulty == 'Hard',
                  onSelected: (bool selected) {
                    setState(() {
                      difficulty = 'Hard';
                    });
                  },
                  selectedColor: Colors.green[700],
                  backgroundColor: Colors.grey[800],
                  labelStyle: TextStyle(
                    color: difficulty == 'Hard' ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
            //const SizedBox(height: 20),
            SizedBox(
                height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SnakeGamePage(
                      numPlayers: numPlayers,
                      difficulty: difficulty,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(//fontSize: 20,
                    fontSize: isSmallScreen ? 18 : 20,fontWeight: FontWeight.bold),
              ),
              child: const Text('Start Game'),
            ),

            SizedBox(
                height: screenHeight * 0.01),
            //const SizedBox(height: 10),
             ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(//fontSize: 18,
                    fontSize: isSmallScreen ? 18 : 20,fontWeight: FontWeight.bold),
              ),
              child: const Text('About'),
            ),
            SizedBox(
                height: screenHeight * 0.01),
          ],
        ),
      ),
    );
  }
}



