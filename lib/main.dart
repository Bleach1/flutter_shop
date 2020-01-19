import 'package:flutter/material.dart';
import 'package:flutter_shop/config/index.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/provide/current_index_provide.dart';
import 'package:provide/provide.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();
  providers..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: IndexPage(),
        title: KString.MAIN_TITLE,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: KColor.PRIMARY_COLOR,
        ),
      ),
    );
  }
}
