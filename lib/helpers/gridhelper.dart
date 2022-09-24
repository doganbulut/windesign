import 'package:pluto_grid/pluto_grid.dart';

class GridHelper {
  static PlutoRow rowByColumns(List<PlutoColumn> columns) {
    final cells = <String, PlutoCell>{};

    columns.forEach((PlutoColumn column) {
      cells[column.field] = PlutoCell(
        value: (PlutoColumn element) {
          if (element.type.isNumber)
            return 0;
          else if (element.type.isSelect)
            return (element.type.select.items.toList()..shuffle()).first;
          else if (element.type.isDate)
            return DateTime.now().toString();
          else if (element.type.isTime)
            return '00:00';
          else
            return '';
        }(column),
      );
    });

    return PlutoRow(cells: cells);
  }
}
