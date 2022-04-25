class ApiConstants {
  //static const BASE_URL = 'http://192.168.43.36:8000';
  //static const RBB_URL='http://api.leadpayroll.com:8000';
  //static const HEROKU_URL = 'https://studylens.herokuapp.com';
  static const BASE_URL = 'http://api.leadpayroll.com:8000';
  static const TIME_OUT = 300;
  // Account creation and Login
  static const CREATE_ACCOUNT = '/accounts/create';
  static const LOGIN = '/accounts/login';
  static const VERIFY = '/accounts/verify';

  // Payments
  static const PAY_WITH_CARD = '/payments/card';
  static const PAY_WITH_PIN = '/payments/pin';

  // Summarizer
  static const SUMMARIZER = '/summarizer/summarize';

  // Mathematics
  static const MATHEMATICS = '/mathematics/mathematics';

  // Chemistry
  static const CHEMISTRY = '/chemistry/chemistry';

  // Examples
  static const EXAMPLES = '/examples';

  // Gst
  static const GST = '/gst/gst';
}
