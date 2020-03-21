import 'package:flutter/material.dart';
import '../widget/drawer_menu.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'dart:math';

class PlayPage extends StatefulWidget {
  PlayPage({Key key, this.title}) : super(key: key);

  final String title;

  // アロー関数を用いて、Stateを呼ぶ
  @override
  State<StatefulWidget> createState() => _PlayPage();
}


// TODO DBから取得するように変更(記載場所ここではない気がしている)
const List<String> themeList = [
  '生麦生米生卵',
  '隣の客はよく柿食う客だ',
  'バスガス爆発',
  '裏庭には二羽ニワトリがいる',
  '赤パジャマ黄パジャマ青パジャマ',
  '赤巻紙青巻紙黄巻紙',
  '老若男女',
  '旅客機の旅客'
];

const languages = const [
  const Language('Japanese', 'ja_JA'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class _PlayPage extends State<PlayPage> with SingleTickerProviderStateMixin {
  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  int _hp = 5;

  String _themeText = '';
  String transcription = '';

  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
    setTongueTwister();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech.activate('ja_JA').then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                _themeText,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
//          Row(
//            children: <Widget>[
//              Text(_hp.toString()),
//              Text((_themeText == transcription).toString())
//            ],
//          ),
          Container(
            child: Center(
              child: Image.asset('images/kaiju.png'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            width: 300,
            color: Colors.grey.shade200,
            child: Text(transcription),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton(
                  onPressed: _speechRecognitionAvailable && !_isListening
                      ? () => start()
                      : null,
                  label: _isListening
                      ? 'Listening...'
                      : '詠唱開始',
                ),
                _buildButton(
                  onPressed: _isListening ? () => clear() : null,
                  label: 'やり直し',
                ),
                _buildButton(
                  onPressed: (){
                    if(_isListening){
                      stop();
                    }
                    attack();
                  },
                  label: '攻撃',
                ),
              ]
          )
        ],
      ),
    );
  }

  Widget _buildButton({String label, VoidCallback onPressed}) => new Padding(
      padding: new EdgeInsets.all(12.0),
      child: new RaisedButton(
        color: Colors.cyan.shade600,
        onPressed: onPressed,
        child: new Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ));

  void start() => _speech.activate(selectedLang.code).then((_) {
        return _speech.listen().then((result) {
          print('_MyAppState.start => result $result');
          setState(() {
            _isListening = result;
          });
        });
      });

  void cancel() =>
      _speech.cancel().then((_) => setState(() => _isListening = false));

  void stop() =>
      _speech.stop().then((_) {
        setState(() => _isListening = false);
      });

  void clear(){
    cancel();
    setState(() => transcription = '');
  }

  void attack(){
    activateSpeechRecognizer();
    if(_themeText == transcription){
      setState(() => _hp = _hp - 1);
      setTongueTwister();
    }
  }

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_MyAppState.onCurrentLocale... $locale');
    setState(
        () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print('_MyAppState.onRecognitionResult... $text');
    setState(() => transcription = text);
  }

  void onRecognitionComplete(String text) {
    print('_MyAppState.onRecognitionComplete... $text');
    setState(() => _isListening = false);
  }

  void errorHandler() => activateSpeechRecognizer();

  void setTongueTwister() {
    int index = Random().nextInt(themeList.length - 1);
    setState(() => _themeText = themeList[index]);
  }
}
