import 'package:educationadmin/widgets/ProgressIndicatorWidget.dart';
import 'package:flutter/material.dart';

class CenterProgressIndicator extends StatelessWidget {
  const CenterProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      child:const Center(
        child:  Padding(
          padding: EdgeInsets.all(8.0),
          child: ProgressIndicatorWidget(),
        ),
      ),
    );
  }
}
