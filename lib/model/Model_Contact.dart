
class Model_Contact {

  String? userId;
  String? emergencyNumber;
  String? merchantName;
  String? merchantNumber;
  String? dateCreated;


  Model_Contact({this.userId, this.emergencyNumber, this.merchantName, this.merchantNumber, this.dateCreated});


  Model_Contact.fromJson(Map<String,dynamic> json){

    userId    = json['UserId'];
    emergencyNumber  = json['EmergencyNumber'];
    merchantName    = json['MerchantName'];
    merchantNumber      = json['MerchantNumber'];
    dateCreated  = json['DateCreated'];


  }





}