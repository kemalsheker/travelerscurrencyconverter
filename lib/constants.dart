import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double kCardElevation = 8.0;

const int kDropDownElevation = 12;

const Text kFromText = Text(
  'From',
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

const SizedBox kSizedBoxHorizontal = SizedBox(
  width: 8.0,
);

const Divider kColumnDivider = Divider(
  color: Colors.black,
  thickness: 4.0,
  indent: 8.0,
  endIndent: 8.0,
);

final Row swapRow =  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    const Expanded(
        child: kColumnDivider
    ),
    ElevatedButton(
      child: const Icon(Icons.swap_vert),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(18, 18),
        shape: const CircleBorder(),
      ),
    ),
    const Expanded(
        child: kColumnDivider,
    ),
  ],
);