part of 'base_cubit.dart';

abstract class BaseLogicState {
  final int trigger;
  const BaseLogicState({
    required this.trigger,
  });
  BaseLogicState copyWith({int? trigger});
}

class BaseLogicInit extends BaseLogicState {
  const BaseLogicInit({required super.trigger});
  @override
  BaseLogicInit copyWith({int? trigger}) =>
      BaseLogicInit(trigger: trigger ?? this.trigger);
}

class BaseLogicLoading extends BaseLogicState {
  const BaseLogicLoading({required super.trigger});
  @override
  BaseLogicLoading copyWith({int? trigger}) =>
      BaseLogicLoading(trigger: trigger ?? this.trigger);
}

class BaseLogicSuccess<T> extends BaseLogicState {
  final T? data;
  const BaseLogicSuccess({required this.data, required super.trigger});
  @override
  BaseLogicSuccess copyWith({T? data, int? trigger}) {
    return BaseLogicSuccess(
        data: data ?? this.data, trigger: trigger ?? this.trigger);
  }
}

class BaseLogicError<F> extends BaseLogicState {
  final Failure<F> failure;
  const BaseLogicError({required this.failure, required super.trigger});
  @override
  BaseLogicError copyWith({Failure? failure, int? trigger}) {
    return BaseLogicError(
        failure: failure ?? this.failure, trigger: trigger ?? this.trigger);
  }
}
