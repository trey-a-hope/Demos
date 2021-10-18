import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

class Store {
  Store({required this.title, required this.imageUrl});
  String title;
  String imageUrl;
}

final String profileImageUrl =
    'https://scontent-lga3-2.cdninstagram.com/v/t51.2885-15/e35/s1080x1080/243499107_2975443579395770_8010380476298028189_n.jpg?_nc_ht=scontent-lga3-2.cdninstagram.com&_nc_cat=102&_nc_ohc=jckJIcEpUnoAX9WpIZ3&edm=AP_V10EBAAAA&ccb=7-4&oh=1e127a4c5636f99c80f7139e5e0e127a&oe=6174531C&_nc_sid=4f375e';

final List<Store> stores = [
  Store(
      title: 'Target',
      imageUrl:
          'https://www.denverpost.com/wp-content/uploads/2021/07/7.16R-New-Target-scaled-1.jpeg?w=1024'),
  Store(
      title: 'Publix',
      imageUrl:
          'https://cutpcdnwimages.azureedge.net/images/static/StoreFront/001226-828x498.png'),
  Store(
      title: 'Kroger',
      imageUrl:
          'https://cdn.vox-cdn.com/thumbor/oOjc1oHmbGbwgKEZFpdPaqrkfIE=/0x425:6016x3575/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/16222155/shutterstock_1218526141.jpg'),
  Store(
      title: 'Walmart',
      imageUrl:
          'https://media.bizj.us/view/img/4285141/photo-p6-walmart*1024xx5724-3216-0-494.jpg'),
];

Widget buildStoreWidget({
  required Store store,
}) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Container(
      width: 175,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(store.imageUrl),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              store.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildCategoryWidget({
  required String title,
  required IconData iconData,
}) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.orange,
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade900),
        )
      ],
    ),
  );
}

Widget buildOptionWidget({
  required String title,
}) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Container(
      width: 100,
      child: GFButton(
        size: GFSize.LARGE,
        text: title,
        textStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade800,
        ),
        color: Colors.grey.shade300,
        shape: GFButtonShape.pills,
        onPressed: () {
          print('go to this...');
        },
      ),
    ),
  );
}

Widget buildPaymentWidget() {
  Random random = new Random();

  return Container(
    margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
        color: Colors.blueGrey[600],
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Icon(
            Icons.food_bank_rounded,
            color: Colors.lightBlue[900],
          ),
          padding: EdgeInsets.all(12),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                stores[random.nextInt(4)].title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              Text(
                'Groceries',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              '-\$${(random.nextDouble() * 1000).toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange),
            ),
            Text(
              DateFormat.yMMMd().format(
                DateTime(
                  2021,
                  random.nextInt(12),
                  random.nextInt(30),
                ),
              ),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[300]),
            ),
          ],
        ),
      ],
    ),
  );
}
