import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'users_service.dart';
import 'users.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final UserService _userService = UserService();
  final ScrollController _scrollController = ScrollController();
  List<User> _users = [];
  int _page = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchUsers();
      }
    });
  }

  Future<void> _fetchUsers() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    List<User> users = await _userService.fetchUsers(limit: 10, skip: _page * 10);
    setState(() {
      _users.addAll(users);
      _page++;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employees')),
      body: _users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: _scrollController,
        itemCount: _users.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _users.length) {
            return Center(child: CircularProgressIndicator());
          }
          User user = _users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.image),
            ),
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text('${user.age} years old, ${user.gender}\n${user.email}\n${user.phone}\n${user.state}, ${user.country}'),
          );
        },
      ),
    );
  }
}
