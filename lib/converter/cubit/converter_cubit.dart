import 'package:bloc/bloc.dart';
import 'package:flutter_currency_app/converter/models/currency.dart';
import 'package:flutter_currency_app/converter/models/rate.dart';
import 'package:flutter_currency_app/converter/repositories/rates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'converter_state.dart';
part 'converter_cubit.freezed.dart';

class ConverterCubit extends Cubit<ConverterState> {
  final RatesRepository repository;
  ConverterCubit({required this.repository})
      : super(const ConverterState.initial()) {
    init();
  }

  init() => selectCurrency(code: "USD");
  Currency? selected;
  selectCurrency({required final String code}) async {
    selected = null;
    try {
      emit(const ConverterState.loadInProcess());
      selected = await repository.getCurrency(code);
      emit(
        ConverterState.loadSuccess(
          selected: selected!,
          to: selected!.rates.first,
        ),
      );
    } catch (e) {
      emit(ConverterState.loadFailure(message: e.toString()));
    }
  }

  calculate({required final Rate to, required final double amount}) {
    if (selected == null) {
      return emit(
        const ConverterState.convertFailure(
          message: "please select currency",
        ),
      );
    }
    emit(
      ConverterState.convertSuccess(
        selected: selected!,
        to: to,
        toAmount: amount * to.rate,
      ),
    );
  }
}
