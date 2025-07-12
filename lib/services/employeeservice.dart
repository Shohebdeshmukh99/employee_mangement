import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/employee.dart';

class EmployeeService {
  static const String url = 'https://669b3f09276e45187d34eb4e.mockapi.io/api/v1/employee';

  static Future<List<Employee>> fetchEmployees() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Map and filter if needed
      return data.map((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }
}