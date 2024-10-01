
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(' Game Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],

        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Puzzle Pixel Studio:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [InkWell(
                  onTap: () => openURL("https://www.ppixel.org/"),
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
                      child: Text('Website',
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
                      child: Text('Other Apps',selectionColor: Colors.black,
                          style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    ),
                  ),const SizedBox(width: 20),
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
                      child: Text('Source Code',selectionColor: Colors.black,
                          style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    ),
                  ),
            ]),
        const SizedBox(height: 40),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BuyMeACoffeeButton(
                  text: "Support Us!",
                  buyMeACoffeeName: "rachelmark",
                  color: BuyMeACoffeeColor.Green,
                  //Allows custom styling

                )]),
            const SizedBox(height: 40),
            const Text(
              'Number of Players:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 40),
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
            const SizedBox(height: 40),
            const Text(
              'Difficulty Level:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Easy', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  selected: difficulty == 'Easy',
                  onSelected: (bool selected) {
                    setState(() {
                      difficulty = 'Easy';
                    });
                  },
                  selectedColor: Colors.green[700],
                  backgroundColor: Colors.grey[800],
                  labelStyle: TextStyle(
                    color: difficulty == 'Easy' ? Colors.white : Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('Medium', style: TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
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
                  label: const Text('Hard', style: TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
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
            const SizedBox(height: 40),
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
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              child: const Text('Start Game'),
            ),


            const SizedBox(height: 20),
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
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:snake_game/game_state.dart';
//
// class SelectionPage extends StatefulWidget {
//   @override
//   _SelectionPageState createState() => _SelectionPageState();
// }
//
// class _SelectionPageState extends State<SelectionPage> {
//   int _numPlayers = 1;
//   String _difficulty = 'Easy';
//
//   Widget buildOptionButton(String label, bool selected, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//         decoration: BoxDecoration(
//           color: selected ? Colors.green : Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.green, width: 2),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               spreadRadius: 2,
//               blurRadius: 5,
//             ),
//           ],
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 18,
//             color: selected ? Colors.white : Colors.green,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Game Settings'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Select Number of Players',
//               style: TextStyle(fontSize: 20),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 buildOptionButton('1', _numPlayers == 1, () {
//                   setState(() {
//                     _numPlayers = 1;
//                   });
//                 }),
//                 buildOptionButton('2', _numPlayers == 2, () {
//                   setState(() {
//                     _numPlayers = 2;
//                   });
//                 }),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Select Difficulty Level',
//               style: TextStyle(fontSize: 20),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 buildOptionButton('Easy', _difficulty == 'Easy', () {
//                   setState(() {
//                     _difficulty = 'Easy';
//                   });
//                 }),
//                 buildOptionButton('Medium', _difficulty == 'Medium', () {
//                   setState(() {
//                     _difficulty = 'Medium';
//                   });
//                 }),
//                 buildOptionButton('Hard', _difficulty == 'Hard', () {
//                   setState(() {
//                     _difficulty = 'Hard';
//                   });
//                 }),
//               ],
//             ),
//             SizedBox(height: 40),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                 textStyle: TextStyle(fontSize: 20),
//               ),
//               onPressed: () {
//                 // Start the game with the selected settings
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SnakeGamePage(
//                       numPlayers: _numPlayers,
//                       difficulty: _difficulty,
//                     ),
//                   ),
//                 );
//               },
//               child: Text('Start Game'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
