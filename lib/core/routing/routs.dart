class Routs {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String verfy = '/verfy';
  static const String peformance = '/peformance';

  static const String category = '/category';
  static const String rewards = '/rewards';
  static const String profile = '/profile';
  static const String details = '/details';
  static const String cart = '/cart';
  static const String settings = '/settings';

  static const String checkout = '/checkout';
  static const String forgetPassword = '/forgetPassword';
  static const String resetPassword = '/resetPassword';
  static const String completeProfile = '/completeProfile';
  static const String search = '/search';
  static const String categoryProducts = '/categoryProducts';
  static const String favorite = '/favorite';
  static const String financialIncentives = '/financialIncentives';
  static const String cleaningRecommendation = '/cleaningRecommendation';
  static const String alert = '/alert';
  static const String chat = '/chat';
  static const String expectedVsActualScreen = '/expectedVsActualScreen';
  static const String rootAnalysisScreen = '/rootAnalysisScreen';
  static const String anomalyDetectionScreen = '/anomalyDetectionScreen';

  // Bottom nav routes
  static const String menu = '/menu';
  static const String favorites = '/favorites';
  static const String orders = '/orders';
  static const String support = '/support';
}

class ApiConstant {
  static const String baseUrl = "https://tayf.azurewebsites.net/api/";

  //extenal api keys

  static const String getWeatherData =
      "http://api.weatherapi.com/v1/current.json?key=93fde835487341a09c8152046252604&q=cityName&aqi=no";
  static const String aihatBaseUrl = "http://13.53.182.194:8000/api";

  static const String getAlerts =
      "https://tayfbackend-production.up.railway.app/api/v1/Alerts";
}
