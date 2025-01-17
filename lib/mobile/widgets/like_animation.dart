import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {

  final Widget child;
  final Duration duration;
  bool isAnimating;
  final bool smallLike;
  final Function? onEnd;

  LikeAnimation({Key? key,required this.child,this.duration=const Duration(milliseconds: 150),required this.isAnimating,this.smallLike=false,this.onEnd}) : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    controller=AnimationController(vsync: this,duration: Duration(milliseconds: widget.duration.inMilliseconds~/2));
    scale=Tween<double>(begin:1,end: 1.2).animate(controller);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    if(widget.isAnimating!=oldWidget.isAnimating){
      startAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }
  startAnimation() async{
    if(widget.isAnimating||widget.smallLike){
      await controller.forward();
      await controller.reverse();
      await Future.delayed(Duration(milliseconds: 200));

      if(widget.onEnd!=null){
        widget.onEnd!();
      }
    }
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: scale,
    child: widget.child,
    );
  }
}
