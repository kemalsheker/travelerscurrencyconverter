import 'package:flutter/cupertino.dart';

const double kCardElevation = 8.0;

const int kDropDownElevation = 12;

const Text kFromText = Text(
  'From',
  style: TextStyle(fontWeight: FontWeight.bold),
  textAlign: TextAlign.center,
);

const Flexible kFromFlexible = Flexible(flex: 1,
  fit: FlexFit.loose,
  child: Padding(padding: EdgeInsets.all(4.0), child: kFromText),);


const SizedBox kSizedBoxHorizontal = SizedBox(width: 8.0,);