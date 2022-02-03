import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  List<String> vegetables = [
    'Tomatoes',
    'Carrots',
    'Onions',
    'Potatoes',
    'Beets',
    'Lettuce',
    'Kale',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: ListView.builder(
        itemCount: vegetables.length,
        itemBuilder: (context, index) {
          String vegetable = vegetables[index];
          return Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {}),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Delete $vegetable'),
                      ),
                    );
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Share $vegetable'),
                      ),
                    );
                  },
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Share',
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  flex: 2,
                  onPressed: (context) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Archive $vegetable'),
                      ),
                    );
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.archive,
                  label: 'Archive',
                ),
                SlidableAction(
                  onPressed: (context) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Save $vegetable'),
                      ),
                    );
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.save,
                  label: 'Save',
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                vegetables[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
