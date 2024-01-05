class ApiUrlContainer{

  //static const String baseUrl = "http://192.168.10.18:3000/api/";
  //static const String baseUrl = "http://134.209.188.175:3000/api/";
  //static const String baseUrl = "http://165.22.118.95:3000/api/";
  static const String baseUrl = "http://resid-plus.com/api/";

  //SignIn
  static const String signInEndPoint = "users/signin";
  //SignUp
  static const String signUpEndPoint = "users/signup";
  static const String verifyEmailEndPoint = "users/verify?requestType=verifyEmail";
  static const String resendVerifyEmailEndPoint = "users/resend-onetime-code?requestType=verifyEmail";
  //Forget Password
  static const String forgetPasswordEndPoint = "users/forget/password";
  static const String otpEndPoint = "users/verify";
  static const String resendOtpEndPoint = "users/resend-onetime-code";
  static const String resetPasswordEndPoint = "users/reset/password";

  static const String profile = "users";
  static const String bookings = "bookings";
  static const String favourites = "favourites";
  static const String aboutUs = "about-us";
  static const String termsCondition = "terms-and-conditions";
  static const String supports = "supports";
  static const String faqs = "faqs";
  //home
  static const String popularHotelEndPoint = "residences?category=654f3a6c1c59a501bc450461&requestType=";
  static const String nearbyResidenceEndPoint = "residences?category=654f3a6c1c59a501bc450462&requestType=";
  static const String lakefrontPersonalHouseEndPoint = "residences?category=654f3a6c1c59a501bc450463&requestType=";
  //add Favorite
  static const String addFavoriteEndPoint = "favourites";
  //Search
  static const String searchResidenceEndPoint = "residences";
  static const String getReviewEndPoint = "reviews/";
  static const String bookingEndPoint = "bookings?bookingTypes=confirmed";
  static const String changePasswordEndPoint = "users";
  static const String amountCalculationEndPoint = "bookings/calculate-time-and-amount";
  static const String addPaymentEndPoint = "payments";
  static const String deleteResidenceEndPoint = "bookings/";
  static const String historyEndPoint = "bookings?bookingTypes=history";
  static const String deleteHistoryEndPoint = "bookings/history/";
  static const String reviewEndPoint = "reviews/";
  static const String postReviewEndPoint = "reviews";
  static const String notificationEndPoint="notifications";

  static const String allHotelEndPoint = "residences";
  static const String allResidenceEndPoint = "residences";
  static const String allPersonalHouseEndPoint = "residences";
}