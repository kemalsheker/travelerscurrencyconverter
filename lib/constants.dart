import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double kCardElevation = 8.0;

const int kDropDownElevation = 18;

const Text kFromText = Text(
  'From',
  style: TextStyle(fontWeight: FontWeight.bold),
  textAlign: TextAlign.center,
);

const Text kToText = Text(
  'To',
  style: TextStyle(fontWeight: FontWeight.bold),
  textAlign: TextAlign.center,
);

const Text kDataProvided = Text(
  'Data provided from Exchangerate.host',
  style: TextStyle(fontSize: 12.0),
  textAlign: TextAlign.center,
);

const Flexible kFromFlexible = Flexible(
  flex: 1,
  fit: FlexFit.loose,
  child: Padding(padding: EdgeInsets.all(4.0), child: kFromText),
);

const Flexible kToFlexible = Flexible(
  flex: 1,
  fit: FlexFit.loose,
  child: Padding(padding: EdgeInsets.all(4.0), child: kToText),
);

const SizedBox kSizedBoxHorizontal = SizedBox(
  width: 8.0,
);

const Divider kColumnDivider = Divider(
  color: Colors.black,
  thickness: 4.0,
  indent: 8.0,
  endIndent: 8.0,
);


