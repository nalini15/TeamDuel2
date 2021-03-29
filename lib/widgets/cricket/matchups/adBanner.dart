import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:winx/services/admob_services.dart';

class AdBanner extends StatefulWidget {
  final String stringKey;
  final AdmobBannerSize size;
  const AdBanner({
    this.size,
    this.stringKey,
    Key key,
  }) : super(key: key);

  @override
  _AdBannerState createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  final ams = AdmobService();
  @override
  void initState() {
    super.initState();
    Admob.initialize(testDeviceIds: [ams.getAdMobId()]);
  }

  @override
  Widget build(BuildContext context) {
    return AdmobBanner(adUnitId: widget.stringKey, adSize: widget.size);
  }
}
