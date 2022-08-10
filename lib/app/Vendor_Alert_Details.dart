import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import '../utils/ApiUrl.dart';
import '../utils/Helper.dart';


class Vendor_Alert_Details extends StatefulWidget {
  const Vendor_Alert_Details({Key? key}) : super(key: key);

  @override
  State<Vendor_Alert_Details> createState() => _Vendor_Alert_DetailsState();
}

class _Vendor_Alert_DetailsState extends State<Vendor_Alert_Details> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController alertMsgController = TextEditingController();
  TextEditingController locationDescriptionController = TextEditingController();
  TextEditingController gpsAddressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String actor ="",vendorMsg = "";
  File? image;
  String base64Image = "";
  int apiStatusCode = 0 ;
  String apiMessage = "";
  final Helper helper = new Helper();

  @override
  void initState() {
    loadSharedPref();
    _doViewDetails();
    super.initState();
  }

  loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      actor = (prefs.getString('actor') ?? '');
      if(actor == "vendor"){
        vendorMsg = "vendor shop";
      } else if(actor == "non-vendor"){
        vendorMsg = "your business or house";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(
        color: Colors.white, // <-- SEE HERE
      ),
          title: Text('VENDOR ALERT DETAILS', style: TextStyle(
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


          SizedBox(height: 30),


          Text('First Name',style: new TextStyle(fontSize: 16.0)),
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: " ",
                fillColor: Colors.white70),
          ),

          SizedBox(height: 20),

          Text('Last Name',style: new TextStyle(fontSize: 16.0)),
          TextField(
            controller: lastNameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "",
                fillColor: Colors.white70),
          ),

          SizedBox(height: 20),

          Text('Alert Message',style: new TextStyle(fontSize: 16.0)),
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 4,//Normal textInputField will be displayed
            maxLines: 8,//
            controller: alertMsgController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Eg: I am being robbed at the moment. Kindly bring reinforcement and call the police",
                fillColor: Colors.white70),
          ),

          SizedBox(height: 20),

          Text('Location Description',style: new TextStyle(fontSize: 16.0)),
          TextField(
            controller: locationDescriptionController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Eg: Opp Kaneshie Fidelity Bank",
                fillColor: Colors.white70),
          ),

          SizedBox(height: 20),

          Text('Ghana Post GPS Address',style: new TextStyle(fontSize: 16.0)),
          TextField(
            controller: gpsAddressController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "GPS Address of your vendor shop",
                fillColor: Colors.white70),
          ),

          SizedBox(height: 20),

          Text('Phone Number',style: new TextStyle(fontSize: 16.0)),
          TextField(
            enableInteractiveSelection: false,
            readOnly: true,
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Enter Number",
                fillColor: Colors.white70),
          ),

          SizedBox(height: 20),

          Text('E-Mail Address',style: new TextStyle(fontSize: 16.0)),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Enter Email",
                fillColor: Colors.white70),
          ),

          SizedBox(height: 20),

          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(' Add ',style: new TextStyle(fontSize: 16.0)),
              SizedBox(width: 5), // give it width
              Text(vendorMsg,style: new TextStyle(fontSize: 16.0,  color: Colors.black)),
              SizedBox(width: 0), // give it width
              Text(' Images ',style: new TextStyle(fontSize: 16.0)),
            ],
          ),

          new Card(
            child: new Row(
              children: <Widget>[
                //new Image.network('https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
               GestureDetector(
                 child: Padding(
                  padding: new EdgeInsets.all(7.0),
                  child:  Icon(
                    Icons.photo,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
               onTap: () => {
                   _modalPopupDialog(context)
               },),

                GestureDetector(
                  child: Padding(
                    padding: new EdgeInsets.all(7.0),
                    child:  Icon(
                      Icons.photo,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () => {
                    _modalPopupDialog(context)
                  },),

                GestureDetector(
                  child: Padding(
                    padding: new EdgeInsets.all(7.0),
                    child:  Icon(
                      Icons.photo,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () => {
                    _modalPopupDialog(context)
                  },),


                GestureDetector(
                  child: Padding(
                    padding: new EdgeInsets.all(7.0),
                    child:  Icon(
                      Icons.photo,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () => {
                    _modalPopupDialog(context)
                  },),

              ],
            ),
          ),

          SizedBox(height: 20),

          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ElevatedButton(
              child: Text('Save', style: TextStyle(
                  color: Colors.white),),
              onPressed: () {
            _doUpdateDetails();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold)),
            ),
          ),

          SizedBox(height: 300),

        ],

      ),
    );
  }








  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        //_updateProfilePic();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }







  _modalPopupDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo_camera_back),
                title: new Text('Gallery upload'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Camera upload'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }









  Future<void> _doUpdateDetails() async{


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');


    if (firstNameController.text.toString().isEmpty){
      helper.flushBar("Warning", "Please provide your first name", context);
      return;
    }
    if (lastNameController.text.toString().isEmpty){
      helper.flushBar("Warning", "Please provide your last name", context);
      return;
    }
    if (alertMsgController.text.toString().isEmpty){
      helper.flushBar("Warning", "Please provide alert message", context);
      return;
    }


    SimpleFontelicoProgressDialog progressDialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  true);
    progressDialog.show(message: "Loading ...", );

    String basicAuth  = 'Basic '+base64Encode(utf8.encode('${ApiUrl.APIusername}:${ApiUrl.APIpassword}'));
    final response = await http.post(Uri.parse(ApiUrl.manageUserDetails),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$basicAuth',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'action':'update',
          'emailAddress': emailController.text.toString(),
          'firstName': firstNameController.text.toString(),
          'lastName': lastNameController.text.toString(),
          'alertMessage': alertMsgController.text.toString(),
          'location': locationDescriptionController.text.toString(),
          'gps': gpsAddressController.text.toString(),
          'image1': "",
          'image2': "",
          'image3': "",
          'image4': "",
         })

    ).catchError((err) {

      progressDialog.hide();
      helper.alertDialogTitle(Helper.errorMessageOops,Helper.errorMessageSomethingWentWrong, context);
    });


    if(response.statusCode != 200 ){
      progressDialog.hide();
      helper.alertDialogTitle(Helper.errorMessageOops,Helper.errorMessageSomethingWentWrong, context);
    }


    final responseJson  =  jsonDecode(response.body);
    apiStatusCode   =  responseJson["statusCode"].toInt();
    apiMessage      =  responseJson["message"].toString();



    if(apiStatusCode == 200 ){

      progressDialog.hide();
      helper.flushBar("Success", apiMessage, context);

      _doViewDetails();

    }
    else if(apiStatusCode != 200 )  {

      progressDialog.hide();
      helper.alertDialogNoTitle(apiMessage, context);
    }




  }











  Future<void> _doViewDetails() async{


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');




    SimpleFontelicoProgressDialog progressDialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  true);
    progressDialog.show(message: "Loading ...", );

    String basicAuth  = 'Basic '+base64Encode(utf8.encode('${ApiUrl.APIusername}:${ApiUrl.APIpassword}'));
    final response = await http.post(Uri.parse(ApiUrl.manageUserDetails),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$basicAuth',
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'action':'viewDetails'
        })

    ).catchError((err) {

      progressDialog.hide();
      helper.alertDialogTitle(Helper.errorMessageOops,Helper.errorMessageSomethingWentWrong, context);
    });


    if(response.statusCode != 200 ){
      progressDialog.hide();
      helper.alertDialogTitle(Helper.errorMessageOops,Helper.errorMessageSomethingWentWrong, context);
    }


    final responseJson  =  jsonDecode(response.body);
    apiStatusCode   =  responseJson["statusCode"].toInt();
    apiMessage      =  responseJson["message"].toString();



    if(apiStatusCode == 200 ){
      progressDialog.hide();
      setState(() {
        final responseJson  =  jsonDecode(response.body);
        String apiResponse  =  responseJson["response"].toString();
        String UserId =   responseJson["response"][0]["UserId"].toString();
        String MerchantName       =  responseJson["response"][0]["MerchantName"].toString();
        phoneNumberController.text    =  responseJson["response"][0]["MerchantNumber"].toString();
        emailController.text  =  responseJson["response"][0]["EmailAddress"].toString().replaceAll("null", "");
        firstNameController.text  =  responseJson["response"][0]["FirstName"].toString().replaceAll("null", "");
        lastNameController.text  =  responseJson["response"][0]["LastName"].toString().replaceAll("null", "");
        alertMsgController.text =  responseJson["response"][0]["AlertMessage"].toString().replaceAll("null", "");
        locationDescriptionController.text  =  responseJson["response"][0]["Location"].toString().replaceAll("null", "");
        gpsAddressController.text  =  responseJson["response"][0]["Gps"].toString().replaceAll("null", "");
        String Image1 =  responseJson["response"][0]["Image1"].toString();
        String Image2 =  responseJson["response"][0]["Image2"].toString();
        String Image3 =  responseJson["response"][0]["Image3"].toString();
        String Image4 =  responseJson["response"][0]["Image4"].toString();
        String DateCreated =  responseJson["response"][0]["DateCreated"].toString();

      });

    }
    else if(apiStatusCode != 200 )  {

      progressDialog.hide();
      helper.alertDialogNoTitle(apiMessage, context);
    }




  }

}