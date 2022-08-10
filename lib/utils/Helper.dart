import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class Helper {

  static const String customerCareNumber = "+233501622411";
  static const String whatsAppNumber       = "+233501647773";
  static const String platform              = "Android";
  static const String errorMessageOops        = "Oops!! 😔";
  static const String applicationCurrentVersion = "1.0";
  static const String noData = "No data available";
  static const String errorMessageSomethingWentWrong = "Please check your internet connectivity";
  static const String addContactMsg1    = "\nAdd up to 10 emergency contacts.People you add will be notified via text message to come to your aid with reinforcement, Whenever you click the emergency button.\n";
  static const String addContactMsg_non = "\nAdd up to 10 emergency contacts. People you add will be notified via automatic phone call to come to your aid with reinforcement, Whenever you click the emergency button.\n\nTo complete this section. Dial 1266 and register your MTN mobile number and add a prerecorded emergency voice note,which will be played to your contacts to come to your aide with reinforcements whenever you click the panic button\n";
  static const String addContactMsg_mtn = "\nAdd up to 10 emergency contacts. People you add will be notified via automatic phone call to come to your aid with reinforcement, Whenever you click the emergency button.\n\nTo complete this section. Dial 1266 and register your merchant number and add a prerecorded emergency voice note,which will be played to your contacts to come to your aide with reinforcements whenever you the click panic button\n";
  static const String vendorAlertMsg    = "\nMTN VENDOR ALERT IS A FEATURE THAT ENABLES MTN VENDORS AND BUSINESSES TO ADD EMERGENCY PHONE NUMBERS OF PEOPLE NEAR OR CLOSE TO THEIR VENDOR SHOP OR BUSINESS. \n\nIN CASE OF ANY ROBBERY ATTACK, THESE PEOPLE WILL BE ALERTED VIA TEXT MESSAGE ALERT,TO COME TO THEIR AID WITH REINFORCEMENT,ALERT WILL ALSO APPEAR ON MELERAPP NEIGHBORHOOD WATCH PAGE(IN THE AREA THE VENDOR SHOP IS LOCATED FOR REINFORCEMENT) \n\n ONCE THE MTN VENDOR ALERT IS SETUP,A PANIC BUTTON WILL SHOW UP ON THE NEWSFEED.\n\n WHEN THERE IS A ROBBERY ATTACK MTN VENDORS SHOULD CLICK THE PANIC BUTTON ON THE NEWSFEED FOR REINFORCEMENT\n";
  static const String melerUsers        = "\nMelerApp users at the location you select will be alerted on the neighborhood watch page whenever you click the panic button\n";
  static const String emergencyAlertNote ="Add up to 10 people's phone number. In case of an emergency eg. Robbery, these people will be notified via text message and Phone call Alert to bring reinforcement. \n\nThese people must be in close proximity to your vendor shop or business";
  static const String introText          ="MTN VENDOR ALERT ENABLES MTN VENDORS AND BUSINESSES TO ADD EMERGENCY PHONE NUMBERS OF PEOPLE NEAR OR CLOSE TO THEIR VENDOR SHOP OR BUSINESSES.\n\nIN CASE OF ANY ROBBERY ATTACK, THESE PEOPLE WILL BE ALERTED VIA TEXT MESSAGE ALERT OR PHONE CALL,TO COME TO THEIR AIDE WITH REINFORCEMENT,ALERT WILL ALSO APPEAR ON MELERAPP NEIGHBORHOOD WATCH PAGE(IN THE AREA THE VENDOR SHOP OR BUSINESS IS LOCATED FOR REINFORCEMENT) \n\nONCE THE MTN VENDOR ALERT IS SETUP,A PANIC BUTTON WILL SHOW UP ON THE NEWSFEED. WHENEVER THERE IS A ROBBERY ATTACK USER'S SHOULD CLICK THE PANIC BUTTON ON THE NEWSFEED FOR REINFORCEMENT";

  void toastSuccessNotification(
      String msg,
      ) {
    Fluttertoast.showToast(
        msg: '${msg}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void toastFailedNotification(
      String msg,
      ) {
    Fluttertoast.showToast(
        msg: '${msg}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void snackBarNotification(String msg, BuildContext cxt) {
    ScaffoldMessenger.of(cxt).showSnackBar(SnackBar(content: Text(msg)));
  }

  void alertDialogTitle(String title, String msg, BuildContext cxt) {
    showDialog(
        context: cxt,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              TextButton(
                child: Text("Okay"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void alertDialogNoTitle(String msg, BuildContext cxt) {
    showDialog(
        context: cxt,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(msg),
            actions: [
              TextButton(
                child: Text("Okay"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void redButtonDialog(String msg, BuildContext cxt) {
    showDialog(
        context: cxt,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(msg),
            actions: [
              ElevatedButton(
                child: Text('GOT IT', style: TextStyle(
                    color: Colors.white),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    textStyle: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }

  void progressDialog(String msg, BuildContext cxt) {
    SimpleFontelicoProgressDialog progressDialog =
    SimpleFontelicoProgressDialog(context: cxt, barrierDimisable: true);
    progressDialog.show(
      message: msg,
    );
  }



  void flushBar(String title, String msg, BuildContext cxt) {

    switch(title) {
      case "Success":
        {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
            titleText: Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
            messageText: Text(msg,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
          ).show(cxt);
        }
        break;


      case "Error":
        {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            titleText: Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
            messageText: Text(msg,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
          ).show(cxt);
        }
        break;


      case "Warning":
        {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
            titleText: Text("Oops",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
            messageText: Text(msg,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
          ).show(cxt);
        }
        break;
    }

  }





}
