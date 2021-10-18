import 'package:flutter/material.dart';
import 'package:patreon/data.dart';

class DemoPage extends StatefulWidget {
  const DemoPage() : super();

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    super.initState();
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
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
                ),
              ),
              //SAVE
              Positioned(
                right: 10,
                bottom: 10,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              //SAVE
              Positioned(
                left: 70,
                bottom: 30,
                child: Text(
                  'Delivery To',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              //SAVE
              Positioned(
                left: 70,
                bottom: 8,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_searching,
                      size: 20,
                    ),
                    //SAVE
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
                ),
              )
            ],
          ),
          //SAVE
          Divider(),
          //SAVE
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
                        buildCategoryWidget(
                            title: 'Produce', iconData: Icons.food_bank),
                        //SAVE
                        buildCategoryWidget(
                            title: 'Meat', iconData: Icons.food_bank),
                        //SAVE
                        buildCategoryWidget(
                            title: 'Dairy', iconData: Icons.food_bank),
                        //SAVE
                        buildCategoryWidget(
                            title: 'Bread', iconData: Icons.food_bank),
                        //SAVE
                        buildCategoryWidget(
                            title: 'Juice & Water', iconData: Icons.food_bank),
                        //SAVE
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
                        buildOptionWidget(title: 'Over 4.5'),
                        //SAVE
                        buildOptionWidget(title: 'Under 30'),
                        //SAVE
                        buildOptionWidget(title: 'Pickup'),
                        //SAVE
                        buildOptionWidget(title: 'Cheap'),
                        //SAVE
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
                  //SAVE
                  Container(
                    width: screenWidth,
                    height: 120,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildStoreWidget(store: stores[0]),
                        //SAVE
                        buildStoreWidget(store: stores[1]),
                        //SAVE
                        buildStoreWidget(store: stores[2]),
                        //SAVE
                        buildStoreWidget(store: stores[3]),
                        //SAVE
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return buildPaymentWidget();
                      },
                      shrinkWrap: true,
                      itemCount: 10,
                      padding: EdgeInsets.all(0),
                      controller: ScrollController(keepScrollOffset: false),
                    ),
                  ),
                  //SAVE
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
