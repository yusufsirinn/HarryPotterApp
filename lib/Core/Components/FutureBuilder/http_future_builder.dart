import 'package:flutter/material.dart';
import 'package:harrypotterapp/Core/Service/Network/Response/IResponseModel.dart';

class HttpFutureBuilder<T extends IResponseModel> extends StatelessWidget {
  final Future<T> future;
  final Function(T data) onSucces;

  const HttpFutureBuilder({
    Key key,
    @required this.future,
    @required this.onSucces,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (!snapshot.data.isSucces) {
            return Center(
              child: Text("${snapshot.data.error}"),
            );
          }
          return onSucces(snapshot.data);
        } else if (snapshot.hasError) {
          return Center(
            child: Text(" - ${snapshot.hasError}"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
