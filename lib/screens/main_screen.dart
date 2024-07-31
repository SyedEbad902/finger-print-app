import 'package:finger_print_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  checkAuth() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    print(isAvailable);
    if (isAvailable) {
      bool result = await auth.authenticate(
          localizedReason: "Scan your Finger print to proceed");
      if (result) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => HomePage())));
      } else {
        print("permission denied");
      }
    } else {}
  }

  bool _isClick = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login Page",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 65,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isClick = !_isClick;
              });
              provider.setTheme();
            },
            icon: Icon(
              _isClick ? Icons.light_mode : Icons.dark_mode,
              size: 30,
            ),
            color: _isClick ? Colors.white : Colors.black,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(
          //   height: 80,
          // ),
          // Center(
          //     child: Text(
          //   "Login",
          //   style: TextStyle(
          //     fontSize: 30,
          //     fontWeight: FontWeight.bold,
          //   ),
          // )),
          SizedBox(
            height: 50,
          ),
          Center(
              child: Text(
            "Finger Print Auth",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )),
          Center(
              child: Text(
            "Scan your finger to proceed to \n                   application",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
          )),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                checkAuth();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(117, 201, 253, 11),
                  foregroundColor: Colors.white),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Authenticate",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
