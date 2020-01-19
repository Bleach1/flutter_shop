import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/index.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/member_page.dart';
import 'package:flutter_shop/provide/current_index_provide.dart';
import 'package:provide/provide.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), title: Text(KString.HOME_TITLE)),
    BottomNavigationBarItem(
        icon: Icon(Icons.category), title: Text(KString.CATEGORY_TITLE)),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        title: Text(KString.SHOPPING_CART_TITLE)),
    BottomNavigationBarItem(
        icon: Icon(Icons.person), title: Text(KString.MEMBER_CENTER_TITLE)),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Provide<CurrentIndexProvide>(
      builder: (context, child, index) {
        int currentIndex =
            Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: KColor.BG_COLOR,
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
