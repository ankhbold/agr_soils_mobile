import 'package:flutter/material.dart';
import 'package:mvvm/constants/colors.dart';

class Crop extends StatefulWidget {
  const Crop({super.key});

  @override
  State<Crop> createState() => _CropState();
}

class _CropState extends State<Crop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.Green,
                  size: 15,
                ),
                Text(
                  'Буцах',
                  style: TextStyle(color: AppColors.Green),
                ),
              ],
            ),
          ),
        ),
        actions: [],
        title: Text(
          'crop rotation',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(child: buildDataTable()),
    );
  }

  Widget buildDataTable() {
    final columns = ['First name', 'Last name', 'age'];
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(allUsers),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(label: Text(column));
    }).toList();
  }

  List<DataRow> getRows(List<User> users) => users.map((User user) {
        final cells = [user.firstName];
        return DataRow(
            cells: Utils.modelBuilder(cells, (index, cell) {
          return DataCell(Text('$cell'));
        }));
      }).toList();
}

class User {
  final String firstName;

  const User({
    required this.firstName,
  });

  User copy({
    String? firstName,
  }) =>
      User(
        firstName: firstName ?? this.firstName,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName;

  @override
  int get hashCode => firstName.hashCode;
}

final allUsers = <User>[
  User(firstName: 'Emma'),
  User(firstName: 'Max'),
  User(firstName: 'Sarah'),
  User(firstName: 'James'),
  User(firstName: 'Lorita'),
  User(firstName: 'Anton'),
  User(firstName: 'Salina'),
  User(firstName: 'Sunday'),
  User(firstName: 'Alva'),
  User(firstName: 'Jonah'),
  User(firstName: 'Kimberley'),
  User(firstName: 'Waldo'),
  User(firstName: 'Garret'),
  User(firstName: 'Margaret'),
  User(firstName: 'Foster'),
  User(firstName: 'Samuel'),
  User(firstName: 'Sam'),
  User(firstName: 'Alise'),
];

class Utils {
  static List<T> modelBuilder<M, T>(
          List<M> models, T Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}
