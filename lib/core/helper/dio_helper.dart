import 'package:dio/dio.dart';

class DioHelper {
  static String getErrorMessage(dynamic e) {
    if (e is DioException) {
      if (e.response != null) {
        if (e.response!.statusCode == 401 || e.response!.statusCode == 403) {
          return "Session expired or unauthorized. Please login again.";
        }
        
        final data = e.response!.data;
        if (data is Map && data.containsKey('message') && data['message'] != null && data['message'].toString().isNotEmpty) {
          return data['message'].toString();
        }
        
        return "Server Error: ${e.response!.statusCode}";
      } else if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        return "Connection timed out. Please check your internet.";
      } else if (e.type == DioExceptionType.connectionError) {
        return "No internet connection.";
      }
      return "Network error occurred.";
    }
    return e.toString();
  }
}
