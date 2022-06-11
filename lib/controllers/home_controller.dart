import 'package:debits/models/expenses.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  double total = 0.0;

  @observable
  var listItems = ObservableList<Expenses>.of([
    Expenses(
      id: const Uuid().v4(),
      color: Colors.green,
      icon: "0xe4a3",
      type: MoneyType.RECEBIMENTO,
      text: "Salário",
      value: 10000.0,
    ),
    Expenses(
      id: const Uuid().v4(),
      color: Colors.red,
      icon: "0xe4a3",
      type: MoneyType.GASTO,
      text: "Comida",
      value: 150.0,
    ),
    Expenses(
      id: const Uuid().v4(),
      color: Colors.red,
      icon: "0xe4a3",
      type: MoneyType.GASTO,
      text: "Alugel",
      value: 500.0,
    )
  ]);

  @action
  addNewItem(Expenses element) {
    listItems.add(element);
    sumAllExpenses();
  }

  @action
  updateListItems(Expenses expense) {
    var index = listItems.indexWhere((element) => element.id == expense.id);
    if (index < 0) return;
    listItems[index] = expense;
    sumAllExpenses();
  }

  @action
  sumAllExpenses() {
    var totalExpenses = 0.0;
    for (var element in listItems) {
      totalExpenses += element.type == MoneyType.GASTO ? -element.value : element.value;
    }
    total = totalExpenses;
  }
}
