import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebuild_demo/inherited_widget_example.dart';
import 'package:rebuild_demo/stateless_widget_example.dart';

class ConsumerProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Container(color: Colors.green[300], child: ChangeNotifierProvider(
          create: (_) => CounterModel(),
          child: ConsumerExample(),
        ),),),
        Expanded(child: Container(color: Colors.green[300], child: ChangeNotifierProvider(
          create: (_) => CounterModel(),
          child: ProviderOfExample(),
        ),),),
      ],
    );
  }
}

class ConsumerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    print('build() called for ConsumerExample');

    final notListeningModel = Provider.of<CounterModel>(context, listen: false);  // get access to the model without making this widget rebuild on notifyListeners()

    return Row(
      children: [
        Expanded(child: RaisedButton(
          child: Text("Increment"),
          onPressed: notListeningModel.increment,
        ),),
        Expanded(
          child: Consumer<CounterModel>(
            builder: (context, model, child) {
              return PrintOnRebuildStatelessWidget(index: model.count, isConst: false,);
            },
          ),
        ),
        Expanded(
          child: Container(color: Colors.red[300], child: Text("NotListeningModel says: 'count is: ${notListeningModel.count}'"),),
        ),

      ],
    );
  }
}

class ProviderOfExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('build() called for Provider.of() example');

    final model = Provider.of<CounterModel>(context);

    return Row(
      children: [
        Expanded(child: RaisedButton(
          child: Text("Increment"),
          onPressed: model.increment,
        ),),
        Expanded(
          child: PrintOnRebuildStatelessWidget(index: model.count, isConst: false,)
        ),
        Expanded(
          child: Text("Listening Model says: 'count is: ${model.count}'"),
        ),

      ],
    );
  }

}




