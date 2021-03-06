import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/models.dart';
import 'package:flutter_minesweeper/util/view_util.dart';
import 'package:flutter_minesweeper/widget/high_scores.dart';
import 'package:flutter_minesweeper/widget/widgets.dart';
import 'package:provider/provider.dart';

class MinesweeperScaffold extends StatelessWidget {
  const MinesweeperScaffold({
    Key key,
    @required this.themeModel,
  }) : super(key: key);

  final ThemeModel themeModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(
      builder: (context, model, _) {
        return Scaffold(
          appBar: PreferredSize(
            child: MinesweeperAppBar(gameModel: model, themeModel: themeModel),
            preferredSize: Size.fromHeight(kToolbarHeight),
          ),
          body: MinesweeperBody(model: model),
        );
      },
    );
  }
}

class MinesweeperBody extends StatelessWidget {
  const MinesweeperBody({
    Key key,
    @required this.model,
  })  : assert(model != null),
        super(key: key);

  final GameModel model;

  Widget _buildMobileLayout(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MinesweeperBoard(),
              GameInfo(),
              HighScores(highScores: model.highScores),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0) +
              const EdgeInsets.only(left: 32.0, right: 16.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MinesweeperBoard(),
                  GameInfo(
                    height: getTilePixelDimension(context) * model.rows + 24.0,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 64.0),
                child: HighScores(highScores: model.highScores),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isMobile(context)
        ? _buildMobileLayout(context)
        : _buildDesktopLayout(context);
  }
}
