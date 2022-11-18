import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "system_code =17",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16 / 2),
                    child: Text(
                      "work_accomplished_code = 10",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Row(
                    children: const [
                      Text(
                        "part_no =10",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16 / 2),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: kPrimaryColor,
                        ),
                      ),
                      Text(
                        "unit_cost = 200.00",
                        style: TextStyle(color: kPrimaryColor),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
