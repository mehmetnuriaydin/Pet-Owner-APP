import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class mapUtils {
  mapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrlString = 'https://www.google.com/maps/search/veteriner/';

    Uri googleUrl = Uri.parse(googleUrlString);

    _launch(googleUrl);

    /*final String encodedURL = Uri.encodeFull(googleUrl);

    if (await canLaunchUrl(encodedURL)) {
      await launchUrl(encodedURL);
    } else {
      throw 'Could not open the map.';
    }*/
  }

  static Future<void> _launch(Uri url) async {
    await launchUrl(url);
  }
}
