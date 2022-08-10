import 'package:flutter/material.dart';



class Emergency_History extends StatefulWidget {
  const Emergency_History({Key? key}) : super(key: key);

  @override
  State<Emergency_History> createState() => _Emergency_HistoryState();
}

class _Emergency_HistoryState extends State<Emergency_History> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(
        color: Colors.white, // <-- SEE HERE
      ), title: Text('EMERGENCY HISTORY', style: TextStyle(
          color: Colors.white),), elevation: 4.0, centerTitle: true,),

      body: SingleChildScrollView(
        child: _userInterface(),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }


  Widget _userInterface() {
    return Container(
      //color: Colors.black.withOpacity(0.6),
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        ],

      ),
    );
  }


}
