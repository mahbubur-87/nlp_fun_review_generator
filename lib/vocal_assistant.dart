import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nlp_fun_review_generator/generator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

import 'generator.dart';

void main() => runApp(VocalAssistant());

class VocalAssistant extends StatefulWidget {
  @override
  _VocalAssistantState createState() => _VocalAssistantState();
}

enum TtsState { playing, stopped, paused, continued }

class _VocalAssistantState extends State<VocalAssistant> {

  final reviewGenerator = Generator();
  final translator = GoogleTranslator();

  ///////////////////////////////////////////////////////////
  int parameterIndex = 0;
  String parameter = '', parameterToDisplay = '', review = '';
  Map<String, String> product = Map<String, String>();
  Map<String, String> replacements = Map<String, String>();
  /////////////////////////////////////////////////////////////////

  bool _hasSpeech = false;
  // sounds in DB. need to check from low frequency to high frequency
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  ///////////////////////////////////////////////////////
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  int resultListened = 0;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  /////////////////==:TTS:==//////////////////////////////////////
  FlutterTts flutterTts;
  String language;
  double volume = 0.69;
  double pitch = 1.2;
  double rate = 0.69;
  bool isCurrentLanguageInstalled = false;

  String _newVoiceText;
  String staticResponse = '';

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;
  ////////////////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();

