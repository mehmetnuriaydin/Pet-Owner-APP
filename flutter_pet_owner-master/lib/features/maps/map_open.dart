import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/features/maps/map_view.dart';

class MapOpen extends StatefulWidget {
  const MapOpen({super.key});

  @override
  State<MapOpen> createState() => _MapOpenState();
}

class _MapOpenState extends State<MapOpen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  mapUtils.openMap(38.4190945, 27.1385118);
                },
                child: Text('Haritayı Görüntüle'),
              )
            ],
          ),
        ));
  }
}
