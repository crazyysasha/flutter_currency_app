import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_currency_app/converter/cubit/converter_cubit.dart';
import 'package:flutter_currency_app/converter/models/currency.dart';
import 'package:flutter_currency_app/converter/models/rate.dart';
import 'package:flutter_currency_app/converter/widgets/home_screen.dart';
import 'package:flutter_currency_app/core/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _toAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Currency Converter",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Check live rates, set rate alerts, receive notifications and more.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            BlocConsumer<ConverterCubit, ConverterState>(
              listener: (context, state) => state.whenOrNull(
                loadSuccess: (c, r) => context.read<ConverterCubit>().calculate(
                      to: r,
                      amount: double.tryParse(_amountController.text) ?? 0,
                    ),
                convertFailure: (message) =>
                    ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                ),
                loadFailure: (message) =>
                    ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                ),
                convertSuccess: (c, r, t) =>
                    _toAmountController.text = t.toString(),
              ),
              builder: (context, state) {
                return state.map(
                  initial: (value) => loadingIndicator(),
                  convertFailure: (value) => Text(value.message),
                  loadInProcess: (value) => loadingIndicator(),
                  convertSuccess: (value) => success(
                    context,
                    value.selected,
                    value.to,
                    value.toAmount,
                  ),
                  loadFailure: (value) => Text(value.message),
                  loadSuccess: (value) => success(
                    context,
                    value.selected,
                    value.to,
                    0,
                  ),
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Indicative Exchange Rate",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSecondaryBg,
                      ),
                ),
                BlocSelector<ConverterCubit, ConverterState, String>(
                  selector: (state) => state.map(
                      initial: (v) => "",
                      loadInProcess: (v) => "",
                      loadSuccess: (v) =>
                          "1 ${v.selected.code} = ${v.to.rate} ${v.to.code}",
                      loadFailure: (v) => "",
                      convertSuccess: (v) =>
                          "1 ${v.selected.code} = ${v.to.rate} ${v.to.code}",
                      convertFailure: (v) => ""),
                  builder: (context, state) {
                    return Text(
                      state,
                      style: Theme.of(context).textTheme.labelMedium,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card success(
      BuildContext context, Currency selected, Rate to, double toAmount) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFieldWithDropdown(
              items: const ["USD", "TRY", "RUB"],
              onChanged: (newValue) => context
                  .read<ConverterCubit>()
                  .selectCurrency(code: newValue!),
              selected: selected.code,
              controller: _amountController,
              onInput: (value) => context.read<ConverterCubit>().calculate(
                    to: to,
                    amount: double.tryParse(_amountController.text) ?? 0,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            TextFieldWithDropdown(
              items: selected.rates,
              selected: to,
              label: "Converted Amount",
              itemBuiler: (item) => Text(item.code),
              onChanged: (newValue) => context.read<ConverterCubit>().calculate(
                    to: newValue!,
                    amount: double.tryParse(_amountController.text) ?? 0,
                  ),
              controller: _toAmountController,
            ),
          ],
        ),
      ),
    );
  }

  Center loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
