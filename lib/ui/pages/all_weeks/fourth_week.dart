import 'package:flutter/material.dart';
import 'package:masrofnaa/ui/shared/export.dart';

class FourthWeek extends StatefulWidget {
  @override
  _FourthWeekState createState() => _FourthWeekState();
}

class _FourthWeekState extends State<FourthWeek> {
  @override
  void initState() {
    super.initState();
  }

  // ListView
  Widget _buildMyListView(AsyncSnapshot snapshot) {
    var providerM = context.read<Masrofna>();
    Masrofna myMasrof = Masrofna.fromMyMap(snapshot.data[0]);
    var screenSize = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ViewMasrofna(index: 3),
              ));
        });
      },
      child: Stack(
        children: [
          Container(
            width: orientation == Orientation.portrait
                ? screenSize.width * 0.45
                : screenSize.width * 0.38,
            height: orientation == Orientation.portrait
                ? screenSize.height * 0.33
                : screenSize.height * 0.60,
            margin: EdgeInsets.all(7.0),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              gradient: kActiveColor,
              // color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text column
                Container(
                  child: Center(
                    child: Text(
                      'إجمالي المبلغ',
                      style: kText.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // Text column

                Container(
                  // color: Colors.greenAccent,

                  child: Center(
                    child: Text(
                      '${myMasrof.weekMoney}',
                      style: kText.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: orientation == Orientation.portrait
                  ? screenSize.width * 0.45
                  : screenSize.width * 0.38,
              height: 42,
              margin: EdgeInsets.all(7.0),
              child: Center(
                child: Text(
                  '${providerM.titles[3]}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                ),
                gradient: kHeaderColor,
                // color: Colors.indigo.shade50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var providerH = context.watch<DBHelper>();
    var providerM = context.select((Masrofna masrofna) => masrofna.tables[3]);

    return Container(
      // color: Colors.red,
      // padding: EdgeInsets.all(7.0),
      child: FutureBuilder(
          future: providerH.getAllMasrof(providerM),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              try {
                return _buildMyListView(snapshot);
              } catch (e) {
                var screenSize = MediaQuery.of(context).size;
                var orientation = MediaQuery.of(context).orientation;
                var providerM = context.watch<Masrofna>();
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewMasrofna(index: 3),
                          ));
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: orientation == Orientation.portrait
                            ? screenSize.width * 0.45
                            : screenSize.width * 0.38,
                        height: orientation == Orientation.portrait
                            ? screenSize.height * 0.33
                            : screenSize.height * 0.60,
                        margin: EdgeInsets.all(7.0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: kActiveColor,
                          // color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            'لا يوجد أي منتج',
                            textAlign: TextAlign.center,
                            style: kText.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          width: orientation == Orientation.portrait
                              ? screenSize.width * 0.45
                              : screenSize.width * 0.38,
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(14),
                              topLeft: Radius.circular(14),
                            ),
                            gradient: kHeaderColor,
                            // color: Colors.indigo.shade50,
                          ),
                          margin: EdgeInsets.all(7.0),
                          child: Center(
                            child: Text(
                              '${providerM.titles[3]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Text('Error');
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
