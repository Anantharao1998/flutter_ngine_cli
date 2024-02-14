import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:juno_getx_base_project/core/utils/utils.dart';
import 'package:juno_getx_base_project/core/values/values.dart';

///ignore: must_be_immutable
class PagingView extends StatelessWidget {
  final Widget child;
  final Function() onLoadNextPage;
  final Future<void> Function()? onRefresh;

  ScrollController? scrollController;

  late final _debouncer = Debouncer(milliseconds: 500);

  PagingView({
    required this.child,
    required this.onLoadNextPage,
    this.onRefresh,
    this.scrollController,
    Key? key,
  }) : super(key: key) {
    scrollController ??= ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollController != null) {
          final double triggerFetchMoreSize =
              0.75 * scrollController!.position.maxScrollExtent;

          if (scrollController!.position.pixels >= triggerFetchMoreSize &&
              (scrollController!.position.userScrollDirection ==
                  ScrollDirection.reverse)) {
            _debouncer.run(() {
              onLoadNextPage();
            });
          }
        }

        return true;
      },
      child: onRefresh == null
          ? _getScrollableView()
          : RefreshIndicator(
              onRefresh: onRefresh!,
              child: _getScrollableView(),
            ),
    );
  }

  Widget _getScrollableView() {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          child,
          const SizedBox(height: AppValues.listBottomEmptySpace),
        ],
      ),
    );
  }
}
