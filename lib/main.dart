import 'package:flutter/material.dart';
import 'package:rebuild_demo/consumer_provider.dart';
import 'package:rebuild_demo/inherited_widget_example.dart';
import 'package:rebuild_demo/stateless_widget_example.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

// print toggles
const text = true;
const deeplyNested = true;
const inheritedWidget = true;
const stateless = true;
const counterModelConstructor = true;


// quick setup for tabs
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: PrintingText('Rebuild Test'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Plain Stateless Widget',),
              Tab(text: 'Inherited Widget',),
              Tab(text: 'Consumer vs. Provider.of(context)',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StatelessWidgetExample(),
            InheritedWidgetExample(),
            ConsumerProviderExample(),
          ],
        ),
      ),
    );
  }
}

