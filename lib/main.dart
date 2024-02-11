import 'package:flutter/material.dart';
import 'about.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(TextEditingApp());
}

class TextEditingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextEditingHomePage(),
    );
  }
}

class TextEditingHomePage extends StatefulWidget {
  @override
  _TextEditingHomePageState createState() => _TextEditingHomePageState();
}

class _TextEditingHomePageState extends State<TextEditingHomePage> {
  TextEditingController _textEditingController = TextEditingController();
  double _textSize = 20.0;
  Color _textColor = Colors.black;
  String _selectedFont = 'Roboto'; // Default font style
  List<TextEditingController> _textControllers = [];
  List<double> _textSizes = [];
  List<Color> _textColors = [];
  List<String> _selectedFonts = [];
  int _currentIndex = -1;

  void _saveChanges() {
    setState(() {
      _textControllers.add(TextEditingController(text: _textEditingController.text));
      _textSizes.add(_textSize);
      _textColors.add(_textColor);
      _selectedFonts.add(_selectedFont);
      _currentIndex++;
    });
  }

  void _undo() {
    if (_currentIndex >= 0) {
      setState(() {
        _currentIndex--;
        _applyChanges();
      });
    }
  }

  void _redo() {
    if (_currentIndex < _textControllers.length - 1) {
      setState(() {
        _currentIndex++;
        _applyChanges();
      });
    }
  }

  void _applyChanges() {
    _textEditingController.text = _textControllers[_currentIndex].text;
    _textSize = _textSizes[_currentIndex];
    _textColor = _textColors[_currentIndex];
    _selectedFont = _selectedFonts[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkEase'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/texted.jpeg'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.withOpacity(0.8), Colors.purple.withOpacity(0.8)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Enter text here...',
              ),
              onChanged: (_) => _saveChanges(),
            ),
            DropdownButton<String>(
              value: _selectedFont,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFont = newValue!;
                  _saveChanges();
                });
              },
              items: <String>['Roboto', 'Arial', 'Times New Roman', 'Courier New']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Slider(
              value: _textSize,
              min: 10.0,
              max: 40.0,
              onChanged: (value) {
                setState(() {
                  _textSize = value;
                  _saveChanges();
                });
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Pick a color'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: _textColor,
                          onColorChanged: (Color color) {
                            setState(() {
                              _textColor = color;
                            });
                          },
                          showLabel: true,
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Save'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            _saveChanges();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Pick Color'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Save'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _undo,
                  child: Text('Undo'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _redo,
                  child: Text('Redo'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: Text(
                _textEditingController.text,
                style: TextStyle(
                  fontSize: _textSize,
                  color: _textColor,
                  fontFamily: _selectedFont,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
