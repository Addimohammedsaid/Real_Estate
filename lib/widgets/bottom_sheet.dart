import 'package:flutter/material.dart';
import 'package:real_estate/models/property_model.dart';
import 'package:real_estate/utils/constant.dart';

double _value = 500.0;

List<String> _filterRooms = ["Any", "1", "2", "3+"];

int _currentFilterRoom = 1;

List<Property> properties;

List<Property> filteredProperties = List();

bool search = false;

void bottomSheetFilter(context) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(builder: (context, state) {
          return FractionallySizedBox(
              heightFactor: 0.65,
              child: Container(
                  padding: EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    color: kwhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Filter ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            Text(
                              "your search",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 20.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "Price ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                                Text(
                                  "your Range",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 17.0),
                                ),
                              ],
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: kprimary,
                                inactiveTrackColor: Colors.grey[400],
                                trackHeight: 3.5,
                                thumbColor: kprimary,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 8.0),
                                overlayColor: Colors.purple.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 14.0),
                              ),
                              child: Slider(
                                  onChanged: (value) => state(() {
                                        _value = value;
                                      }),
                                  value: _value,
                                  max: 1000,
                                  min: 70,
                                  semanticFormatterCallback: (double value) {
                                    print(value);
                                    return '${value.round()} dollars';
                                  }),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Rooms ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: _filterRooms
                                        .asMap()
                                        .entries
                                        .map(
                                          (MapEntry map) => GestureDetector(
                                            onTap: () => state(() {
                                              _currentFilterRoom = map.key;
                                              print(_currentFilterRoom);
                                              filteredProperties = properties
                                                  .where((((u) => (u.rooms ==
                                                      _currentFilterRoom))))
                                                  .toList();
                                              print(
                                                  filteredProperties[0].rooms);
                                            }),
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 25.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          _currentFilterRoom !=
                                                                  map.key
                                                              ? Colors.grey[400]
                                                              : kprimary),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: _currentFilterRoom ==
                                                          map.key
                                                      ? kprimary
                                                      : kwhite,
                                                ),
                                                child: Text(
                                                  _filterRooms[map.key],
                                                  style: TextStyle(
                                                      color:
                                                          _currentFilterRoom ==
                                                                  map.key
                                                              ? kwhite
                                                              : kdark),
                                                )),
                                          ),
                                        )
                                        .toList()),
                              ],
                            )
                          ],
                        ),
                      ])));
        });
      });
}
