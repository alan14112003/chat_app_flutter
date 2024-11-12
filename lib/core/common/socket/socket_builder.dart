import 'package:flutter/material.dart';

abstract class SocketListener {
  void initListeners(BuildContext context);
  void removeListeners(BuildContext context);
}

class SocketBuilder<T extends SocketListener> extends StatefulWidget {
  final T instant;
  final Widget? child;

  const SocketBuilder({
    super.key,
    required this.instant,
    this.child,
  });

  @override
  State<SocketBuilder> createState() => _SocketBuilderState<T>();
}

class _SocketBuilderState<T extends SocketListener>
    extends State<SocketBuilder<T>> {
  @override
  void initState() {
    super.initState();
    widget.instant.initListeners(context);
  }

  @override
  void dispose() {
    widget.instant.removeListeners(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? SizedBox.shrink();
  }
}

class MultiSocketBuilder extends StatelessWidget {
  final List<SocketBuilder> builders;
  final Widget child;

  const MultiSocketBuilder({
    super.key,
    required this.builders,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Xây dựng cây các widget `SocketBuilder` và bọc `child`
    Widget current = child;
    for (var builder in builders.reversed) {
      current = builder.copyWithChild(current);
    }
    return current;
  }
}

extension on SocketBuilder {
  // Phương thức tiện ích để sao chép `SocketBuilder` với một `child` mới
  SocketBuilder copyWithChild(Widget newChild) {
    return SocketBuilder(
      instant: instant,
      child: newChild,
    );
  }
}
