import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebuild_demo/main.dart';
import 'package:rebuild_demo/stateless_widget_example.dart';

class InheritedWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build() called for InheritedWidgetExample');
    return ChangeNotifierProvider<CounterModel>(
      create: (context) => CounterModel(),
      child: InheritedWidgetBody(),
    );
  }
}

class InheritedWidgetBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build() called for InheritedWidgetBody');

    final model = Provider.of<CounterModel>(context);

    return Column(
      children: [
        Expanded(
          child: RaisedButton(
            child: PrintingText("CounterModel.increment"),
            onPressed: model.increment,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: PrintingText(
                    "The child is built in a built from the model class. When the model changes, it will update. However, the entire tree is rebuilt"),
              ),
              Expanded(
                child: PrintOnRebuildStatelessWidget(
                  isConst: false,
                  index: model.count,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CounterModel extends ChangeNotifier {
  CounterModel() {
    if (counterModelConstructor) print('constructor called for CounterModel');
  }

  var count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}
