import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/models.dart';
import 'package:flutter_minesweeper/util/view_util.dart';
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
          body: const MinesweeperBody(),
        );
      },
    );
  }
}

class MinesweeperBody extends StatelessWidget {
  const MinesweeperBody({Key key}) : super(key: key);

  Widget _buildMobileLayout(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MinesweeperBoard(),
              GameInfo(),
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
              EdgeInsets.only(left: 32.0, right: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MinesweeperBoard(),
              GameInfo(),
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
