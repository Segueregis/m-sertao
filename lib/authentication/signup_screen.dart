import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_dialog.dart';
import 'login_screen.dart';



class SignUpScreen extends StatefulWidget
{
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen>
{
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  validateForm()
  {
    if(nameTextEditingController.text.length < 3)
    {
      Fluttertoast.showToast(msg: "name must be atleast 3 Characters.");
    }
    else if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    }
    else if(phoneTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Phone Number is required.");
    }
    else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "Password must be atleast 6 Characters.");
    }
    else
    {
      saveUserInfoNow();
    }
  }

  saveUserInfoNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processando, Por favor aguarde...",);
        }
    );

    final User? firebaseUser = (
      await fAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      ).catchError((msg){
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error: $msg");
      })
    ).user;

    if(firebaseUser != null)
    {
      Map userMap =
      {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      DatabaseReference reference = FirebaseDatabase.instance.ref().child("users");
      reference.child(firebaseUser.uid).set(userMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "A conta foi criada.");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "A conta não foi criada.");
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
            color: const Color(0xfff9c900), // Cor de fundo sólida (mostarda)
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 200.0, // Height of the background container
                ),
                Container(
                  width: 250.0,
                  height: 150.0, // Height of the image
                  margin: const EdgeInsets.only(top: 50.0), // Top space
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                  child: const Image(
                    image: AssetImage("images/logo_moto_amarela.png"),
                    fit: BoxFit.cover, // Fit the image within the container
                  ),
                ),
              ],
            ),
          ),
         Padding(
          padding: const EdgeInsets.only(top: 200.0),
           child: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(40),
               color: Colors.white,
             ),
             height: 500,
             width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 18),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [

                   TextField(
                     controller: nameTextEditingController,
                     keyboardType: TextInputType.text,
                     style: const TextStyle(
                       color: Colors.grey,
                       fontWeight: FontWeight.bold, // Adicione essa linha para definir a fonte em negrito
                     ),
                     decoration: const InputDecoration(
                       labelText: "Nome",
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                       ),
                       focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                       ),
                       hintStyle: TextStyle(
                         color: Colors.grey,
                         fontSize: 15,
                       ),
                       labelStyle: TextStyle(
                         color: Colors.grey,
                         fontSize: 18,
                       ),
                     ),
                   ),

                   TextField(
                     controller: emailTextEditingController,
                     keyboardType: TextInputType.text,
                     style: const TextStyle(
                       color: Colors.grey,
                       fontWeight: FontWeight.bold, // Adicione essa linha para definir a fonte em negrito
                     ),
                     decoration: const InputDecoration(
                       labelText: "Email",
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                       ),
                       focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                       ),
                       hintStyle: TextStyle(
                         color: Colors.grey,
                         fontSize: 15,
                       ),
                       labelStyle: TextStyle(
                         color: Colors.grey,
                         fontSize: 18,
                       ),
                     ),
                   ),

                   TextField(
                     controller: phoneTextEditingController,
                     keyboardType: TextInputType.text,
                     style: const TextStyle(
                       color: Colors.grey,
                       fontWeight: FontWeight.bold, // Adicione essa linha para definir a fonte em negrito
                     ),
                     decoration: const InputDecoration(
                       labelText: "Telefone",
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                       ),
                       focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                       ),
                       hintStyle: TextStyle(
                         color: Colors.grey,
                         fontSize: 15,
                       ),
                       labelStyle: TextStyle(
                         color: Colors.grey,
                         fontSize: 18,
                       ),
                     ),
                   ),

                   TextField(
                     controller: passwordTextEditingController,
                     keyboardType: TextInputType.text,
                     obscureText: true,
                     style: const TextStyle(
                       color: Colors.grey,
                       fontWeight: FontWeight.bold, // Adicione essa linha para definir a fonte em negrito
                     ),
                     decoration: const InputDecoration(
                       labelText: "Senha",
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                       ),
                       focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey),
                       ),
                       hintStyle: TextStyle(
                         color: Colors.grey,
                         fontSize: 15,
                       ),
                       labelStyle: TextStyle(
                         color: Colors.grey,
                         fontSize: 18,
                       ),
                     ),
                   ),


                   const SizedBox(height: 20,),

                 ElevatedButton(
                    onPressed: ()
                    {
                     validateForm();
                     },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfff9c900),

                      ),
                 child: const Text(
                  "Criar uma conta",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    ),
                  ),
                ),

                   InkWell(
                     onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
                     },
                     child: Container(
                       padding: const EdgeInsets.all(10.0),
                       decoration: BoxDecoration(
                         color: Colors.grey, // Cor de fundo do botão
                         borderRadius: BorderRadius.circular(20.0), // Define a forma arredondada do botão
                       ),
                       child: const Text("Já tem uma conta? Entre aqui",
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 15,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     ),
                   )

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
