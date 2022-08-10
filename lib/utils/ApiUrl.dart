class ApiUrl {


//Test
//     static const String Auth            = "711c73f64afdce07bA02";
//     static const String MainIP          = "https://dev.vtomhub.tech/vtomPay/api/user/";
//     static const String APIusername     = "vtomPAY";
//     static const String APIpassword     = "password";
//     static const String hashedSignature = "UlGwff+WSCn";


//Live
  static const String Auth            = "711c73f64afdce07bA01";
  static const String MainIP          = "http://cm.vtomhub.tech/vendorAlert/api/";
  static const String APIusername     = "vtomPAY";
  static const String APIpassword     = "DU5S9he3ltbMzqui";
  static const String hashedSignature = "UlGwff+WSCn";



  static const String adminViewAll         = MainIP + "admin/viewAll";
  static const String login                = MainIP + "user/login";
  static const String register             = MainIP + "user/register";
  static const String getOTC               = MainIP + "user/getOTC";
  static const String verifyOTC            = MainIP + "user/verifyOTC";
  static const String numberVerification   = MainIP + "user/numberVerification";
  static const String changeNumber         = MainIP + "user/changeNumber";
  static const String manageUserDetails    = MainIP + "user/manageUserDetails";
  static const String manageContacts       = MainIP + "user/manageContacts";
  static const String manageAlerts         = MainIP + "user/manageAlerts";
  static const String adminManageCustomer  = MainIP + "admin/manageCustomer";
  static const String adminManageFood      = MainIP + "admin/manageFood";
  static const String adminManageOrder     = MainIP + "admin/manageOrders";


  static const String waiterActivities     = MainIP + "user/waiterActivities";
  static const String cookActivities       = MainIP + "user/cookActivities";
  static const String customerActivites    = MainIP + "user/customerActivites";


}