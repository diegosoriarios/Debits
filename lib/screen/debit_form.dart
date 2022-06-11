import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:debits/components/color_picker/color_picker_slide.dart';
import 'package:debits/models/expenses.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ScreenArguments {
  final Function handleElement;
  final Expenses? expenses;

  ScreenArguments(this.handleElement, this.expenses);
}

class DebitForm extends StatefulWidget {
  const DebitForm({Key? key}) : super(key: key);

  @override
  State<DebitForm> createState() => _DebitFormState();
}

class _DebitFormState extends State<DebitForm> {
  final descriptionController = TextEditingController(text: "Description");
  final valueController = TextEditingController(text: "0.00");
  MoneyType _type = MoneyType.GASTO;
  String selectedValue = "0xe318";
  Color color = Colors.white;
  double _colorSliderPosition = 0;
  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    locale: "pt-br",
    symbol: "R\$",
  );

  void setColor(position, calculatedPosition) {
    setState(() {
      _colorSliderPosition = position;
      color = calculatedPosition;
    });
  }

  List<DropdownMenuItem<String>> dropdownItems = [
    DropdownMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Icon(IconData(0xe318, fontFamily: "MaterialIcons")),
            Text("Aluguel"),
          ],
        ),
        value: "0xe318"),
    DropdownMenuItem(
        child: Row(
          children: const [
            Icon(IconData(0xe233, fontFamily: "MaterialIcons")),
            Text("Transporte"),
          ],
        ),
        value: "0xe233"),
    DropdownMenuItem(
        child: Row(
          children: const [
            Icon(IconData(0xe25a, fontFamily: "MaterialIcons")),
            Text("Comida"),
          ],
        ),
        value: "0xe25a"),
    DropdownMenuItem(
        child: Row(
          children: const [
            Icon(IconData(0xf05a2, fontFamily: "MaterialIcons")),
            Text("Água"),
          ],
        ),
        value: "0xf05a2"),
    DropdownMenuItem(
        child: Row(
          children: const [
            Icon(IconData(0xe6e7, fontFamily: "MaterialIcons")),
            Text("Internet"),
          ],
        ),
        value: "0xe6e7"),
    DropdownMenuItem(
        child: Row(
          children: const [
            Icon(IconData(0xf1f3, fontFamily: "MaterialIcons")),
            Text("Lazer"),
          ],
        ),
        value: "0xf1f3"),
    DropdownMenuItem(
        child: Row(
          children: const [
            Icon(IconData(0xe3d9, fontFamily: "MaterialIcons")),
            Text("Farmácia"),
          ],
        ),
        value: "0xe3d9"),
    DropdownMenuItem(
        child: Row(
          children: const [
            Icon(IconData(0xe4a3, fontFamily: "MaterialIcons")),
            Text("Celular"),
          ],
        ),
        value: "0xe4a3"),
    DropdownMenuItem(
        child: Row(
          children: const [
            Icon(IconData(0xea05, fontFamily: "MaterialIcons")),
            Text("Outros"),
          ],
        ),
        value: "0xea05"),
  ];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    if (args.expenses != null) {
      descriptionController.text = args.expenses!.text;
      valueController.text = args.expenses!.value.toString();
      _type = args.expenses!.type;
      selectedValue = args.expenses!.icon;
      color = args.expenses!.color;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text("Tipo"),
            ),
            GestureDetector(
              onTap: () => setState(() => _type = MoneyType.GASTO),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: _type == MoneyType.GASTO ? Colors.grey : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Radio<MoneyType>(
                      value: MoneyType.GASTO,
                      groupValue: _type,
                      onChanged: (MoneyType? value) {
                        setState(() {
                          _type = value!;
                        });
                      },
                    ),
                    const Text("Gasto")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _type = MoneyType.RECEBIMENTO),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: _type == MoneyType.RECEBIMENTO
                      ? Colors.grey
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Radio<MoneyType>(
                      value: MoneyType.RECEBIMENTO,
                      groupValue: _type,
                      onChanged: (MoneyType? value) {
                        setState(() {
                          _type = value!;
                        });
                      },
                    ),
                    const Text("Recebimento")
                  ],
                ),
              ),
            ),
            _type == MoneyType.GASTO
                ? Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: const Text("Categoria"),
                  )
                : Container(),
            _type == MoneyType.GASTO
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        elevation: 0,
                        items: dropdownItems,
                        value: selectedValue,
                        onChanged: (String? value) {
                          setState(() => selectedValue = value!);
                        },
                      ),
                    ),
                  )
                : Container(),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              child: const Text("Descrição"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                controller: descriptionController,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              child: const Text("Valor"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                controller: valueController,
                keyboardType: TextInputType.number,
                inputFormatters: [formatter],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              child: const Text("Cor"),
            ),
            ColorPickerSlide(MediaQuery.of(context).size.width * .8, color, setColor, _colorSliderPosition),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  if (args.expenses != null) {
                    final expense = Expenses(
                      id: args.expenses!.id,
                      icon: selectedValue,
                      text: descriptionController.text,
                      value: formatter.getUnformattedValue().toDouble(),
                      type: _type,
                      color: color,
                    );
                    args.handleElement(expense);
                    Navigator.of(context).pop();
                    return;
                  }
                  final expenses = Expenses(
                    id: const Uuid().v4(),
                    icon: selectedValue,
                    text: descriptionController.text,
                    value: formatter.getUnformattedValue().toDouble(),
                    type: _type,
                    color: color
                  );
                  args.handleElement(expenses);
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Salvar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
