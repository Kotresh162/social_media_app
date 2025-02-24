import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/api/app_service.dart';
import 'package:social_media_app/models/user_model.dart';

class UserScreen extends StatefulWidget {
  final int id;

  const UserScreen({super.key, required this.id});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final ApiService _apiService = ApiService();
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  Future<void> loadUserDetails() async {
    try {
      UserModel fetchedUser = await _apiService.fetchUserDetails(widget.id);
      setState(() {
        user = fetchedUser;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar("Error", "Failed to load user details.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Profile")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
              ? const Center(child: Text("User not found"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "https://via.placeholder.com/150", // Placeholder profile image
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user!.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("@${user!.username}", style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        children: [
                          Chip(label: Text(user!.company.name)),
                          Chip(label: Text(user!.company.catchPhrase)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(user!.email),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(user!.phone),
                      ),
                      ListTile(
                        leading: const Icon(Icons.web),
                        title: Text(user!.website),
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text("Address", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        "${user!.address.street}, ${user!.address.suite}, ${user!.address.city}, ${user!.address.zipcode}",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
    );
  }
}
