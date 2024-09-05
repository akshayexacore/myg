import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';

class TextinputfieldContainer extends StatefulWidget {
  final bool showIcon;
  final bool isEnable;
  final int ?maxline;
  final double ?verticalPadding;
  final bool isObscure;
  final String ?hintText;
  final TextEditingController? controller;
  final TextInputType ?keybordType;
  final IconData ? suffixIcon;
  final Widget ? suffix;
  final VoidCallback ? suffixIconOnclick;
  final VoidCallback ? onSubmitted;
  final VoidCallback ? onEditingComplete;
  final void Function(String)? onchange;
  final TextInputAction ? textInputAction;
  final FormFieldValidator ? validate;
  final double ? boxRadius;
  final Color ? boxRadiusColor;
  final FocusNode ? focusNode;
  final EdgeInsetsGeometry ? contentPadding;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> ? inputFormattor;


  const TextinputfieldContainer({super.key, required this.showIcon,  this.hintText,  this.controller,  this.keybordType, required this.isEnable,    this.suffixIcon, this.suffixIconOnclick, this.validate, required this.isObscure,  this.maxline, this.verticalPadding, this.boxRadius, this.boxRadiusColor, this.contentPadding, this.focusNode, this.onSubmitted, this.textInputAction, this.onchange, this.inputFormattor,this.onEditingComplete,this.suffix, this.textCapitalization = TextCapitalization.sentences});

  @override
  State<TextinputfieldContainer> createState() => _TextinputfieldContainerState();
}

class _TextinputfieldContainerState extends State<TextinputfieldContainer> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: widget.textCapitalization,
      controller: widget.controller,
      validator:   widget.validate,
      obscureText: widget.isObscure,
      enabled: widget.isEnable,
        textInputAction:widget.textInputAction ,
      focusNode: widget.focusNode,


      style: const TextStyle(color: Colors.black),
      maxLines: widget.maxline,
      cursorColor: primaryColor,
      decoration: InputDecoration(

        contentPadding:widget.contentPadding?? EdgeInsets.symmetric(
          horizontal: 16,
            vertical: widget.verticalPadding??0.0
        ),
        suffixIcon: widget.suffix ?? (widget.showIcon ? Bounce(
          onTap: widget.suffixIconOnclick,

          child: Icon(
             widget.suffixIcon,
            color: Colors.grey.shade600,

          ),
        ):SizedBox()),
        hintText: widget.hintText,
        hintStyle: hintTextStyle(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.boxRadius??10.0),
          borderSide:  BorderSide(color: Colors.grey.shade400),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.boxRadius??10.0),
          borderSide:  BorderSide(color: primaryColor),
        ),
        focusColor: primaryColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.boxRadius??10.0),
          borderSide:  BorderSide(color: primaryColor),
        ),

    ),
      keyboardType: widget.keybordType,
      inputFormatters: widget.inputFormattor,
    //   onSubmitted: (v){
    //     onSubmitted;
    //
    // },

      onChanged: widget.onchange,
        onEditingComplete: widget.onEditingComplete,
      onTapOutside: (event){
        widget.onEditingComplete?.call();
      },


    );
  }
}



