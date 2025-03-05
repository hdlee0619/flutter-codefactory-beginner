import 'package:flutter/material.dart';

import '/const/color.dart';

class CustomTextField extends StatelessWidget {
  final bool expanded;
  final String label;

  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    this.expanded = false,
    required this.label,
    required this.validator,
    required this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
        ),
        expanded
            ? Expanded(child: renderTextFormField())
            : renderTextFormField(),
      ],
    );
  }

  renderTextFormField() {
    return TextFormField(
      // 검증
      validator: validator,
      // 저장했을 때
      onSaved: onSaved,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
      ),
      cursorColor: Colors.grey,
      maxLines: expanded ? null : 1,
      minLines: expanded ? null : 1,
      expands: expanded,
    );
  }
}
