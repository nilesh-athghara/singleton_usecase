import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final Function(String) onItemClick;

  const MenuWidget({
    Key key,
    this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width / 1.2,
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
          sliderItem(
            'Rate',
            Icons.star_rate,
          ),
          SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
          sliderItem('Feedbacks', Icons.feedback),
          SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
          sliderItem('About Us', Icons.account_box_outlined),
          SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
          sliderItem('Privacy Policy', Icons.question_answer),
        ],
      ),
    );
  }

  Widget sliderItem(String title, IconData icons,) => ListTile(
      title: Text(
        title,
        style:
            TextStyle(color: Colors.white, fontFamily: 'BalsamiqSans_Regular'),
      ),
      leading: Icon(
        icons,
        color: Colors.white,
      ),
      onTap: () {
        onItemClick(title);
        // null
      });
}
