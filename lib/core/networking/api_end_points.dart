class ApiEndPoints {
  ApiEndPoints._();
  // Base URL
  static const String apiBaseUrl = 'https://vcare.integration25.com/api/';

  // Authentication
  static const String loginEndpoint = 'auth/login';
  static const String signUpEndpoint = 'auth/register';
  static const String logoutEndpoint = 'auth/logout';

  // Home
  static const String homeSpecializationEndPoint = 'home/index';

  // Specialization
  static const String allSpecializationEndpoint = 'specialization/index';
  static const String showSpecialtyEndpoint = 'specialization/show/';

  // Doctors
  static const String allDoctorsEndPoint = 'doctor/index';
  static const String showDoctorDetailsEndPoint = 'doctor/show/';
  static const String filterDoctorsEndPoint = 'doctor/doctor-filter?';
  static const String searchDoctorsEndPoint = 'doctor/doctor-search?name=';

  // cities
  static const String citiesEndPoint = 'city/index';
}
