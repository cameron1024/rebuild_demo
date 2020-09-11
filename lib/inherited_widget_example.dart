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

    return Consumer<CounterModel>(
      builder: (context, model, child) {
        print('builder called for Consumer<CounterModel>');
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
                        "The first child is passed in through the child parameter. The second child is built from the model value provided in the builder."),
                  ),
                  Expanded(
                    child: child,
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
      },
      child: const PrintOnRebuildStatelessWidget(
        index: 1,
        isConst: true,
      ),
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
