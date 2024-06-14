import 'package:flutter/material.dart';

class BibliografiaPage extends StatelessWidget {
  final String conclusion;

  const BibliografiaPage({Key? key, required this.conclusion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conclusion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            conclusion,
            style: TextStyle(
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyAppss());
}

class MyAppss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BibliografiaPage(
        conclusion:
            'https://github.com/geekyshow1/flutter_fbfirestore_crud/tree/master,https://youtu.be/bnZUyHNaxfU,https://github.com/codigoalphacol/Flutter-Login-Firebase,https://youtu.be/sHqrawmQq2w,https://github.com/TarekAlabd/Authentication-With-Amazing-UI-Flutter',
      ),
    );
  }
}
