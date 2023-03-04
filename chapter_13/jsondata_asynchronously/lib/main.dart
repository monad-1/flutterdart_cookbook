import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

// Example 2: JSON Dataset 
class MyData {
final String items = '{"data": [
{ "title": "January" },
{ "title": "February" },
{ "title": "March" },
] }';
}

class DataSeries {
  final List<DataItem> dataModel;
  DataSeries({required this.dataModel});

  factory DataSeries.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;

    List<DataItem> dataList = list.map((dataModel) => 
      DataItem.fromJson(dataModel)).toList();

    return DataSeries(dataModel: dataList);
  }
}

class DataItem {
  final String title;
  DataItem({required this.title});

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(title: json['title']);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local JSON Future Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Local JSON Futre Demo',
        key: null,
      ),
    ); 
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,
  required this.title,}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<String> _loadLocalData() async {
  final MyData data = MyData();

  return data.items;
}
class _MyHomePageState extends State<MyHomePage> {
    Future<DataSeries> fetchData() async {
      String jsonString = await _loadLocalData();
      final jsonResponse = json.decode(jsonString);
      DataSeries dataSeries = DataSeries.fromJson(jsonResponse);
      print(dataSeries.dataModel[0].title);

      return dataSeries;
    }

    late Future<DataSeries> dataSeries;

    @override
    void initState() {
      super.initState();
      dataSeries = fetchData();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<DataSeries>(
        future: dataSeries,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.dataModel.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data!.dataModel[index].title),
                );
              }
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }
      ),
    );
  }
}
