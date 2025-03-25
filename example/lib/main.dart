import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:language_helper/language_helper.dart';

import 'page_asset.dart';
import 'resources/language_helper/language_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LanguageHelper.instance.initial(
    data: [LanguageDataProvider.data(languageData)],
    analysisKeys: analysisLanguageData.keys.toSet(),
    initialCode: LanguageCodes.en,
    isDebug: !kReleaseMode,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: LanguageHelper.instance.delegates,
      supportedLocales: LanguageHelper.instance.locales,
      locale: LanguageHelper.instance.locale,
      home: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LanguageBuilder(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Tr((_) => Text('Hello'.trans)),
        ),
        body: Center(
          child: Column(
            children: [
              LanguageBuilder(builder: (context) {
                return LanguageBuilder(builder: (context) {
                  return Text('Hello'.trans);
                });
              }),
              Text('Hello'.trans),
              ElevatedButton(
                onPressed: () {
                  if (LanguageHelper.instance.code == LanguageCodes.vi) {
                    LanguageHelper.instance.change(LanguageCodes.en);
                  } else {
                    LanguageHelper.instance.change(LanguageCodes.vi);
                  }
                },
                child: const Text('Change language'),
              ),
              Builder(builder: (_) => Text('Hello'.trans)),
              Dialog(
                child: Text('Hello'.trans),
              ),
              Text('This is @number dollar'.trP({'number': 0})),
              Text('This is @number dollar'.trP({'number': 1})),
              Text('This is @number dollar'.trP({'number': 100})),
              Text('This is a contains variable line $mounted'.trans),
              ElevatedButton(
                onPressed: () {
                  LanguageHelper.instance
                      .addData(LanguageDataProvider.data(languageDataAdd));
                },
                child: Text('This text will be changed when the data added'.trans),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const OtherPage()));
                },
                child: const Text('Go to Other Page'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const PageAsset()));
                },
                child: const Text('Go to Asset Page'),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LanguageBuilder(builder: (context) {
          return Text('Other Page'.trans);
        }),
      ),
      body: Column(
        children: [
          Tr((_) => Text('Text will be changed'.trans)),
          Text('Text will be not changed'.trans),
          ElevatedButton(
            onPressed: () {
              if (LanguageHelper.instance.code == LanguageCodes.vi) {
                LanguageHelper.instance.change(LanguageCodes.en);
              } else {
                LanguageHelper.instance.change(LanguageCodes.vi);
              }
            },
            child: Tr((_) => Text('Change language'.trans)),
          ),
        ],
      ),
    );
  }
}
