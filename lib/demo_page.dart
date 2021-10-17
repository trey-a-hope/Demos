import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Store {
  Store({required this.title, required this.imageUrl});
  String title;
  String imageUrl;
}

class DemoPage extends StatefulWidget {
  const DemoPage() : super();

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final String _profileImageUrl =
      'https://scontent-lga3-2.cdninstagram.com/v/t51.2885-15/e35/s1080x1080/243499107_2975443579395770_8010380476298028189_n.jpg?_nc_ht=scontent-lga3-2.cdninstagram.com&_nc_cat=102&_nc_ohc=jckJIcEpUnoAX9WpIZ3&edm=AP_V10EBAAAA&ccb=7-4&oh=1e127a4c5636f99c80f7139e5e0e127a&oe=6174531C&_nc_sid=4f375e';

  final List<Store> _stores = [
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

  @override
  void initState() {
    super.initState();
  }

  Widget _buildStoreWidget({
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

  Widget _buildCategoryWidget({
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

  Widget _buildOptionWidget({
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

  Widget _buildPaymentWidget() {
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
                  _stores[random.nextInt(4)].title,
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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                width: screenWidth,
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: Container(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(_profileImageUrl),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: IconButton(
                  onPressed: () {
                    print('Go to shopping cart.');
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              Positioned(
                left: 70,
                bottom: 30,
                child: Text(
                  'Delivery To',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Positioned(
                  left: 70,
                  bottom: 8,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_searching,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '2080 Valley Forge',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
          Divider(),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Column(
                children: [
                  Container(
                    width: screenWidth,
                    height: 120,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryWidget(
                            title: 'Produce', iconData: Icons.food_bank),
                        _buildCategoryWidget(
                            title: 'Meat', iconData: Icons.food_bank),
                        _buildCategoryWidget(
                            title: 'Dairy', iconData: Icons.food_bank),
                        _buildCategoryWidget(
                            title: 'Bread', iconData: Icons.food_bank),
                        _buildCategoryWidget(
                            title: 'Juice & Water', iconData: Icons.food_bank),
                      ],
                    ),
                  ),
                  Container(
                    width: screenWidth,
                    height: 50,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildOptionWidget(title: 'Over 4.5'),
                        _buildOptionWidget(title: 'Under 30'),
                        _buildOptionWidget(title: 'Pickup'),
                        _buildOptionWidget(title: 'Cheap'),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Recent',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: screenWidth,
                    height: 120,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildStoreWidget(store: _stores[0]),
                        _buildStoreWidget(store: _stores[1]),
                        _buildStoreWidget(store: _stores[2]),
                        _buildStoreWidget(store: _stores[3]),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return _buildPaymentWidget();
                      },
                      shrinkWrap: true,
                      itemCount: 10,
                      padding: EdgeInsets.all(0),
                      controller: ScrollController(keepScrollOffset: false),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
