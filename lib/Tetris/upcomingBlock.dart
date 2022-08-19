
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingBlock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpcomingBlockState();
}

class _UpcomingBlockState extends State<UpcomingBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[600],
      ),
      width: double.infinity,
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5,),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
