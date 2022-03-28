
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

 GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

 PersistentBottomSheetController? _controller;
void showEndDrawer(){
  key.currentState!.openEndDrawer();
}



void showBottomSheet(){
  if(_controller== null){
    key.currentState!.showBottomSheet((context) => Container(height: 150,child: Column(mainAxisSize: MainAxisSize.min,children:  [const ListTile(title: Text('сумма'),leading: Icon(Icons.credit_card), trailing: Text('200p'),),
        TextButton(onPressed: (){}, child: const Text('оплатить'))],),));
  }else {
    _controller!.close();
    _controller = null;
  }
}


class TabItem{
  String? title;
  Icon icon;
  TabItem({this.title,required this.icon});
}

final List<TabItem> _tabBar=[
  TabItem(title:'Photo',icon: const Icon(Icons.home)),
  TabItem(title:'Chat',icon: const Icon(Icons.chat)),
  TabItem(title:'Albums',icon: const Icon(Icons.album)),
];


class _MyHomePageState extends State<MyHomePage>  with TickerProviderStateMixin{
 
  TabController? _tabController;
     int _currentTabIndex =0;
    @override
    void initState(){
      super.initState();
      _tabController= TabController(length: _tabBar.length,vsync: this);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: TabBarView(
          controller:_tabController,
          children: [
          Container(color: Colors.blueGrey,
          child:const Center(child: Text('грей'),)),

          Container(color: Colors.yellow,
          child: const Center(child: Text('елоу'),),),

          Container(color: Colors.deepPurple,
          child: const Center(child: Text('перпл'),),)
        ],),

      key: key,

      appBar: AppBar(
        title: const Text("не прошло и года"),
        actions: [IconButton(onPressed: ()=>showEndDrawer(), icon: const Icon(Icons.person))]
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {});
        },
        currentIndex: _currentTabIndex,
        items: [for(final item in _tabBar)
        BottomNavigationBarItem(icon: item.icon,label: item.title)],
      ),

      drawer: Drawer(
        child:  Column(children:  [
         Expanded(flex: 5, child: Column( children: const [
          DrawerHeader(child: CircleAvatar(
            radius: 75,
            backgroundImage: NetworkImage("https://www.fd.ru/images/articles/159015/04.png"),
          )),ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('Files'),
            leading: Icon(Icons.file_copy),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(title: Text('Images'),
            leading: Icon(Icons.image),
            trailing: Icon(Icons.arrow_forward_ios),),
        ],), ),
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [ElevatedButton(onPressed: (){}, child: const Text('Выход')),
              ElevatedButton(onPressed: (){}, child: const Text('Регистрация'))],
            ),],)
      ),

      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
           children: const [DrawerHeader(child: CircleAvatar(radius: 55, backgroundImage: NetworkImage('https://www.fd.ru/images/articles/159015/04.png'),)),
           Text('Иван Иванов')]
        ),),

         floatingActionButton: const FloatingActionButton(onPressed: showBottomSheet, child: Icon(Icons.add),),


    );
  }
}
