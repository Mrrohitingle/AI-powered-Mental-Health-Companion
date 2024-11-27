import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../welcome_page.dart';
import '../doctor_home.dart'; // Ensure this file is created for the doctor's dashboard

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "", password = "";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // Attempt to sign in with Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        // Get the user's Firestore document by UID
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          String role = userDoc['role']; // Ensure `role` exists in the document
          String userName = userDoc['name'];

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Login Successful",
              style: TextStyle(fontSize: 20.0),
            ),
          ));

          if (role == 'doctor') {
            // Navigate to DoctorHomePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorHomePage(),
              ),
            );
          } else {
            // Navigate to WelcomePage for regular users
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomePage(),
              ),
            );
          }
        } else {
          // No user document found in Firestore
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "User data not found in the database",
              style: TextStyle(fontSize: 20.0),
            ),
          ));
        }
      } on FirebaseAuthException catch (e) {
        // Handle Firebase Authentication errors
        String errorMsg;
        if (e.code == 'user-not-found') {
          errorMsg = "Email not registered";
        } else if (e.code == 'wrong-password') {
          errorMsg = "Invalid password";
        } else {
          errorMsg = "Login failed. Please try again";
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            errorMsg,
            style: TextStyle(fontSize: 20.0),
          ),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Please enter email and password",
          style: TextStyle(fontSize: 20.0),
        ),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Image.asset("images/account.png"),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF498aa2),
                      Color(0xFF377b94),
                      Color(0xFF81b7cf),
                      Color(0xFF81b7cf),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.5),
                        ),
                      ),
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30.0),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.5),
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                email = emailController.text;
                                password = passwordController.text;
                              });
                              signIn();
                            },
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(60),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xFF4C7296),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
