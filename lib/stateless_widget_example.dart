import 'package:flutter/material.dart';
import 'package:rebuild_demo/main.dart';

class StatelessWidgetExample extends StatefulWidget {
  @override
  _StatelessWidgetExampleState createState() => _StatelessWidgetExampleState();
}

class _StatelessWidgetExampleState extends State<StatelessWidgetExample> {

  var _index = 0;

  @override
  Widget build(BuildContext context) {
    print('build() called for StatelessWidgetExample');

    return Column(
      children: [
        Expanded(
          child: RaisedButton(
            child: PrintingText("setState()"),
            onPressed: () => setState(() => _index++),
          ),
        ),

        Expanded(
          child: Row(
            children: [
              Expanded(child: PrintingText("This stateless widget is always built with the value: 0")),
              Expanded(child: PrintOnRebuildStatelessWidget(index: 0, isConst: false,)),
            ],
          ),
        ),

        Expanded(
          child: Row(
            children: [
              Expanded(child: PrintingText("This stateless widget is const and always built with the value: 0")),
              Expanded(child: const PrintOnRebuildStatelessWidget(index: 0, isConst: true,)),
            ],
          ),
        ),

        Expanded(
          child: Row(
            children: [
              Expanded(child: PrintingText("This stateless widget is built with increasing values")),
              Expanded(child: PrintOnRebuildStatelessWidget(index: _index, isConst: false,)),
            ],
          ),
        ),

        Expanded(
          child: Row(
            children: [
              Expanded(child: PrintingText("This stateless widget is deeply nested")),
              Expanded(child: DeeplyNestedWidget(totalDepth: 10,)),
            ],
          ),
        ),

        Expanded(
          child: Row(
            children: [
              Expanded(child: PrintingText("This stateless widget is even more deeply nested (thank god its const)")),
              Expanded(child: const  DeeplyNestedWidget(totalDepth: 1000,)),
            ],
          ),
        ),


      ],
    );
  }
}

// Prints whenever it is rebuilt
class PrintOnRebuildStatelessWidget extends StatelessWidget {
  final int index;
  final bool isConst;

  const PrintOnRebuildStatelessWidget({Key key, this.index, this.isConst}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (stateless) print('build() called for PrintOnRebuildStatelessWidget(index: $index, const: $isConst)');
    return PrintingText('$index (const: $isConst)');
  }
}

class DeeplyNestedWidget extends StatelessWidget {

  final int totalDepth;
  final int currentDepth;

  const DeeplyNestedWidget({Key key, this.totalDepth, this.currentDepth = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (deeplyNested) print('build() called for DeeplyNestedWidget(depth: $currentDepth/$totalDepth)');
    if (totalDepth == currentDepth) return PrintingText("DeeplyNestedWidget(totalDepth: $totalDepth)");
    return DeeplyNestedWidget(totalDepth: totalDepth, currentDepth: currentDepth + 1,);
  }
}

class PrintingText extends Text {
  PrintingText(String data) : super(data) {
    if (text) print('constructor called for PrintingText($data)');
  }

}


