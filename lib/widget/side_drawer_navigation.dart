import 'package:bdelect/controller/user_controller.dart';
import 'package:bdelect/screen/Authform/login_screen.dart';
import 'package:bdelect/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideDrawerNavigation extends StatefulWidget {
  @override
  _SideDrawerNavigationState createState() => _SideDrawerNavigationState();
}

class _SideDrawerNavigationState extends State<SideDrawerNavigation> {
  final UserController userController = Get.find<UserController>();

  _getUser() async {}

  void logOut() async {}

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Container(
          color: Colors.white54,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountEmail:
                    Text(''), // keep blank text because email is required
                accountName: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        // child: Image.asset("assets/bdlogo.png"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ទូរស័ព្ទ៖​ 012 555 720',
                            style: TextStyle(fontFamily: "khmer"),
                          ),
                          Text('Page: BD Accessories'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              Divider(
                height: 3,
                color: Colors.redAccent,
              ),
              Divider(
                height: 3,
                color: Colors.redAccent,
              ),
              Container(
                width: double.infinity,
                height: 200,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        // leading: Image.asset(
                        //     'assets/Wing.png'), //Icon(Icons.send,color: Colors.blue,),
                        title: Text(
                          '092 57 57 16',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.lime[600],
                          ),
                        ),
                      ),
                      ListTile(
                        // leading: Image.asset('assets/aba.png'),
                        // Icon(
                        //   Icons.send,
                        //   color: Colors.blue, ),
                        title: Text(
                          '000 630 499',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue[900],
                          ),
                        ),
                      ),
                      ListTile(
                        // leading: Image.asset('assets/acleda.png'),
                        // Icon(
                        //   Icons.send,
                        //   color: Colors.blue,
                        // ),
                        title: Text(
                          '092 57 57 16',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              userController.box.read("logged") != null
                  ? InkWell(
                      onTap: () {
                        userController.getLogOut();
                        Get.offAllNamed(HomeView.routName);
                      },
                      child: ListTile(
                        title: Text(
                          'Logout',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        leading: Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Get.toNamed(LoginScreen.routeName);
                      },
                      child: ListTile(
                        title: Text(
                          'Login',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        leading: Icon(
                          Icons.login,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
