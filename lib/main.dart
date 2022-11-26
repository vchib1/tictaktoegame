import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //List to Store the Input
  final List<String> _showOnX = [
    '', '', '',
    '', '', '',
    '', '', '',
  ];

  bool _newGame = true; //used for Scoreboard

  bool _isoTurn = true; //used to check the player turn

  int _filled = 0; //used to check the last input to show draw

  String _roundResult = 'Tick Tac Toe'; // used in AppBar to show round's result

  String _whoWins = ''; //used for a condition to add score

  int _oScore = 0; //initial score

  int _xScore = 0; //initial score

  int delayedTime = 1; // Time in Seconds to start the next round after the round is won.

  //Main Theme for UI and TextStyle
  Color mainColor = Colors.tealAccent.shade100;
  Color secondaryColor = Colors.redAccent;
  TextStyle scoreStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.redAccent);
  TextStyle buttonStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.tealAccent.shade100);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.spaceGroteskTextTheme(Theme.of(context).textTheme),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(_roundResult,style: TextStyle(color: mainColor),),
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark, //changes status bar icon to dark
            statusBarColor: Colors.transparent, //changes status bar color to transparent
          ),
        ),
        backgroundColor: mainColor,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //if new game is true show O vs X else show the score(0-0)
                  _newGame ? Text('O vs X',style: scoreStyle,) : Text('$_oScore - $_xScore',style: scoreStyle,),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.maxFinite,
                height: 400,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                    itemBuilder: (context, int index){
                      return GestureDetector(
                        onTap: (){
                          if(_whoWins == 'X' || _whoWins == 'O'){
                            //It disables the gesture detector to accept any input after the round is won.
                          }
                          else {
                            _onTapped(index);
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: secondaryColor,
                            ),
                            child: Center(
                              child: Text(_showOnX[index],
                                style: TextStyle(color: mainColor, fontSize: 100,fontWeight: FontWeight.bold),
                              ),
                            )
                        ),
                      );
                    }
                ),
              ),
              const SizedBox(height: 60,),
              GestureDetector(
                onTap: _restart,
                child: Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text('Restart',style: buttonStyle,),
                    )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
  void _onTapped(int index){
    setState(() {
      if(_isoTurn && _showOnX[index] == ''){
        _showOnX[index] = 'O';
        _filled += 1;
      }
      else if(!_isoTurn && _showOnX[index] == ''){
        _showOnX[index] = 'X';
        _filled += 1;
      }
      _isoTurn = !_isoTurn;
      _checkResult();
      _winner();
    });
  }

  void _checkResult(){
    //horizontal check
    if(_showOnX[0] == _showOnX[1] && _showOnX[1] == _showOnX[2] && _showOnX[0] != ''){
      _roundResult = '${_showOnX[0]} wins';
      _whoWins = _showOnX[0];
      _newGame = false;
      Future.delayed(Duration(seconds: delayedTime), () {
        _nextRound();
      });
    }else if(_showOnX[3] == _showOnX[4] && _showOnX[4] == _showOnX[5] && _showOnX[3] != ''){
      _roundResult = '${_showOnX[3]} wins';
      _whoWins = _showOnX[3];
      _newGame = false;
      Future.delayed(Duration(seconds: delayedTime), () {
        _nextRound();
      });
    }else if(_showOnX[6] == _showOnX[7] && _showOnX[7] == _showOnX[8] && _showOnX[6] != ''){
      _roundResult = '${_showOnX[6]} wins';
      _whoWins = _showOnX[6];
      _newGame = false;
      Future.delayed(Duration(seconds: delayedTime), () {
        _nextRound();
      });
    }
    //vertical check
    else if(_showOnX[0] == _showOnX[3] && _showOnX[3] == _showOnX[6] && _showOnX[0] != ''){
      _roundResult = '${_showOnX[0]} wins';
      _whoWins = _showOnX[0];
      _newGame = false;
      Future.delayed(Duration(seconds: delayedTime), () {
        _nextRound();
      });

    }else if(_showOnX[1] == _showOnX[4] && _showOnX[4] == _showOnX[7] && _showOnX[1] != ''){
      _roundResult = '${_showOnX[1]} wins';
      _whoWins = _showOnX[1];
      _newGame = false;
      Future.delayed(Duration(seconds: delayedTime), () {
        _nextRound();
      });
    }else if(_showOnX[2] == _showOnX[5] && _showOnX[5] == _showOnX[8] && _showOnX[2] != ''){
      _roundResult = '${_showOnX[2]} wins';
      _whoWins = _showOnX[2];
      _newGame = false;
      Future.delayed(Duration(seconds: delayedTime), () {
        _nextRound();
      });
    }
    //diagonal check
    else if(_showOnX[0] == _showOnX[4] && _showOnX[4] == _showOnX[8] && _showOnX[0] != ''){
      _roundResult = '${_showOnX[0]} wins';
      _whoWins = _showOnX[0];
      _newGame = false;
      Future.delayed(Duration(seconds: delayedTime), () {
        _nextRound();
      });
    }else if(_showOnX[2] == _showOnX[4] && _showOnX[4] == _showOnX[6] && _showOnX[2] != ''){
      _roundResult = '${_showOnX[2]} wins';
      _whoWins = _showOnX[2];
      _newGame = false;
      Future.delayed(Duration(seconds: delayedTime), () {
        _nextRound();
      });
    }else if(_filled == 9){
      _roundResult = 'Draw';
      _newGame = false;
      Future.delayed(Duration(seconds: delayedTime), () {
        _nextRound();
      });
    }
  }

  //check winner and add score
  void _winner(){
    if(_whoWins == 'O' ){
      _oScore += 1;
    }else if(_whoWins == 'X' ){
      _xScore += 1;
    }
  }

  void _restart(){
    setState(() {
      for(int i = 0; i < 9; i++){
        _showOnX[i] = '';
      }
      _filled = 0;
      _xScore = 0;
      _oScore = 0;
      _whoWins = '';
      _roundResult = 'Tic Tac Toe';
      _isoTurn = true;
      _newGame = true;
    });
  }

  void _nextRound(){
    setState(() {
      for(int i = 0; i < 9; i++){
        _showOnX[i] = '';
      }
      _filled = 0;
      _whoWins = '';
      _roundResult = 'Tic Tac Toe';
      _isoTurn = true;
    });
  }

}



