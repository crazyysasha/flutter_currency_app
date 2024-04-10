part of 'converter_cubit.dart';

@freezed
class ConverterState with _$ConverterState {
  const factory ConverterState.initial() = _Initial;
  const factory ConverterState.loadInProcess() = _LoadInProcess;
  const factory ConverterState.loadSuccess({
    required final Currency selected,
    required final Rate to,
  }) = _LoadSuccess;
  const factory ConverterState.loadFailure({
    required final String message,
  }) = _LoadFailure;
  const factory ConverterState.convertSuccess({
    required final Currency selected,
    required final Rate to,
    required double toAmount,
  }) = _convertSuccess;
  const factory ConverterState.convertFailure({
    required final String message,
  }) = _convertFailure;
}
