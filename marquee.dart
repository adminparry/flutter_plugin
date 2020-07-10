import 'dart:async';

import 'package:flutter/material.dart';

//文字滚动效果
class FontMarquee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FontMarqueeState();
  }
}

class FontMarqueeState extends State<FontMarquee> with WidgetsBindingObserver  {
  GlobalKey _myKey = new GlobalKey();
  ScrollController _controller;
  Timer timer;
  int start=0;
  int count = 4;

  double itemHeight = 20;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();

    timer.cancel();
  }

  @override
  void initState() {
    //来监听 节点是否build完成
    WidgetsBinding widgetsBinding=WidgetsBinding.instance;



    widgetsBinding.addPostFrameCallback((callback){


    });
    timer = Timer.periodic(Duration(seconds: 3), (timer){
      start++;

      _controller.animateTo(start * itemHeight, duration: Duration(seconds: 1), curve: Curves.easeOutSine).then((res){
        if(start == count ){
          _controller.jumpTo(_controller.position.minScrollExtent);
          start = 0;
        }
      });
      //滚动到底部从头开始

    });

    _controller = ScrollController();


    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Widget ret;



    ret = ListView.builder(
        key: _myKey,
        //禁止手动滑动
        physics: NeverScrollableScrollPhysics(),
        itemCount: count * 2,
        //item固定高度
        itemExtent: itemHeight,
        scrollDirection: Axis.vertical,
        controller: _controller,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Builder(builder: (context){
              Widget ret;

              ret= Text("【猎毒人】吕云鹏计划通楚天南中风下线？ ${index % count}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),);

              ret = GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return Dialog(child: Text("$index"));
                  });
                },
                child: ret,
              );
              return ret;
            }),
          );
        });

    ret = Container(
      height: itemHeight,
      child: ret,
    );

    ret = Center(child: ret,);
    return ret;
  }

}