    requestForPermissions();
    initTts();
  }

  Future<void> requestForPermissions() async {
    if (await Permission.speech.request().isGranted) {
      print("Speech permission is granted.");
    }
    if (await Permission.microphone.request().isGranted) {
      print("Microphone permission is granted.");
    }
  }

  initTts() {
    flutterTts = FlutterTts();

    if (isAndroid) {
      _getEngines();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (isWeb || isIOS) {
      flutterTts.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getEngines() async {
    var engines = await flutterTts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        print("#hello1");
        await flutterTts.speak(_newVoiceText);
        print("#hello2");
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener, debugLogging: true);
    if (hasSpeech) {
      // _localeNames = await speech.locales();

      _localeNames.add(LocaleName('en_US', 'English'));
      _localeNames.add(LocaleName('de_DE', 'Deutsch'));

      // var systemLocale = await speech.systemLocale();
      var systemLocale;

      if (null != systemLocale) {
        _currentLocaleId = systemLocale.localeId;
      } else {
        _currentLocaleId = 'en_US';
      }

      language = _currentLocaleId;
      flutterTts.setLanguage(language);
      if (isAndroid) {
        flutterTts
            .isLanguageInstalled(language)
            .then((value) => isCurrentLanguageInstalled = (value as bool));
      }
    }

    // Welcome Text
    _newVoiceText = "Welcome to the DRIFT - A Dynamic Review Generator. Sir, I need to do product review on your behalf. Do you want to do this?";
    await _speak();

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DRIFT'),
        ),
        body: Column(children: [
          Center(
            child: Text(
              'Speech recognition available',
              style: TextStyle(fontSize: 22.0),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextButton(
                      child: Text('Initialize'),
                      onPressed: _hasSpeech ? null : initSpeechState,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextButton(
                      child: Text('Start'),
                      onPressed: !_hasSpeech || speech.isListening
                          ? null
                          : startListening,
                    ),
                    TextButton(
                      child: Text('Stop'),
                      onPressed: speech.isListening ? stopListening : null,
                    ),
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: speech.isListening ? cancelListening : null,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DropdownButton(
                      onChanged: (selectedVal) => _switchLang(selectedVal),
                      value: _currentLocaleId,
                      items: _localeNames
                          .map(
                            (localeName) => DropdownMenuItem(
                          value: localeName.localeId,
                          child: Text(localeName.name),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'Recognized Words',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Theme.of(context).selectedRowColor,
                        child: Center(
                          child: Text(
                            lastWords,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Positioned.fill(
                      //   bottom: 10,
                      //   child: Align(
                      //     alignment: Alignment.bottomCenter,
                      //     child: Container(
                      //       width: 40,
                      //       height: 40,
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         boxShadow: [
                      //           BoxShadow(
                      //               blurRadius: .26,
                      //               spreadRadius: level * 1.5,
                      //               color: Colors.black.withOpacity(.05))
                      //         ],
                      //         color: Colors.white,
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(50)),
                      //       ),
                      //       child: IconButton(
                      //         icon: Icon(Icons.mic),
                      //         onPressed: () => null,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Theme.of(context).selectedRowColor,
                        child: Center(
                          child: Text(
                            staticResponse,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Positioned.fill(
                      //   bottom: 10,
                      //   child: Align(
                      //     alignment: Alignment.bottomCenter,
                      //     child: Container(
                      //       width: 40,
                      //       height: 40,
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         boxShadow: [
                      //           BoxShadow(
                      //               blurRadius: .26,
                      //               spreadRadius: level * 1.5,
                      //               color: Colors.black.withOpacity(.05))
                      //         ],
                      //         color: Colors.white,
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(50)),
                      //       ),
                      //       child: IconButton(
                      //         icon: Icon(Icons.mic),
                      //         onPressed: () => null,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Column(
          //     children: <Widget>[
          //       Center(
          //         child: Text(
          //           'Error Status',
          //           style: TextStyle(fontSize: 22.0),
          //         ),
          //       ),
          //       Center(
          //         child: Text(lastError),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: speech.isListening
                  ? Text(
                "I'm listening...",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
                  : Text(
                'Not listening',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> startListening() async {
    lastWords = '';
    lastError = '';

    staticResponse = '';

    await speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 12),
        pauseFor: Duration(seconds: 6),
        partialResults: false,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    _speak();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  Future<String> translateText(String text, String locale) async {
    if (locale != 'en_US') {
      Translation translation = await translator.translate(text, from: 'de', to: 'en');
      print("#blackdiamond translated text " + translation.toString());
      text = translation.toString();
    }

    text = text.trim().toLowerCase();

    if (text.contains("number to")) {
      text = text.replaceAll("number to", "number two");
    }

    text = text.replaceAll("number ", "").replaceAll("one", "1")
               .replaceAll("two", "2").replaceAll("three", "3")
               .replaceAll("four", "4").replaceAll("five", "5")
               .replaceAll("six", "6").replaceAll("seven", "7")
               .replaceAll("eight", "8").replaceAll("nine", "9");

    return Future.value(text);
  }

  Future<String> generateResponse(String request, String locale) async {
    request = await translateText(request, locale);
    print("#blackdiamond request $request");

    String response = '';

    if (request == "sure go ahead") {
      response = "Thank you, Sir. Before proceed, I need some information from you. Please tell me review type (options are Product or Service).";
      response = await translateText(response, locale);
      return Future.value(response);
    }

    if (request == "product") {
      reviewGenerator.reviewType = "product";
      response = "Sir, at the moment, I need product information. Please tell me product title.";
      response = await translateText(response, locale);
      return Future.value(response);
    }

    if (request.startsWith("product title is")) {
      product.putIfAbsent("title", () => request.split("product title is")[1].trim());
      response = "Then please tell me product category.";
      response = await translateText(response, locale);
      return Future.value(response);
    }

    if (request.startsWith("product category is")) {
      product.putIfAbsent("category", () => request.split("product category is")[1].trim());
      response = "After that, please tell me product brand.";
      response = await translateText(response, locale);
      return Future.value(response);
    }

    if (request.startsWith("product brand is")) {
      product.putIfAbsent("brand", () => request.split("product brand is")[1].trim());
      response = "Later, please tell me product price.";
      response = await translateText(response, locale);
      return Future.value(response);
    }

    if (request.startsWith("product price is")) {
      product.putIfAbsent("price", () => request.split("product price is")[1].trim());
      response = "Finally, please tell me product seller.";
      response = await translateText(response, locale);
      return Future.value(response);
    }

    if (request.startsWith("product seller is")) {
      product.putIfAbsent("seller", () => request.split("product seller is")[1].trim());
      reviewGenerator.productInfo = product;
      response = "Thank you, Sir, for providing me product information. Now, please choose Review Template Name from following options.\n" +
                  "For 3 Paragraph Template, please say 1.\n" +
                  "For 1 Paragraph Template, please say 2.\n" +
                  "For Point Based Template, please say 3.\n" +
                  "For 5 Paragraph Template, please say 4.";
      response = await translateText(response, locale);
      return Future.value(response);
    }

    if (request.startsWith("review title is")) {
      reviewGenerator.reviewTitle = request.split("review title is ")[1].trim();
      replacements = reviewGenerator.getReviewTemplateParameters();

      if (replacements.isEmpty) {
        review = reviewGenerator.generateReview(replacements);
        print("\n------------------------------------------------\n");

        print("Title: " + reviewGenerator.reviewTitle + "\n");
        print(review);

        print("\n-------------------------------------------------\n");
        parameter = parameterToDisplay = '';

        parameterIndex = 0;
        response = "Thank you, Sir, for your kind cooperation. Product Review is successfully generated.";
      } else {
        response = "Thank you, to finalize the automatic review generation, I need some values for few parameters. So, Sir, may I proceed?";
      }

      response = await translateText(response, locale);
      return Future.value(response);
    }

    if (request == "you can continue please") {
      if (replacements.isNotEmpty) {
        if (replacements.containsKey("<product_category>")) {
          replacements.update("<product_category>", (value) => value = product["category"]);
        }

        if (replacements.containsKey("<product_brand_name>")) {
          replacements.update("<product_brand_name>", (value) => value = product["brand"]);
        }

        parameter = replacements.keys.elementAt(parameterIndex++);

        if (parameter == "<product_category>" ||  parameter == "<product_brand_name>") {
          parameter = replacements.keys.elementAt(parameterIndex++);
        }

        parameterToDisplay = parameter.replaceAll("<", "")
                                      .replaceAll("_", " ")
                                      .replaceAll(">", "");
        response = "Thank you, Sir for your confirmation. Please tell me $parameterToDisplay.";
        response = await translateText(response, locale);
        return Future.value(response);
      }
    }

    if (replacements.isNotEmpty && parameterIndex < replacements.length - 1) {
      if (request.startsWith(parameterToDisplay + " is")) {
        replacements.update(parameter, (v) => v = request.split(parameterToDisplay + " is")[1].trim());

        parameter = replacements.keys.elementAt(parameterIndex++);

        if (parameter == "<product_category>" ||  parameter == "<product_brand_name>") {
          parameter = replacements.keys.elementAt(parameterIndex++);
        }

        parameterToDisplay = parameter.replaceAll("<", "")
                                      .replaceAll("_", " ")
                                      .replaceAll(">", "");
        response = "Next, please tell me $parameterToDisplay.";
        response = await translateText(response, locale);
        return Future.value(response);
      }
    }

    if (replacements.isNotEmpty && parameterIndex == replacements.length - 1) {
      if (request.startsWith(parameterToDisplay + " is")) {
        replacements.update(parameter, (v) => v = request.split(parameterToDisplay + " is")[1].trim());

        parameter = replacements.keys.elementAt(parameterIndex++);

        if (parameter == "<product_category>" ||  parameter == "<product_brand_name>") {
          parameter = replacements.keys.elementAt(parameterIndex++);
        }

        parameterToDisplay = parameter.replaceAll("<", "")
                                      .replaceAll("_", " ")
                                      .replaceAll(">", "");
        response = "Finally, please tell me $parameterToDisplay.";
        response = await translateText(response, locale);

        return Future.value(response);
      }
    }

    if (replacements.isNotEmpty && parameterIndex == replacements.length) {
      if (request.startsWith(parameterToDisplay + " is")) {
        replacements.update(parameter, (v) => v = request.split(parameterToDisplay + " is")[1].trim());
        review = reviewGenerator.generateReview(replacements);
        print("\n------------------------------------------------\n");
        print("Title: " + reviewGenerator.reviewTitle + "\n");
        print(review);
        print("\n-------------------------------------------------\n");
        parameter = parameterToDisplay = '';
        parameterIndex = 0;
        response = "Thank you, Sir, for your kind cooperation. Product Review is successfully generated.";
        response = await translateText(response, locale);
        return Future.value(response);
      }
    }

    if (request == "good job appreciate that") {
      response = "My pleasure and always at your service.";
      response = await translateText(response, locale);
      await reviewGenerator.storeReview(review);
      return Future.value(response);
    }

    switch(request) {
      case "one":
      case "1": reviewGenerator.templateName = "3_Paragraph";
                response = "Ok, thank you. Then please choose Template Type from following options.\n" +
                    "For Type 1, please say 11.\n" +
                    "For Type 2, please say 21.\n" +
                    "For Type 3, please say 31.\n" +
                    "For Type 4, please say 41.";
                response = await translateText(response, locale);
                return Future.value(response);

      case "two":
      case "2": reviewGenerator.templateName = "1_Paragraph";
                response = "Ok, thank you. Then please choose Template Type from following options.\n" +
                    "For Type 1, please say 12.\n" +
                    "For Type 2, please say 22.\n" +
                    "For Type 3, please say 32.";
                response = await translateText(response, locale);
                return Future.value(response);

      case "three":
      case "3": reviewGenerator.templateName = "Point_Based";
                reviewGenerator.templateType = 1;
                response = "Ok, thank you. After that, please tell me what is your review title will be?";
                response = await translateText(response, locale);
                return Future.value(response);

      case "four":
      case "4": reviewGenerator.templateName = "5_Paragraph";
                reviewGenerator.templateType = 1;
                response = "Ok, thank you. After that, please tell me what is your review title will be?";
                response = await translateText(response, locale);
                return Future.value(response);

      case "eleven":
      case "11": reviewGenerator.templateType = 1;
                  response = "Ok, thank you. After that, please tell me what is your review title will be?";
                  response = await translateText(response, locale);
                  return Future.value(response);

      case "twentyone":
      case "twenty one":
      case "21": reviewGenerator.templateType = 2;
                  response = "Ok, thank you. After that, please tell me what is your review title will be?";
                  response = await translateText(response, locale);
                  return Future.value(response);

      case "thirtyone":
      case "thirty one":
      case "31": reviewGenerator.templateType = 3;
                  response = "Ok, thank you. After that, please tell me what is your review title will be?";
                  response = await translateText(response, locale);
                  return Future.value(response);

      case "fortyone":
      case "forty one":
      case "41": reviewGenerator.templateType = 4;
                  response = "Ok, thank you. After that, please tell me what is your review title will be?";
                  response = await translateText(response, locale);
                  return Future.value(response);

      case "twelve":
      case "12": reviewGenerator.templateType = 1;
                  response = "Ok, thank you. After that, please tell me what is your review title will be?";
                  response = await translateText(response, locale);
                  return Future.value(response);

      case "twentytwo":
      case "twenty two":
      case "22": reviewGenerator.templateType = 2;
                  response = "Ok, thank you. After that, please tell me what is your review title will be?";
                  response = await translateText(response, locale);
                  return Future.value(response);

      case "thirtytwo":
      case "thirty two":
      case "32": reviewGenerator.templateType = 3;
                  response = "Ok, thank you. After that, please tell me what is your review title will be?";
                  response = await translateText(response, locale);
                  return Future.value(response);
    }

    return Future.value("");
  }

  Future<void> resultListener(SpeechRecognitionResult result) async {
    ++resultListened;
    print('Result listener $resultListened');

    _newVoiceText = await generateResponse(result.recognizedWords, _currentLocaleId);
    await _speak();

    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
      staticResponse = _newVoiceText;
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    // print(
    // 'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
      //TODO make generic by creating function
      language = _currentLocaleId;
      flutterTts.setLanguage(language);
      if (isAndroid) {
        flutterTts
            .isLanguageInstalled(language)
            .then((value) => isCurrentLanguageInstalled = (value as bool));
      }
    });
    print(selectedVal);
  }
}
