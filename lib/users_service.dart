import 'dart:convert';
import 'users.dart';
import 'package:http/http.dart' as http;
// Service class for fetching user data from a remote API
class UserService {
  // Base URL for the API endpoint
  static const String _baseUrl = 'https://dummyjson.com/users';
  /**
   * Fetches a list of users from the API.
   * Parameters:
   * - [limit]: Number of users to fetch (default is 10).
   * - [skip]: Number of users to skip (default is 0).
   */
  Future<List<User>> fetchUsers({int limit = 10, int skip = 0}) async {
    // Construct the URL with query parameters for pagination
    final response = await http.get(Uri.parse('$_baseUrl?limit=$limit&skip=$skip'));
    // Check if the HTTP request was successful
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['users'];
      // Map JSON data to a list of User objects
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      // Throw an exception if the request failed
      throw Exception('Employees Detail Not Available....');
    }
  }
}
