import '../modelview/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel) onPageBuilder;
  final T viewModel;
  final Function(T viewModel)? onModelReady;
  final VoidCallback? onDispose;

  const BaseView({
    Key? key,
    required this.viewModel,
    required this.onPageBuilder,
    this.onModelReady,
    this.onDispose,
  }) : super(key: key);

  @override
  _Baseuitate<T> createState() => _Baseuitate<T>();
}

class _Baseuitate<T extends BaseViewModel> extends State<BaseView<T>> {
  late T viewModel;

  @override
  void initState() {
    viewModel = widget.viewModel;
    if (widget.onModelReady != null) {
      widget.onModelReady!(viewModel);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) {
      widget.onDispose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => widget.viewModel,
      child: Consumer<T>(
        builder: (contexts, T viewModels, widgets) => widget.onPageBuilder(context, viewModel),
      ),
    );
  }
}
