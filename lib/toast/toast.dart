import 'package:flutter/material.dart';

/// @desp: 利用overlay实现Toast  todo 会被输入法挡住
/// @time 2019/3/29 3:01 PM
/// @author chenyun
///
class Toast {
  static ToastView preToast;

  static show({BuildContext context, String message}) {
    preToast?.dismiss();
    preToast = null;

    OverlayState overlayState = Overlay.of(context);

    ///Toast显示的位移和渐显动画
    AnimationController controllerShowAnim = AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );
    AnimationController controllerShowOffset = AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 350),
    );

    ///Toast消失的渐隐动画
    AnimationController controllerHide = AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );

    Animation<double> opacityAnim1 =
        Tween(begin: 0.0, end: 1.0).animate(controllerShowAnim);

    ///位移动画
    CurvedAnimation controllerCurvedShowOffset = CurvedAnimation(
        parent: controllerShowOffset, curve: _BounceOutCurve._());
    Animation<double> offsetAnim =
        Tween(begin: 30.0, end: 0.0).animate(controllerCurvedShowOffset);
    Animation<double> opacityAnim2 =
        Tween(begin: 1.0, end: 0.0).animate(controllerHide);

    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return ToastWidget(
        opacityAnim1: opacityAnim1,
        opacityAnim2: opacityAnim2,
        offsetAnim: offsetAnim,
        child: buildToastLayout(message),
      );
    });
    var toastView = ToastView();
    toastView.overlayEntry = overlayEntry;
    toastView.controllerShowAnim = controllerShowAnim;
    toastView.controllerShowOffset = controllerShowOffset;
    toastView.controllerHide = controllerHide;
    toastView.overlayState = overlayState;
    preToast = toastView;
    toastView._show();
  }

  static LayoutBuilder buildToastLayout(String message) {
    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              child: Container(
                child: Text(
                  "${message}",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              margin: EdgeInsets.only(
                bottom: constraints.biggest.height * 0.15,
                left: constraints.biggest.width * 0.2,
                right: constraints.biggest.width * 0.2,
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    });
  }
}

class ToastView {
  OverlayEntry overlayEntry;
  AnimationController controllerShowAnim;
  AnimationController controllerShowOffset;
  AnimationController controllerHide;
  OverlayState overlayState;
  bool dismissed = false;

  _show() async {
    overlayState.insert(overlayEntry);
    controllerShowAnim.forward();
    controllerShowOffset.forward();
    await Future.delayed(Duration(milliseconds: 2000));
    this.dismiss();
  }

  dismiss() async {
    if (dismissed) {
      return;
    }
    this.dismissed = true;
    controllerHide.forward();
    await Future.delayed(Duration(milliseconds: 250));
    overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  final Widget child;
  final Animation<double> opacityAnim1;
  final Animation<double> opacityAnim2;
  final Animation<double> offsetAnim;

  ToastWidget(
      {this.child, this.offsetAnim, this.opacityAnim1, this.opacityAnim2});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacityAnim1,
      child: child,
      builder: (context, child_to_build) {
        return Opacity(
          opacity: opacityAnim1.value,
          child: AnimatedBuilder(
            animation: offsetAnim,
            builder: (context, _) {
              return Transform.translate(
                offset: Offset(0, offsetAnim.value),
                child: AnimatedBuilder(
                  animation: opacityAnim2,
                  builder: (context, _) {
                    return Opacity(
                      opacity: opacityAnim2.value,
                      child: child_to_build,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _BounceOutCurve extends Curve {
  const _BounceOutCurve._();

  @override
  double transform(double t) {
    t -= 1.0;
    return t * t * ((2 + 1) * t + 2) + 1.0;
  }
}

//class Toast {
//  static void show({@required BuildContext context, @required String message}) {
//    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
//      return Positioned(
//          top: MediaQuery.of(context).size.height * 0.7,
//          child:  Material(
//            child:  Container(
//              width: MediaQuery.of(context).size.width,
//              alignment: Alignment.center,
//              child:  Center(
//                child:  Card(
//                  child:  Padding(
//                    padding: EdgeInsets.all(8),
//                    child:  Text(message),
//                  ),
//                  color: Colors.grey,
//                ),
//              ),
//            ),
//          ));
//    });
//    Overlay.of(context).insert(overlayEntry);
//    Future.delayed(Duration(seconds: 2)).then((value) {
//      overlayEntry.remove();
//    });
//  }
//}
