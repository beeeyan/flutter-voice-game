import 'package:flutter/material.dart';
import '../widget/drawer_menu.dart';
import 'package:flutter_speech/flutter_speech.dart';
import 'dart:math';
import "dart:async";

class PlayPage extends StatefulWidget {
  PlayPage({Key key, this.title, this.level}) : super(key: key);

  final String title;
  final String level;

  // アロー関数を用いて、Stateを呼ぶ
  @override
  State<StatefulWidget> createState() => _PlayPage();
}

const String basic = 'basic';
const String advanced = 'advanced';

// TODO DBから取得するように変更(記載場所ここではない気がしている)
const List<String> baseThemeList = [
  '生麦生米生卵',
  '隣の客はよく柿食う客だ',
  'バスガス爆発',
  '裏庭には二羽ニワトリがいる',
  '赤パジャマ黄パジャマ青パジャマ',
  '赤巻紙青巻紙黄巻紙',
  '老若男女',
  '旅客機の旅客'
];

const List<String> advancedThemeList = [
  'アンドロメダだぞ',
  '肩固かったから買った肩たたき機',
  '打者走者勝者走者一掃',
  '専売特許許可局',
  '新設診察室視察',
  '著作者手術中',
  '除雪車除雪作業中',
  '貨客船の旅客と旅客機の旅客',
  '骨粗鬆症訴訟勝訴'
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

  String _image = '';

  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
    setTongueTwister(widget.level);
    if (widget.level == basic) {
      _image = 'images/kaiju.png';
      _hp = 5;
    }
    if (widget.level == advanced) {
      _image = 'images/fantasy_mahoujin_syoukan.png';
      _hp = 7;
    }
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                InkWell(
                  onTap: () => _themeText != '終了!!'? setTongueTwister(widget.level) : null,
                  child: Container(
                    child: _themeText != '終了!!'? Icon(Icons.autorenew) : null,
                  ),
                ),

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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('HP : ',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              Text(_hp.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.red)),
            ],
          ),
          Container(
            height: 280,
            child: Center(
              child: Image.asset(_image),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
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
                  label: _isListening ? 'Listening...' : '詠唱開始',
                ),
                _buildButton(
                  onPressed: _isListening ? () => clear() : null,
                  label: 'やり直し',
                ),
                _buildButton(
                  onPressed: () {
                    attack();
                  },
                  label: '攻撃',
                ),
              ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushReplacementNamed("/home");
        },
        child: Text('ホーム'),
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

  void stop() => _speech.stop().then((_) {
        setState(() => _isListening = false);
      });

  void clear() {
    cancel();
    setState(() => transcription = '');
  }

  void attack() async {
    if (_isListening) {
      stop();
      await Future.delayed(Duration(milliseconds: 500));
    }
    if (_themeText == transcription) {
      setState(() => _hp = _hp - 1);
      setTongueTwister(widget.level);
    }
    if (_hp <= 0) {
      setState(() => _image = 'images/victory.png');
      setState(() => _themeText = '終了!!');
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

  void setTongueTwister(String level) {
    if (level == basic) {
      int index = Random().nextInt(baseThemeList.length);
      setState(() => _themeText = baseThemeList[index]);
    }
    if (level == advanced) {
      int index = Random().nextInt(advancedThemeList.length);
      setState(() => _themeText = advancedThemeList[index]);
    }
    // どちらの条件でもなかった場合
    if(level != basic && level != advanced) {
      int index = Random().nextInt(baseThemeList.length);
      setState(() => _themeText = baseThemeList[index]);
    }
  }
}
