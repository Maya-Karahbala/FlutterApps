import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Age Calculator'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DateTime _birthDate;
  var txtBirthDayController = TextEditingController();
  DateTime _todayDate = DateTime.now();
  var txtTodayDateController = TextEditingController();

  _buildDateTxtFeild(var controler) {
    return Container(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controler,
          style: TextStyle(fontSize: 20),
          enabled: false,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal))),
        ),
      ),
    );
  }

  _buildLable(String lableText) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(lableText, style: TextStyle(fontSize: 20)),
      ),
    );
  }

  _buildButton(String name, Function task) {
    return Container(
      width: 150,
      height: 50,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          task();
        },
        child: Text(name, style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  _buildBox(String name, String value) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          width: 115,
          height: 35,
          child: Center(
              child: Text(
            name,
            style: TextStyle(color: Colors.white),
          )),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: Theme.of(context).primaryColor,
          )),
          width: 115,
          height: 40,
          child: Center(
              child: Text(
            value,
          )),
        )
      ],
    );
  }

  _buildBoxesRow(String year, String month, String day) {
    Widget yearBox = _buildBox("Year", year);
    Widget monthrBox = _buildBox("Month", month);
    Widget dayBox = _buildBox("Day", day);
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[yearBox, monthrBox, dayBox],
      ),
    );
  }

  _buildCalculatedAgeRow() {
    if (_birthDate == null || _todayDate == null) {
      return _buildBoxesRow("", "", "");
    }
    var year = _todayDate.year - _birthDate.year;
    var month = _todayDate.month - _birthDate.month;
    var day = _todayDate.day - _birthDate.day;
    if (month < 0) {
      year--;
      month = month + 12;
    }
    if (day < 0) {
      month--;
      day = day + 30;
    }
    return _buildBoxesRow(year.toString(), month.toString(), day.toString());
  }

  _buildNextBirthdayRow() {
    if (_birthDate == null || _todayDate == null) {
      return _buildBoxesRow("", "", "");
    }

    var year;
    var month = _todayDate.month - _birthDate.month;

    if (month < 0) {
      year = _todayDate.year;
    } else {
      year = _todayDate.year + 1;
    }
    return _buildBoxesRow(year.toString(), _birthDate.month.toString(),
        _birthDate.day.toString());
  }

  _clear() {
    setState(() {
      _todayDate = null;
      _birthDate = null;
    });

    txtTodayDateController.text = "";
    txtBirthDayController.text = "";
  }

  _buildBirthDatePicker() {
    return IconButton(
      icon: Icon(Icons.date_range),
      onPressed: () => {
        showDatePicker(
                context: context,
                initialDate: _birthDate == null ? DateTime.now() : _birthDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2031))
            .then((date) {
          setState(() {
            _birthDate = date;
            txtBirthDayController.text =
                ' ${date.day} - ${date.month} - ${date.year}';
          });
        })
      },
    );
  }

  _buildTodayDatePicker() {
    return IconButton(
      icon: Icon(Icons.date_range),
      onPressed: () => {
        showDatePicker(
                context: context,
                initialDate: _todayDate == null ? DateTime.now() : _todayDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2031))
            .then((date) {
          setState(() {
            _todayDate = date;
            txtTodayDateController.text =
                ' ${date.day} - ${date.month} - ${date.year}';
          });
        })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_todayDate != null)
      txtTodayDateController.text =
          ' ${_todayDate.day} - ${_todayDate.month} - ${_todayDate.year}';
    Widget birthDateLable = _buildLable("Date of Birth");
    Widget todayDateLable = _buildLable("Today Date");
    Widget birthDatetxt = _buildDateTxtFeild(txtBirthDayController);
    Widget todayDateTxt = _buildDateTxtFeild(txtTodayDateController);
    Widget clearBtn = _buildButton("Clear", _clear);
    Widget calculateBtn = _buildButton("Calculate", () => {});
    Widget ageLable = _buildLable("Age is");
    Widget nextBirthdayLable = _buildLable("Next Birth Day is");
    Widget calculatedAgeRow = _buildCalculatedAgeRow();
    Widget nextBirthdayRow = _buildNextBirthdayRow();
    Widget birthDatePicker = _buildBirthDatePicker();
    Widget todayDatePicker = _buildTodayDatePicker();
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(widget.title, style: TextStyle(color: Colors.white))),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            birthDateLable,
            Row(children: <Widget>[birthDatetxt, birthDatePicker]),
            todayDateLable,
            Row(children: <Widget>[todayDateTxt, todayDatePicker]),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[clearBtn, calculateBtn],
              ),
            ),
            ageLable,
            calculatedAgeRow,
            nextBirthdayLable,
            nextBirthdayRow
          ],
        ),
      ),
    );
  }
}
/*

*/
