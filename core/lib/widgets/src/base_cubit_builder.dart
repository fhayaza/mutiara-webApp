import 'package:flutter/material.dart';
import 'package:core/core.dart';

class BaseCubitBuilder<Data extends Cubit> extends StatefulWidget {
  const BaseCubitBuilder(
      {super.key, this.builder, this.initState, required this.cubit});

  final Widget Function(Data cubit)? builder;
  final void Function(Data cubit)? initState;
  final Data cubit;
  @override
  State<BaseCubitBuilder<Data>> createState() => _BaseCubitBuilderState<Data>();
}

class _BaseCubitBuilderState<Data extends Cubit>
    extends State<BaseCubitBuilder<Data>> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<Data>.value(
        value: widget.cubit,
        child: _WithProvider<Data>(
          builder: widget.builder,
          initState: widget.initState,
        ));
  }
}

class _WithProvider<Data> extends StatefulWidget {
  const _WithProvider({super.key, this.builder, this.initState});

  final Widget Function(Data cubit)? builder;
  final void Function(Data cubit)? initState;
  @override
  State<_WithProvider<Data>> createState() => _WithProviderState<Data>();
}

class _WithProviderState<Data> extends State<_WithProvider<Data>> {
  @override
  void initState() {
    super.initState();
    if (widget.initState != null) {
      widget.initState!(context.read<Data>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        child:Builder(
      builder: (context) {
        final cubit = context.watch<Data>();
        if (widget.builder == null) return const SizedBox();
        return widget.builder!(cubit);
      },
    ));
  }
}
