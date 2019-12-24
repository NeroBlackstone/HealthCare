import 'dart:math';

class BMI {
  double height;
  double weight;
  BMI(this.height, this.weight);
  double calculate() => weight / pow(height, 2);

  Statue _getStatue(double bmi) {
    if (bmi < 15)
      return Statue.verySeverelyUnderweight;
    else if (bmi < 16)
      return Statue.severelyUnderweight;
    else if (bmi < 18.5)
      return Statue.underWeight;
    else if (bmi < 25)
      return Statue.normal;
    else if (bmi < 30)
      return Statue.overweight;
    else
      return Statue.obese;
  }

  String advice() {
    var statue=_getStatue(this.calculate());
    String adv;
    switch (statue) {
      case Statue.verySeverelyUnderweight:
        adv = 'You are Very Severely Underweight. Please strengthen nutrition.';
        break;
      case Statue.severelyUnderweight:
        adv = 'You are Severely Underweight. Please strengthen nutrition.';
        break;
      case Statue.underWeight:
        adv = 'You are Under Weight. Please strengthen nutrition.';
        break;
      case Statue.normal:
        adv = 'You are Normal. Keep your daily body workout.';
        break;
      case Statue.overweight:
        adv = 'You are Overweight.Please lose weight to improve your health.';
        break;
      case Statue.obese:
        adv = 'You are Obese.Please lose weight to improve your health.';
        break;
    }
    return adv;
  }
}

enum Statue {
  verySeverelyUnderweight,
  severelyUnderweight,
  underWeight,
  normal,
  overweight,
  obese,
}
