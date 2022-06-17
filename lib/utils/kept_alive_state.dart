import 'package:flutter/material.dart';

abstract class KeptAliveState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin<T> {
  @override
  bool get wantKeepAlive => true;
}
