import 'package:flutter/material.dart';
import 'package:rider/Profile.dart';

import 'Home.dart';
import 'Settings.dart';

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({ Key key }) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
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
            body: TabBarView(children: [
              Home(),
              Profile(),
              Settings()

            ]),
            bottomNavigationBar: TabBar(tabs: 
            [
              Tab(icon: Icon(Icons.home,size:35,),
            child: Text('Home'),),
              Tab(icon: Icon(Icons.account_circle,size:35,),
            child: Text('Records')),
              Tab(icon: Icon(Icons.settings,size:35,),
            child: Text('Settings'))
            ],
            labelColor: Colors.black 
            ),
       
        
      ),
      
    );
  }
}