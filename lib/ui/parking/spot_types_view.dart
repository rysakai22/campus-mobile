import 'package:campus_mobile_experimental/core/models/spot_types.dart';
import 'package:campus_mobile_experimental/core/providers/parking.dart';
import 'package:campus_mobile_experimental/ui/common/HexColor.dart';
import 'package:campus_mobile_experimental/ui/common/container_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:provider/provider.dart';

import '../../core/hooks/spot_types_query.dart';

class SpotTypesView extends HookWidget {
  //late ParkingDataProvider spotTypesDataProvider;
  @override
  Widget build(BuildContext context) {
    //spotTypesDataProvider = Provider.of<ParkingDataProvider>(context);
    final spotTypesData = useFetchSpotTypes();
    //print(spotTypesData.data?.spots?[0].spotKey);
    //final spotTypesState = useState<Map<String, bool>>({});
    return ContainerView(
      child: createListWidget(context, spotTypesData.data!),
    );
  }

  Widget createListWidget(BuildContext context, SpotTypeModel spotTypesData) {
    return ListView(children: createList(context, spotTypesData));
  }

  List<Widget> createList(BuildContext context, SpotTypeModel spotTypesData) {
    int selectedSpots = 0;
    List<Widget> list = [];
    // for (Spot data in spotTypesDataProvider.spotTypeModel!.spots!) {
    //   if (Provider.of<ParkingDataProvider>(context)
    //           .spotTypesState![data.spotKey]! ==
    //       true) {
    //     selectedSpots++;
    //   }

    List<String> testStr = ["a", "b", "c", "d", "e", "f", "g", "h"];

    for (Spot data in spotTypesData.spots!) {
      // if (spotTypesState[data.spotKey] == true) {
      //   selectedSpots++;
      // }
      Color iconColor = HexColor(data.color!);
      Color textColor = HexColor(data.textColor!);

      list.add(ListTile(
        key: Key(data.name.toString()),
        leading: Container(
            width: 35,
            height: 35,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor,
            ),
            child: Align(
                alignment: Alignment.center,
                child: data.text!.contains("&#x267f;")
                    ? Icon(Icons.accessible,
                        size: 25.0, color: colorFromHex(data.textColor!))
                    : Text(
                        data.spotKey!.contains("SR") ? "RS" : data.text!,
                        style: TextStyle(color: textColor),
                      ))),
        title: Text(data.name!),
        trailing: Switch(
          value: Provider.of<ParkingDataProvider>(context)
              .spotTypesState![data.spotKey]!,
          onChanged: (_) {
            // spotTypesDataProvider.toggleSpotSelection(
            //     data.spotKey, selectedSpots);
          },
          // activeColor: Theme.of(context).buttonColor,
          activeColor: Theme.of(context).backgroundColor,
        ),
      ));
    }
    return list;
  }

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor =
          'FF' + hexColor; // FF as the opacity value if you don't add it.
    }
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
