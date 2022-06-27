import 'package:flutter/material.dart';

/// A helper abstract class to denote that a state class should be kept alive
///
/// This makes the state class use [AutomaticKeepAliveClientMixin]
abstract class KeptAliveState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin<T> {
  @override
  bool get wantKeepAlive => true;
}
