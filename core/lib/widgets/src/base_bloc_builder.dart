import 'package:flutter/material.dart';
import 'package:core/core.dart';

class BaseBlocBuilder<Data> extends StatefulWidget {
  const BaseBlocBuilder({
    super.key,
    this.onSuccess,
    this.onLoading,
    this.onError,
    this.defaultChild,
    this.initState,
    this.cubit,
  });
  final Widget Function(BaseResponse<Data> data, BaseLogic<Data> cubit)?
      onSuccess;
  final Widget Function(BaseLogic<Data> cubit)? onLoading;
  final Widget Function(Failure data, BaseLogic<Data> cubit)? onError;
  final Widget Function(BaseLogic<Data> cubit)? defaultChild;
  final void Function(BaseLogic<Data> cubit)? initState;
  final BaseLogic<Data>? cubit;
  @override
  State<BaseBlocBuilder<Data>> createState() => _BaseBlocBuilderState<Data>();
}

class _BaseBlocBuilderState<Data> extends State<BaseBlocBuilder<Data>> {
  @override
  Widget build(BuildContext context) {
    if (widget.cubit != null) {
      return RepaintBoundary(
        child:BlocProvider.value(
          value: widget.cubit!,
          child: _WithProvider<Data>(
            defaultChild: widget.defaultChild,
            onError: widget.onError,
            onLoading: widget.onLoading,
            onSuccess: widget.onSuccess,
            initState: widget.initState,
          )));
    }
    return RepaintBoundary(
      child:Builder(
      builder: (context) {
        final cubit = context.watch<BaseLogic<Data>>();
        if (cubit.state is BaseLogicSuccess<BaseResponse<Data>> &&
            widget.onSuccess != null) {
          final data = cubit.state as BaseLogicSuccess<BaseResponse<Data>>;
          return widget.onSuccess!(data.data!, cubit);
        }
        if (cubit.state is BaseLogicLoading && widget.onLoading != null) {
          return widget.onLoading!(cubit);
        }
        if (cubit.state is BaseLogicError && widget.onError != null) {
          final failure = cubit.state as BaseLogicError;
          return widget.onError!(failure.failure, cubit);
        }
        return widget.defaultChild == null
            ? const SizedBox()
            : widget.defaultChild!(cubit);
      },
    ));
  }
}

class _WithProvider<Data> extends StatefulWidget {
  const _WithProvider(
      {Key? key,
      this.onSuccess,
      this.onLoading,
      this.onError,
      this.defaultChild,
      this.initState})
      : super(key: key);
  final Widget Function(BaseResponse<Data>, BaseLogic<Data> cubit)? onSuccess;
  final Widget Function(BaseLogic<Data> cubit)? onLoading;
  final Widget Function(Failure data, BaseLogic<Data> cubit)? onError;
  final Widget Function(BaseLogic<Data> cubit)? defaultChild;
  final void Function(BaseLogic<Data> cubit)? initState;
  @override
  State<_WithProvider<Data>> createState() => _WithProviderState<Data>();
}

class _WithProviderState<Data> extends State<_WithProvider<Data>> {
  @override
  void initState() {
    super.initState();
    if (widget.initState != null) {
      widget.initState!(context.read<BaseLogic<Data>>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = context.watch<BaseLogic<Data>>();
        if (cubit.state is BaseLogicSuccess<BaseResponse<Data>> &&
            widget.onSuccess != null) {
          final data = cubit.state as BaseLogicSuccess<BaseResponse<Data>>;
          return widget.onSuccess!(data.data!, cubit);
        }
        if (cubit.state is BaseLogicLoading && widget.onLoading != null) {
          return widget.onLoading!(cubit);
        }
        if (cubit.state is BaseLogicError && widget.onError != null) {
          final failure = cubit.state as BaseLogicError;
          return widget.onError!(failure.failure, cubit);
        }
        return widget.defaultChild == null
            ? const SizedBox()
            : widget.defaultChild!(cubit);
      },
    );
  }
}
