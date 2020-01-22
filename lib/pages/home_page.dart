import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/color.dart';
import 'package:flutter_shop/config/index.dart';
import 'package:flutter_shop/service/http_service.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> //不被刷新
    with
        AutomaticKeepAliveClientMixin {
  var _footerKey = GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: KColor.PRIMARY_COLOR,
      appBar: AppBar(
        title: Text(KString.HOME_TITLE),
      ),
      //防止重绘制
      body: FutureBuilder(
        builder: (context, covariant) {
          if (covariant.hasData) {
            var data = json.decode(covariant.data.toString());
            List<Map> swiperDataList = (data['data']['slides'] as List).cast();
            Map map = data['data']['floorPic'];

            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.grey,
                moreInfoColor: Colors.grey,
                showMore: true,
                noMoreText: '',
                moreInfo: KString.loading,
                loadReadyText: KString.loadReady,
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(
                    swiperDataList: swiperDataList,
                  )
                ],
              ),
              loadMore: () async {},
            );
          } else {
            return Container(
              child: Text("dsdsd"),
            );
          }
        },
        future: request('homePageContent'),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("首页刷新了！");
  }
}

class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (context, pos) {
          return InkWell(
            onTap: () {},
            child: Image.network(
              "${swiperDataList[pos]['image']}",
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
