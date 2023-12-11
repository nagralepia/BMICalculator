import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Your BMI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var inController = TextEditingController();
  var ftController = TextEditingController();
  var result = "";
  var bgColor = Colors.purple.shade50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        color: bgColor,
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "BMI",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 21,
                ),
                TextField(
                  controller: wtController,
                  decoration: InputDecoration(
                      label: Text("Enter your Weight (in Kgs)"),
                      prefixIcon: Icon(Icons.line_weight)),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 11,
                ),
                TextField(
                  controller: ftController,
                  decoration: InputDecoration(
                      label: Text("Enter Your Height (in feet)"),
                      prefixIcon: Icon(Icons.height)),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 11,
                ),
                TextField(
                  controller: inController,
                  decoration: InputDecoration(
                      label: Text("Enter Your height (in Inches)"),
                      prefixIcon: Icon(Icons.height)),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 21,
                ),
                ElevatedButton(
                    onPressed: () {
                      var wt = wtController.text.toString();
                      var inch = inController.text.toString();
                      var ft = ftController.text.toString();

                      if (wt != "" && ft != "" && inch != "") {
                        //BMI Calculation
                        var intFt = int.parse(ft);
                        var intwt = int.parse(wt);
                        var intInch = int.parse(inch);

                        var totalInch = (intFt * 12) + intInch;
                        var totalCenterMeter = totalInch * 2.54;
                        var totalMeter = totalCenterMeter / 100;
                        var bmi = intwt / (totalMeter * totalMeter);


                      //   Underweight = <18.5
                      // Normal weight = 18.5–24.9
                      // Overweight = 25–29.9
                      // Obesity = BMI of 30 or greater
                        var msg = "";
                        if (bmi > 25 && bmi <30) {
                          msg = "You are Overweight";
                          bgColor = Colors.deepOrangeAccent.shade100;
                        } else if (bmi <= 18) {
                          msg = "You are Under Weight";
                          bgColor = Colors.redAccent.shade100;
                        }else if(bmi>30){
                          msg = "You are Obesity";
                          bgColor = Colors.red.shade200;
                        } else {
                          msg = "You are Healthy";
                          bgColor = Colors.green.shade100;
                        }

                        setState(() {
                          result =
                              "$msg \n Your BMI is ${bmi.toStringAsFixed(0)}";
                        });
                      } else {
                        setState(() {
                          result = "Please fill all the required fields";
                        });
                      }
                    },
                    child: Text("Calculate")),
                SizedBox(
                  height: 20,
                ),
                Text(result, style: TextStyle(fontSize: 19))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
