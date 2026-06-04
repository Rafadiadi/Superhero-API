import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDisplayName extends StatefulWidget {
  static const String id = 'userdisplayname_screen';

  const UserDisplayName({super.key});

  @override
  State<UserDisplayName> createState() => _UserDisplayNameState();
}

class _UserDisplayNameState extends State<UserDisplayName> {
  final _auth = FirebaseAuth.instance;
  User? _activeUser;
  dynamic _setDisplayName;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _activeUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Set Your Profile Name',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40.0),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Profile Name',
                  ),
                  onChanged: (value) {
                    _setDisplayName = value;
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Back'),
                    ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null && _setDisplayName != null) {
                              await user.updateDisplayName(_setDisplayName);
                            }
                            if (!mounted) return;
                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: const Text('Submit'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
