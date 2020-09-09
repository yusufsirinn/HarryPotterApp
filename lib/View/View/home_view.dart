import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:harrypotterapp/Core/Components/FutureBuilder/http_future_builder.dart';
import 'package:harrypotterapp/View/Components/bottom_sheet_panel_body.dart';
import 'package:harrypotterapp/Core/Extension/context_extension.dart';
import 'package:harrypotterapp/Core/Extension/string_extension.dart';
import 'package:harrypotterapp/Core/Service/Network/Response/response_model.dart';
import 'package:harrypotterapp/View/Components/list_tile_charters.dart';
import 'package:harrypotterapp/View/Model/hp_c.dart';
import 'package:harrypotterapp/View/View/detail_view.dart';
import 'package:harrypotterapp/View/ViewModel/home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  HomeViewModel viewModel = HomeViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        appBar: buildAppBar(),
        body: buildBody(context),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: context.theme.primaryColor,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _globalKey.currentState.showBottomSheet(
            (context) => BottomSheetPanelBody(),
          );
        },
      ),
      title: Text(
        "characters".locale,
        style: context.textTheme.headline5
            .copyWith(color: context.theme.backgroundColor),
      ),
    );
  }

  SizedBox buildBody(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height,
      child: HttpFutureBuilder<ResponseModel<HPCharacters>>(
        future: viewModel.characters,
        onSucces: (data) {
          return buildList(data.list);
        },
      ),
    );
  }

  Widget buildList(List<HPCharacters> list) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          var character = list[index];
          return buildOpenContainer(character);
        });
  }

  OpenContainer<dynamic> buildOpenContainer(HPCharacters character) {
    return OpenContainer(
      closedColor: context.theme.backgroundColor,
      transitionDuration: Duration(milliseconds: 500),
      closedBuilder: (context, action) {
        return ListTileCharacter(character: character);
      },
      openBuilder: (context, action) {
        return DetailView(
          character: character,
        );
      },
    );
  }

  InkWell buildInkWell(HPCharacters character) {
    return InkWell(
      onTap: () {
        viewModel.navigateToDetailPage(character);
      },
      child: ListTileCharacter(character: character),
    );
  }
}
