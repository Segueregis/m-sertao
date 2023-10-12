import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moto_sertao_flutter/authentication/signup_screen.dart';
import '../global/global.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_dialog.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  void validateForm(BuildContext context) {
    if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "O endereço de email não é válido.");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Senha é obrigatória.");
    } else {
      loginUsersNow(context);
    }
  }

  Future<void> loginUsersNow(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return  ProgressDialog(message: "Processando ... Por favor aguarde...",);
      },
    );

    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      );

      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("users");
        DataSnapshot driverKey = (await driversRef.child(firebaseUser.uid).once()) as DataSnapshot;

        if (driverKey.value != null) {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login bem-Sucedido.");
          Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
        } else {
          Fluttertoast.showToast(msg: "Não existe nenhum registro com este e-mail.");
          FirebaseAuth.instance.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Ocorreu um erro durante o login.");
      }
    } catch (error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: $error");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color(0xfff9c900),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 200.0,
                ),
                Container(
                  width: 250.0,
                  height: 150.0,
                  margin: const EdgeInsets.only(top: 50.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Image(
                   image: AssetImage("images/logo_moto_amarela.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: 450,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: emailTextEditingController,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        labelText: 'Senha',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Esqueceu sua Senha?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xff281537),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xfff9c900),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          validateForm(context);
                        },
                        child: const Text(
                          'ENTRAR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        "Não tem uma conta? Cadastre-se aqui",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) => const SignUpScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}