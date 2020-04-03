import 'package:flutter/material.dart';
import 'package:rider/Profile.dart';

import 'Home.dart';
import 'Settings.dart';

class MyTabbedPage extends StatefulWidget {
  var user;
  MyTabbedPage({ Key key, this.user }) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState(user: user);
}

class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
  var user;
  _MyTabbedPageState({Key key, @required this.user});

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Home'),
    Tab(text: 'profile'),
    Tab(text: 'settings',)
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }



 @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
          child: Scaffold(
            body:  TabBarView(
                children: [
                Home(user: user),
                Profile(user: user),
                Settings()
              ]
              ),
            bottomNavigationBar: 
            Container(
              height: 95.0,
              child: TabBar(
                indicatorColor: Colors.white,
                labelColor: Color(0xffffcc00),
                unselectedLabelColor: Colors.grey,
                tabs: 
              [
                Tab(icon: Icon(Icons.home,size:40, ),
              ),
                Tab(icon: Icon(Icons.account_circle,size:40,),
              ),
                Tab(icon: Icon(Icons.settings,size:40,),
              )
              ],
              // labelColor: Colors.grey 
              ),
            ),
       
        
      ),
      
    );
  }
}