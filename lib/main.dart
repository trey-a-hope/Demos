import 'package:dough/dough.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patreon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dough 1.0.1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final redSquare = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      child: Center(
        child: Text(
          'Red Square',
          textAlign: TextAlign.center,
          style: Theme.of(context).accentTextTheme.bodyText2,
        ),
      ),
    );

    final Container greenSquare = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      child: Center(
        child: Text(
          'Green Square',
          textAlign: TextAlign.center,
          style: Theme.of(context).accentTextTheme.bodyText2,
        ),
      ),
    );

    final DoughRecipe myDraggableDough = DoughRecipe(
      data: DoughRecipeData(
        adhesion: 4, //How thick.
        viscosity: 500, //How sticky.
        draggablePrefs: DraggableDoughPrefs(
          breakDistance: 80,
        ),
      ),
      child: DraggableDough<String>(
        data: 'My data!',
        child: redSquare,
        feedback: greenSquare,
        onDoughBreak: () {
          print('The dough has broken!');
        },
      ),
    );

    final DragTarget<String> myDragTarget = DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: candidateData.length > 0 ? Colors.lightGreen : Colors.grey,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          child: Center(
            child: Text(
              'Drop It Here!',
              textAlign: TextAlign.center,
              style: Theme.of(context).accentTextTheme.bodyText2,
            ),
          ),
        );
      },
      onWillAccept: (value) => value == 'My data!',
      onAccept: (value) {
        print('the value "$value" was accepted!');
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned(
            right: 50,
            top: 50,
            child: myDraggableDough,
          ),
          Positioned(
            bottom: 50,
            left: 50,
            child: myDragTarget,
          )
        ],
      ),
    );
  }
}
