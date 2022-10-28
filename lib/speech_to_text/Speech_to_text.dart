// ignore: file_names


import 'package:flutter/material.dart';
//import 'package:fancy_containers/fancy_containers.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
//import 'package:avatar_glow/avatar_glow.dart';

class SpeetchToText extends StatefulWidget {
  const SpeetchToText({Key? key}) : super(key: key);

  @override
  State<SpeetchToText> createState() => _SpeetchToTextState();
}

class _SpeetchToTextState extends State<SpeetchToText> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
            height: 40,
            width: 300,decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
            color: Colors.white,),
            
            child: Row(
              children: [const SizedBox(width: 10,),
                SizedBox(width: 230,
                  child: FittedBox(
                    child: Text(_lastWords,style: const TextStyle(color: Colors.black),)),
                ),const Spacer(),
                IconButton(
                  icon:const Icon(Icons.search),
                  color: Colors.red,
                  onPressed: () {
                    // _speechToText.isNotListening
                    //     ? _startListening
                    //     : _stopListening;
                    // tooltip:
                    // 'Listen';
                    // child:
                    // Icon(_speechToText.isNotListening
                    //     ? Icons.mic_off
                    //     : Icons.mic,color: Colors.black,);
                  },
                )
              ],
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 40,child: FittedBox(child: Text(_lastWords)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Container(
                  height: 100,
                  width: 300,
                  child:const Center(child: Text('Hello World')),
                  decoration:const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                        Colors.yellowAccent,
                        Colors.green,
                        Colors.lime
                      ]))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                padding:const EdgeInsets.all(16),
                child:const Text(
                  'Recognized words:',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:const EdgeInsets.all(16),
                child: Text(
                  _speechToText.isListening
                      ? _lastWords
                      // If listening isn't active but could be tell the user

                      : _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                ),
              ),
            ),
          
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
