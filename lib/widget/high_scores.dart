import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/constants/constants.dart';
import 'package:flutter_minesweeper/constants/strings.dart';
import 'package:flutter_minesweeper/model/models.dart';

class HighScores extends StatelessWidget {
  const HighScores({
    Key key,
    @required this.highScores,
  })  : assert(highScores != null),
        super(key: key);

  final List<HighScoreModel> highScores;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kHighScoreTableWidth,
      child: Card(
        child: DataTable(
          columns: <DataColumn>[
            DataColumn(label: const Text(kDifficulty), numeric: false),
            DataColumn(label: const Text(kTime), numeric: true),
          ],
          rows: highScores.map(
            (score) => DataRow(
              cells: <DataCell>[
                DataCell(Text(score.difficulty)),
                DataCell(Text('${score.time}')),
              ],
            ),
          ).toList(),
        ),
      ),
    );
  }
}
