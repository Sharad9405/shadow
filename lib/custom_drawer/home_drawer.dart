import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadow/config/config.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList> drawerList;

  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 40.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(
                            1.0 - (widget.iconAnimationController.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8)
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              // child: Image.asset('assets/images/userImage.png'),
                              child: Image.asset('assets/images/sharad.png'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      'Sharad',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.grey,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return inkWell(drawerList[index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Sign Out',
                  style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppTheme.darkText),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  print("Sign out functionality to be implement");
                  _openSignOutDialog(context);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

void  _openSignOutDialog(BuildContext ctx){
   showCupertinoDialog(
      context: ctx,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Confirm'),
        content: Text('You will be signed out from this device. Are you sure to Signout?'),
        actions: [
          // Conlose the dialog
          // You can use the CupertinoDialogAction widget instead
          CupertinoButton(
            child: Text('Cancel'),
            onPressed: (){
              // Navigator.of(ctx).pop();
              Navigator.of(ctx, rootNavigator: true).pop("Discard");
            },
          ),
          CupertinoButton(
            child: Text('Sign Out'),
            onPressed: (){
              // Navigator.of(ctx).pop();
              Navigator.of(ctx, rootNavigator: true).pop("Discard");
            },
          ),
        ],
      )
    );
  }

  Widget inkWell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigateToScreen(listData.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            listData.imageName,
                            color: widget.screenIndex == listData.index
                                ? Colors.blue
                                : AppTheme.nearlyBlack,
                          ),
                        )
                      : Icon(
                          listData.icon.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.blue
                              : AppTheme.nearlyBlack,
                        ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),

                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index ? Colors.blue : AppTheme.nearlyBlack
                    ),
                  )
                ],
              ),
            ),

            widget.screenIndex == listData.index
            ? AnimatedBuilder(
              animation: widget.iconAnimationController,
              builder: (BuildContext context, Widget child){
                return Transform(
                  transform: Matrix4.translationValues(
                      (MediaQuery.of(context).size.width * 0.75 - 64) * (1.0 - widget.iconAnimationController.value - 1.0),
                      0.0,
                      0.0
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75 - 64,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(28.0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(28.0)
                        ),
                      ),
                    ),
                  ),
                );
              },
            ): const SizedBox(),
          ],
        ),
      ),
    );
  }

  Future<void> navigateToScreen(DrawerIndex indexScreen) async{
    widget.callBackIndex(indexScreen);
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
          index: DrawerIndex.HOME, labelName: AppConstant.Home, icon: Icon(Icons.home)),
      DrawerList(
        index: DrawerIndex.PROFILE, labelName: AppConstant.Profile, icon: Icon(Icons.person),),
      DrawerList(
        index: DrawerIndex.MYWALLET, labelName: AppConstant.MyWallet, icon: Icon(Icons.account_balance_wallet),),

      DrawerList(
        index: DrawerIndex.REDEEM, labelName: AppConstant.Redeem, icon: Icon(Icons.redeem),),

      DrawerList(
        index: DrawerIndex.OFFERS, labelName: AppConstant.Offers, icon: Icon(Icons.local_offer_sharp),),

      DrawerList(
        index: DrawerIndex.FAQ, labelName: AppConstant.Faq, icon: Icon(Icons.help),),

      DrawerList(
        index: DrawerIndex.TENPLUSONEPLAN, labelName: AppConstant.TenPlusOnePlan, icon: Icon(Icons.queue_play_next),),

      DrawerList(
        index: DrawerIndex.MYGOLDMINE, labelName: AppConstant.MyGoldMines, icon: Icon(Icons.ring_volume),),


      // DrawerList(
      //   index: DrawerIndex.Invite,
      //   labelName: 'Invite Friend',
      //   icon: Icon(Icons.group),
      // ),
      // DrawerList(
      //   index: DrawerIndex.Share,
      //   labelName: 'Rate the app',
      //   icon: Icon(Icons.share),
      // ),
      // DrawerList(
      //   index: DrawerIndex.About,
      //   labelName: 'About Us',
      //   icon: Icon(Icons.info),
      // ),
    ];
  }
}

class DrawerList {
  DrawerList(
      {this.isAssetsImage = false,
      this.labelName = '',
      this.icon,
      this.index,
      this.imageName});

  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}

enum DrawerIndex { HOME, PROFILE, MYWALLET, REDEEM, OFFERS, FAQ, TENPLUSONEPLAN, MYGOLDMINE, Help, Share, About, Invite, Testing }
