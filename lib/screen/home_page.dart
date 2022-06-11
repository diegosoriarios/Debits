import 'package:debits/controllers/home_controller.dart';
import 'package:debits/models/expenses.dart';
import 'package:debits/screen/debit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatelessWidget {
  final controller = HomeController();

  HomePage({Key? key}) : super(key: key) {
    controller.sumAllExpenses();
  }

  void createNewElement(Expenses element) {
    controller.addNewItem(element);
    controller.sumAllExpenses();
  }

  void updateElement(Expenses expense) {
    controller.updateListItems(expense);
    controller.sumAllExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: Observer(builder: (_) {
                return Text("R\$ ${controller.total}");
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(
          '/form',
          arguments: ScreenArguments(createNewElement, null),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () => Navigator.of(context).pushNamed('/'),
            ),
            ListTile(
              title: const Text('Graficos'),
              onTap: () => Navigator.of(context).pushNamed('/chart'),
            ),
            ListTile(
              title: const Text('Meus Dados'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Observer(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            ...controller.listItems.map(
              (e) => Slidable(
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      flex: 1,
                      onPressed: (_) {
                        Navigator.of(context).pushNamed(
                          '/form',
                          arguments: ScreenArguments(updateElement, e),
                        );
                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: "Edit",
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      flex: 1,
                      onPressed: (_) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              content: Text(
                                  "Are you sure you want to delete ${e.text}?"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            );
                          },
                        );
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: "Remove",
                    ),
                  ],
                ),
                key: Key(e.text),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    tileColor: e.color,
                    leading: Icon(IconData(int.parse(e.icon),
                        fontFamily: "MaterialIcons")),
                    title: Text(e.text),
                    trailing: Text(e.value.toString()),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
