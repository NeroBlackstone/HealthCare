import 'package:flutter/material.dart';
import 'BMI.dart';

class BIMPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BIMPageState();
}

class _BIMPageState extends State<BIMPage> {
  final weightTextEditingController = TextEditingController();
  final heightTextEditingController = TextEditingController();
  var advice = 'Input your height and weight and get your BMI and advice';

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                advice,
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: weightTextEditingController,
                decoration: InputDecoration(
                  labelText: 'Your Weight (Kg)',
                ),
                keyboardType: TextInputType.numberWithOptions(),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: heightTextEditingController,
                decoration: InputDecoration(
                  labelText: 'Your Height (M)',
                ),
                keyboardType: TextInputType.numberWithOptions(),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Calculate'),
                onPressed: () {
                  var height = double.parse(heightTextEditingController.text);
                  var weight = double.parse(weightTextEditingController.text);
                  var bmi = BMI(height, weight);
                  setState(() {
                    advice =
                        'Your BMI is ${bmi.calculate().toStringAsFixed(1)}\n'
                        '${bmi.advice()}';
                  });
                  print(bmi.calculate().toStringAsFixed(1));
                  print(bmi.advice());
                },
              )
            ],
          ),
        ),
      ));
}
