import 'package:fitness_application/models/lap.dart';
import 'package:fitness_application/providers/stop_watch_provider.dart';
import 'package:fitness_application/util/helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LapsListWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          child: Consumer(
            builder: (context,watch,child) {
              return _displayList(laps: watch(stopWatchProvider).laps);
              },
          ),
        ));
  }

  Widget _displayList({required List<Lap>? laps}) {
    return ListView.builder(
        itemCount: laps!.length,
        itemBuilder: (context, index) {
          if (laps.length != 0) {
            Lap lap = laps[laps.length - index - 1];
            return ListTile(
              leading: Text(
                "Lap " + lap.lapNum.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        index == 0 ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16),
              ),
              trailing: Text(
                Helper.durationCalc(lap.currentTime).toString(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }
          return Container();
        });
  }
}
