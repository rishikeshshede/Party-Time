import 'package:flutter/material.dart';

import '../../../../components/constants.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Select Date: ',
            style: Theme.of(context).textTheme.overline.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            'Nov 22, 2020',
            style: Theme.of(context).textTheme.overline.copyWith(
                  fontSize: 13,
                  color: kSecondaryColor,
                  decoration: TextDecoration.underline,
                ),
          ),
        ],
      ),
    );
  }
}
