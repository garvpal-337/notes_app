import 'package:flutter/material.dart';
import 'package:notes_assignment/constants/constants.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton(
      {required this.onTap,
      required this.lable,
      this.loading = false,
      this.color = myPrimaryColor,
      this.height = 53.0,
      this.width = double.infinity,
      this.labelsize = 17.0,
      this.tapable = true,
      this.isAtBottom = false,
      this.labelColor = Colors.white,
      this.borderColor = Colors.transparent,
      this.loaderColor = Colors.white,
      this.showShadow = false,
      this.borderRadius = 8,
      this.margin = EdgeInsets.zero,
      this.icon,
      this.iconAtFront = true,
      this.labelStyle,
      this.subtitle,
      super.key});

  final void Function()? onTap;
  final String lable;
  final bool loading;
  final Color color;
  final double height;
  final double width;
  final bool showShadow;
  final double labelsize;
  final bool tapable;
  final bool isAtBottom;
  final Color labelColor;
  final Color borderColor;
  final Color loaderColor;
  final double borderRadius;
  final EdgeInsets margin;
  final Widget? subtitle;
  final Widget? icon;
  final bool iconAtFront;
  final TextStyle? labelStyle;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool tapped = false;
  
  @override
  Widget build(BuildContext context) {
   
    return Container(
      margin:  widget.isAtBottom ? const EdgeInsets.only(bottom: 15,right: 15,left: 15,top: 0)  :
      widget.margin,
      child: InkWell(
        onHighlightChanged: (change) {
          setState(() {
            tapped = change;
          });
        },
        highlightColor: Colors.white,
        onTap: widget.loading
            ? null
            : widget.tapable
                ? widget.onTap
                : null,
        child: Container(
          height: widget.height,
          width: widget.width,
          alignment: Alignment.center,
          padding: tapped
              ? const EdgeInsets.symmetric(horizontal: 4, vertical: 2)
              : null,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(double.parse('${widget.borderRadius}')),
          ),
          child: Container(
            height: tapped ? widget.height - 0 : widget.height,
            width: tapped ? widget.width - 0 : widget.width,
            decoration: BoxDecoration(
                color: widget.tapable ? widget.color : Colors.grey.withOpacity(0.3),
                border: Border.all(color: widget.borderColor),
                borderRadius: BorderRadius.circular(
                    double.parse('${widget.borderRadius}')),
                boxShadow: widget.showShadow
                    ? const  [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 15,
                        )
                      ]
                    : null),
            alignment: Alignment.center,
            child: widget.loading
                ? Container(
                    height: double.parse('${widget.height}'),
                    width: double.parse('${widget.height}'),
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: widget.loaderColor,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.iconAtFront) widget.icon ?? Container(),
                      if (widget.iconAtFront && widget.icon != null)
                        const SizedBox(
                          width: 8,
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.lable,
                            style: widget.labelStyle ??
                                TextStyle(
                                    fontFamily: 'Urbanist',
                                    color: widget.tapable
                                        ? widget.labelColor
                                        : Colors.grey,
                                    fontSize:
                                        double.parse('${widget.labelsize}')),
                          ),
                          widget.subtitle != null
                              ? const SizedBox(
                                  height: 6,
                                )
                              : const SizedBox(),
                          widget.subtitle ?? const SizedBox()
                        ],
                      ),
                      if (!widget.iconAtFront && widget.icon != null)
                        const SizedBox(
                          width: 8,
                        ),
                      if (!widget.iconAtFront) widget.icon ?? Container(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
