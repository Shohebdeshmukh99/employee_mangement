import 'package:flutter/material.dart';

import '../model/employee.dart';
import '../services/employeeservice.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<List<Employee>> _employeeFuture;
  List<Employee> _allEmployees = [];
  List<Employee> _filteredEmployees = [];

  final TextEditingController _searchController = TextEditingController();

  void _search(String query) {
    setState(() {
      _filteredEmployees = _allEmployees
          .where((emp) => emp.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _employeeFuture = EmployeeService.fetchEmployees();
    _employeeFuture.then((employees) {
      setState(() {
        _allEmployees = employees;
        _filteredEmployees = employees;
      });
    });

    _searchController.addListener(() {
      _search(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Employee List',style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white),),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded),
                      labelText: 'Search Employee.... ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _filteredEmployees.isEmpty
                    ? Center(child: Text('No employees found.'))
                    : ListView.builder(
                  itemCount: _filteredEmployees.length,
                  itemBuilder: (context, index) {
                    final emp = _filteredEmployees[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(emp.avatar),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  emp.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(emp.position ?? 'No Position',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '${emp.department ?? 'No Department'}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
              right: 20,
              bottom: 20,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text("Working"),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      Text("Add Employee", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              )

          )
        ],
      ),
    );
  }
}