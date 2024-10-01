
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snake_game/aboutmePage.dart';
import 'package:snake_game/selectionPage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_donation_buttons/flutter_donation_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class SnakeGamePage extends StatefulWidget {
  final int numPlayers;
  final String difficulty;

  const SnakeGamePage(
      {Key? key, required this.numPlayers, required this.difficulty})
      : super(key: key);

  @override
  State<SnakeGamePage> createState() => _SnakeGamePageState();
}

enum Direction { up, down, left, right }

class _SnakeGamePageState extends State<SnakeGamePage> {
  late AudioPlayer _audioPlayer;

  int row = 20,
      column = 20;
  List<int> borderList = [];
  List<int> userSnakePosition = [];
  List<int> computerSnakePosition = [];
  int userSnakeHead = 0;
  int computerSnakeHead = 0;
  int userScore = 0;
  int computerScore = 0;
  int userHighScore = 0;
  int computerHighScore = 0;
  int userWins = 0;
  int computerWins = 0;

  late Direction userDirection;
  late Direction computerDirection;
  late int foodPosition;
  late Timer gameTimer;
  bool isTwoPlayer = false;
  bool isPaused = false;
  bool isGameRunning = false;

  int speed = 300; // Default speed for easy level

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Set difficulty speed
    switch (widget.difficulty) {
      case 'Medium':
        speed = 200;
        break;
      case 'Hard':
        speed = 100;
        break;
      case 'Easy':
      default:
        speed = 300;
    }

