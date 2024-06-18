import 'package:barber/utils/utils.dart';
import 'package:flutter/material.dart';

class BaseList<T> extends StatelessWidget {
  const BaseList({
    required this.items,
    required this.itemBuilder,
    this.state,
    this.onRefresh,
    this.emptyInfo,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final PageState? state;
  final RefreshCallback? onRefresh;
  final String? emptyInfo;

  @override
  Widget build(BuildContext context) {
    if (state?.status == PageStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return Center(child: Text(emptyInfo ?? 'Não apresenta nenhuma informação'));
    }

    Widget widget = ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder.call(context, items[index]),
    );

    if (onRefresh != null) {
      widget = RefreshIndicator(onRefresh: onRefresh!, child: widget);
    }

    return widget;
  }
}
