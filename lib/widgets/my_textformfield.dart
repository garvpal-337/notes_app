import 'package:flutter/material.dart';
import 'package:notes_assignment/constants/constants.dart';


class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key,
      this.textEditingController,
      this.hintText = '',
      this.readOnly = false,
      this.initialValue,
      this.validator,
      this.onChanged,
      this.onSave,
      this.maxLine = 1,
      this.maxLenght,
      this.keyboardType = TextInputType.name,
      this.textInputAction = TextInputAction.done,
     
      this.label = ''});

  final TextEditingController? textEditingController;
  final String hintText;
  final String label;
  final int maxLine;
  final int? maxLenght;
  final String? Function(String? value)? validator;
  final String? Function(String? value)? onChanged;
  final String? Function(String? value)? onSave;
  final String? initialValue;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool readOnly;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != '')
            Text(
              label,
              style: const TextStyle(fontSize: 15),
            ),
          const SizedBox(
            height: 10,
          ),
          
            Container(
              height: maxLine > 1 ? null : 50,
              margin: const EdgeInsets.fromLTRB(2, 2, 2, 0),
              decoration: BoxDecoration(
                  color: myWhite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: myPrimaryColor)),
              child: TextFormField(
                initialValue: initialValue,
                maxLines: maxLine,
                
                keyboardType: keyboardType,
                enabled: !readOnly,
                controller: textEditingController,
                textInputAction: textInputAction,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 15, vertical: maxLine > 1 ? 10 : 1),
                  border: InputBorder.none,
                  hintText: hintText,
                ),
                maxLength: maxLenght,
                validator: validator ??
                    (value) {
                      return null;
                    },
                onChanged: onChanged ?? (value) {},
                onSaved: onSave ?? (value) {},
              ),
            ),
          
        ],
      ),
    );
  }
}
