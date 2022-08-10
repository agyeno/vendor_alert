import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import '../model/Model_Contact.dart';
import '../utils/ApiUrl.dart';
import '../utils/Helper.dart';
import 'package:http/http.dart' as http;
import 'Vendor_Add_Emergency_Number.dart';


class Vendor_View_Emergency_Number extends StatefulWidget {
  const Vendor_View_Emergency_Number({Key? key}) : super(key: key);

  @override
  State<Vendor_View_Emergency_Number> createState() => _Vendor_View_Emergency_NumberState();
}

class _Vendor_View_Emergency_NumberState extends State<Vendor_View_Emergency_Number> {

  int apiStatusCode = 0;
  String apiMessage = "";
  final Helper helper = new Helper();

  String userId = "";

  void initState() {
    super.initState();
    _loadSharedPref();
  }

  _loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('userId') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(
        color: Colors.white, // <-- SEE HERE
      ),title: Text('Emergency Contacts',style: TextStyle(color: Colors.white),), elevation: 4.0),
      /*body: SingleChildScrollView(
        child: _userInterface(),
      ),*/
      //backgroundColor: Colors.green.shade200,
      body: FutureBuilder(
        future: _getContacts(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${Helper.noData}"));
          } else if (data.hasData) {
            var items = data.data as List<Model_Contact>;
            return ListView.builder(
                itemCount: items == null ? 0 : items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[


                          SizedBox(height: 5),
                          new Card(
                            child: new Column(
                              children: <Widget>[
                                ListTile(
                                  trailing: const Icon(Icons.cancel),
                                  title: Text(items[index].emergencyNumber.toString(),),
                                  onTap: () {
                                    showDialog(context: context, builder: (BuildContext context) => deleteAlertDialog(items[index].emergencyNumber.toString()));
                                  },
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Vendor_Add_Emergency_Number())),

        },
        label: const Text('Add Number'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }




  Future<void> _deleteContact(String contactId) async {
    // final ConnectivityResult result = await Connectivity().checkConnectivity();
    // if (result != ConnectivityResult.wifi &&
    //     result != ConnectivityResult.mobile) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(ApiUrl.noInternet)));
    //   return;
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');

    SimpleFontelicoProgressDialog progressDialog =
    SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    progressDialog.show(
      message: "Loading ...",
    );

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${ApiUrl.APIusername}:${ApiUrl.APIpassword}'));
    final response = await http
        .post(Uri.parse(ApiUrl.manageContacts),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$basicAuth',
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'action': 'delete',
          'phoneNumber': contactId,
        }))
        .catchError((err) {
      progressDialog.hide();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(Helper.errorMessageSomethingWentWrong)));
    });

    if (response.statusCode != 200) {
      progressDialog.hide();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(Helper.errorMessageSomethingWentWrong)));
    }

    final responseJson = jsonDecode(response.body);
    apiStatusCode = responseJson["statusCode"].toInt();
    apiMessage = responseJson["message"].toString();

    if (apiStatusCode == 200) {
      progressDialog.hide();
      setState(() {
     _getContacts();
      });
    } else if (apiStatusCode != 200) {
      progressDialog.hide();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(apiMessage)));
    }
  }






  Future<List<Model_Contact>> _getContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${ApiUrl.APIusername}:${ApiUrl.APIpassword}'));
    final response = await http
        .post(Uri.parse(ApiUrl.manageContacts),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$basicAuth',
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'action': 'view'
        }))
        .catchError((err) {
      //progressDialog.hide();
      showDialog(
          context: context,
          builder: (BuildContext context) => getAlertDialog(
              '${Helper.errorMessageOops}',
              '${Helper.errorMessageSomethingWentWrong}',
              context));
    });

    if (response.statusCode == 200) {
      List responseList = json.decode(response.body)["response"];
      return responseList.map((data) => Model_Contact.fromJson(data)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  AlertDialog getAlertDialog(title, content, context) {
    return AlertDialog(
      title: Text('${title}'),
      content: Text('${content}'),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }





  AlertDialog deleteAlertDialog(String contactId) {
    return AlertDialog(
      content: Text('Do you want to delete this contact ?'),
      actions: <Widget>[
        TextButton(
          child: Text('YES'),
          onPressed: () {
            Navigator.of(context).pop();
            _deleteContact(contactId);
          },
        ),
        TextButton(
          child: Text('NO'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}