    // Set player mode
    isTwoPlayer = widget.numPlayers == 2;
    loadHighScoresAndWins();
    startGame();
  }

  @override
  void dispose() {
    gameTimer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void startGame() {
    setState(() {
      isGameRunning = true;
      makeBorder();
      generateFood();
      userDirection = Direction.right;
      if (isTwoPlayer) {
        computerDirection = Direction.right;
        computerSnakePosition = [85, 84, 83];
        computerSnakeHead = computerSnakePosition.first;
      }
      userSnakePosition = [45, 44, 43];
      userSnakeHead = userSnakePosition.first;
      //score = 11;
      userScore = 0;
      computerScore = 0;
      isPaused = false;
      gameTimer = Timer.periodic(Duration(milliseconds: speed), (timer) {
        if (!isPaused) {
          updateSnake();
          if (checkCollision(userSnakePosition, userSnakeHead) ||
              (isTwoPlayer &&
                  checkCollision(computerSnakePosition, computerSnakeHead)) ||
              (isTwoPlayer && checkSnakesCollision())) {
            timer.cancel();
            _playGameOverSound();
            showGameOverDialog();
          }
        }
      });
    });
  }

  Future<void> loadHighScoresAndWins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userHighScore = prefs.getInt('userHighScore') ?? 0;
      computerHighScore = prefs.getInt('computerHighScore') ?? 0;
      userWins = prefs.getInt('userWins') ?? 0;
      computerWins = prefs.getInt('computerWins') ?? 0;
    });
  }

  Future<void> updateHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userScore > userHighScore) {
      setState(() {
        userHighScore = userScore;
      });
      await prefs.setInt('userHighScore', userHighScore);
    }
    if (computerScore > computerHighScore) {
      setState(() {
        computerHighScore = computerScore;
      });
      await prefs.setInt('computerHighScore', computerHighScore);
    }
  }

  Future<void> updateWins(bool userWon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userWon) {
      setState(() {
        userWins += 1;
      });
      await prefs.setInt('userWins', userWins);
    } else {
      setState(() {
        computerWins += 1;
      });
      await prefs.setInt('computerWins', computerWins);
    }
  }

  void showGameOverDialog() {
    bool userWon = userScore > computerScore;
    updateHighScores();
    updateWins(userWon);
    String dialogMessage = isTwoPlayer
        ? (userWon ? "Player 1 wins!" : "Player 2 wins!")
        : "Your score: $userScore\nHigh score: $userHighScore";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            "Game Over",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: Text(
            dialogMessage,
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text(
                "Restart",
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SelectionPage()),
                );
              },
              child: const Text(
                "Change Settings",
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
            ), const BuyMeACoffeeButton(
              text: "Support Us",
              buyMeACoffeeName: "rachelmark",
              color: BuyMeACoffeeColor.Blue,
              //Allows custom styling

            )
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      userSnakePosition = [];
      computerSnakePosition = [];
      isGameRunning = false;
      gameTimer.cancel();
      startGame();
    });
  }

  bool checkCollision(List<int> snakePosition, int snakeHead) {
    // if snake collides with border
    if (borderList.contains(snakeHead)) return true;
    // if snake collides with itself
    if (snakePosition.sublist(1).contains(snakeHead)) return true;
    return false;
  }

  bool checkSnakesCollision() {
    for (var pos in userSnakePosition) {
      if (computerSnakePosition.contains(pos)) return true;
    }
    return false;
  }

  void generateFood() {
    foodPosition = Random().nextInt(row * column);
    if (borderList.contains(foodPosition) ||
        userSnakePosition.contains(foodPosition) ||
        (isTwoPlayer && computerSnakePosition.contains(foodPosition))) {
      generateFood();
    }
  }

  void updateSnake() {
    setState(() {
      // Update user snake
      switch (userDirection) {
        case Direction.up:
          userSnakePosition.insert(0, userSnakeHead - column);
          break;
        case Direction.down:
          userSnakePosition.insert(0, userSnakeHead + column);
          break;
        case Direction.right:
          userSnakePosition.insert(0, userSnakeHead + 1);
          break;
        case Direction.left:
          userSnakePosition.insert(0, userSnakeHead - 1);
          break;
      }

      // Update computer snake to move towards food
      if (isTwoPlayer) {
        if (computerSnakeHead % column < foodPosition % column) {
          computerDirection = Direction.right;
        } else if (computerSnakeHead % column > foodPosition % column) {
          computerDirection = Direction.left;
        } else if (computerSnakeHead ~/ column < foodPosition ~/ column) {
          computerDirection = Direction.down;
        } else if (computerSnakeHead ~/ column > foodPosition ~/ column) {
          computerDirection = Direction.up;
        }

        switch (computerDirection) {
          case Direction.up:
            computerSnakePosition.insert(0, computerSnakeHead - column);
            break;
          case Direction.down:
            computerSnakePosition.insert(0, computerSnakeHead + column);
            break;
          case Direction.right:
            computerSnakePosition.insert(0, computerSnakeHead + 1);
            break;
          case Direction.left:
            computerSnakePosition.insert(0, computerSnakeHead - 1);
            break;
        }
      }

      // Check if user snake eats food
      if (userSnakeHead == foodPosition) {
        userScore++;
        generateFood();
        _playEatSound();
      } else {
        userSnakePosition.removeLast();
      }

      // Check if computer snake eats food
      if (isTwoPlayer && computerSnakeHead == foodPosition) {
        computerScore++;
        generateFood();
        _playEatSound();
      } else if (isTwoPlayer) {
        computerSnakePosition.removeLast();
      }

      userSnakeHead = userSnakePosition.first;
      if (isTwoPlayer) {
        computerSnakeHead = computerSnakePosition.first;
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  Future<void> _playClickSound() async {
    await _audioPlayer.play(AssetSource('audio/button_click.mp3'));
  }

  void _playEatSound() async {
    await _audioPlayer.play(AssetSource('audio/eating.mp3'));
  }

  void _playGameOverSound() async {
    await _audioPlayer.play(AssetSource('audio/game_over.mp3'));
  }

  Color fillBoxColor(int index) {
    if (borderList.contains(index)) {
      return Colors.yellowAccent;
    } else if (index == userSnakeHead) {
      return Colors.greenAccent;
    } else if (isTwoPlayer && index == computerSnakeHead) {
      return Colors.lightBlue;
    } else if (userSnakePosition.contains(index)) {
      return Colors.lightGreenAccent;
    } else if (isTwoPlayer && computerSnakePosition.contains(index)) {
      return Colors.lightBlueAccent;
    } else if (index == foodPosition) {
      return Colors.red;
    } else {
      return Colors.grey.withOpacity(0.05);
    }
  }

  void makeBorder() {
    for (int i = 0; i < column; i++) {
      borderList.add(i); // top border
    }
    for (int i = row; i <= column * row; i += row) {
      borderList.add(i - 1); // right border
    }
    for (int i = column * row - 1; i > column * (row - 1); i--) {
      borderList.add(i); // bottom border
    }
    for (int i = column * (row - 1); i >= 0; i -= row) {
      borderList.add(i); // left border
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define a base size for scaling different elements
    double baseGridSize = min(screenWidth, screenHeight) * 0.1;
    double baseFontSize = min(screenWidth, screenHeight) * 0.04; // Slightly reduce font size
    double baseButtonSize = min(screenWidth, screenHeight) * 0.1;
    openURL(String url) async {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
    return Scaffold(
      body: Column(
        children: [
          if (isGameRunning)
            Expanded(
              child: Column(
                children: [
                  // Score Display
                  Expanded(
                    flex: 1, // Reduced flex to make the score section smaller
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!isTwoPlayer)
                            Column(
                              children: [
                                Text(
                                  "Score: $userScore",
                                  style: TextStyle(
                                      fontSize: baseFontSize,
                                      color: Colors.black),
                                ),
                                Text(
                                  "High Score: $userHighScore",
                                  style: TextStyle(
                                      fontSize: baseFontSize,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          if (isTwoPlayer)
                            Column (
                              children: [
                                Text(
                                  "Player 1 Wins: $userWins",
                                  style: TextStyle(
                                      fontSize: baseFontSize,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Player 2 Wins: $computerWins",
                                  style: TextStyle(
                                      fontSize: baseFontSize,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  // Game View
                  Expanded(
                    flex: 5,
                    // Increased flex to allocate more space to the game view
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: column,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 2.0,
                            crossAxisSpacing: 2.0,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              width: baseGridSize,
                              height: baseGridSize,
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: fillBoxColor(index),
                              ),
                            );
                          },
                          itemCount: row * column,
                        ),
                      ),
                    ),
                  ),
                  // Game Controls
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (userDirection != Direction.down)
                                userDirection = Direction.up;
                              _playClickSound();
                            },
                            icon: const Icon(Icons.arrow_circle_up,
                                color: Colors.green),
                            iconSize: baseButtonSize, // Scaled size
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (userDirection != Direction.right)
                                    userDirection = Direction.left;
                                  _playClickSound();
                                },
                                icon: const Icon(
                                    Icons.arrow_circle_left_outlined,
                                    color: Colors.green),
                                iconSize: baseButtonSize, // Scaled size
                              ),
                              const SizedBox(width: 20),
                              IconButton(
                                onPressed: () {
                                  if (userDirection != Direction.left)
                                    userDirection = Direction.right;
                                  _playClickSound();
                                },
                                icon: const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: Colors.green),
                                iconSize: baseButtonSize, // Scaled size
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              if (userDirection != Direction.up)
                                userDirection = Direction.down;
                              _playClickSound();
                            },
                            icon: const Icon(Icons.arrow_circle_down_outlined,
                                color: Colors.green),
                            iconSize: baseButtonSize, // Scaled size
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: togglePause,
                                child: Text(isPaused ? "Resume" : "Pause"),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => SelectionPage()),
                                  );
                                },
                                child: const Text("Change Settings"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
