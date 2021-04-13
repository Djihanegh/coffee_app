import 'package:flutter/material.dart';

import 'coffee_concept_list.dart';

class MainCoffeeConceptApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(child: CoffeeConceptList(), data: ThemeData.light());
  }
}
