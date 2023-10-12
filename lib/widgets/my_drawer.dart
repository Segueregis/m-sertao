import 'package:flutter/material.dart';

import '../global/global.dart';
import '../splashScreen/splash_screen.dart';


class MyDrawer extends StatefulWidget
{
  final String? name;
  final String? email;

  const MyDrawer({super.key, this.name, this.email});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}



class _MyDrawerState extends State<MyDrawer>
{
  @override
  Widget build(BuildContext context)
  {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          Container(
            height: 165,
            color: Colors.black,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.grey),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),

                  const SizedBox(width: 16,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        widget.email.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const  SizedBox(height: 12.0,),

          //drawer body
          GestureDetector(
            onTap: ()
            {

            },
            child: const ListTile(
              leading: Icon(Icons.history, color: Colors.orange,),
              title: Text(
                "Historic",
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: ()
            {

            },
            child: const ListTile(
              leading: Icon(Icons.person, color: Colors.orange,),
              title: Text(
                "Perfil",
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: ()
            {

            },
            child: const ListTile(
              leading: Icon(Icons.info, color: Colors.blue,),
              title: Text(
                "Sobre",
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: ()
            {
              fAuth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
            },
            child: const ListTile(
              leading: Icon(Icons.logout, color: Colors.orange,),
              title: Text(
                "Sair",
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
