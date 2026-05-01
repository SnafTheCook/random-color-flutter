import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}
///Root widget of the application
class Main extends StatelessWidget {
  ///Creates MyApp instance
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Random color generator'),
      debugShowCheckedModeBanner: false,
    );
  }
}
///Main page of the color generating application
class MyHomePage extends StatefulWidget {
  ///Creates MyHomePage instance
  const MyHomePage({required this.title, super.key});
  ///The title of the application
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _backgroundColor = Colors.blue;
  final int _numberOfCharacters = 6;
  final double _luminanceTreshhold = 0.5;
  final List<Color> _colorHistory = [];
  final List<String> _availableCharacters = 
  ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
   'A', 'B', 'C', 'D', 'E', 'F' ];
  
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: _changeColor,
            behavior: HitTestBehavior.opaque,
            child: Container(
              color: _backgroundColor,
              alignment: Alignment.center,
              child: Text(
                'Hello there!', 
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: _getSecondaryColor(),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: _colorHistory.length,
                  itemBuilder: (_, index) {
                    return _HistoryBox(
                      color: _colorHistory[index], 
                      borderColor: _getSecondaryColor());
                  },
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  void _changeColor(){
    setState(() {
      final List<String> tempCharactersList = _availableCharacters;
      const String rgbString = '0xFF';
      final int randomIndex = DateTime.now()
        .microsecondsSinceEpoch % tempCharactersList.length;

      final StringBuffer buffer = StringBuffer(rgbString);

      for (var i = 0; i < _numberOfCharacters; i++) {
        tempCharactersList.shuffle();
        buffer.write(tempCharactersList[randomIndex]);
      }

      _backgroundColor = Color(int.parse(buffer.toString()));
      _colorHistory.add(_backgroundColor);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients) return;

        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent, 
          duration: const Duration(milliseconds: 300), 
          curve: Curves.easeInOut
          );
      });
    });
  }

  Color _getSecondaryColor(){
    return _backgroundColor.computeLuminance() > _luminanceTreshhold ?
     Colors.black : Colors.white;
  }

  @override
  void dispose()
  {
    _scrollController.dispose();
    super.dispose();
  }
}

class _HistoryBox extends StatelessWidget {
  const _HistoryBox({
    required this.color,
    required this.borderColor
  });

  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(
          color: Colors.black.withAlpha(150),
          blurRadius: 4,
          offset: const Offset(0, 2)
        )]
      ),
    );
  }
}
