import 'package:flutter/material.dart';

class MyTextFormField extends InputDecoration {
  MyTextFormField(BuildContext context)
      : super(
          helperText: "",
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onTertiary,
            ),
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onTertiary,
            ),
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error, width: 2),
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error, width: 2),
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
        );
}

bool eyeClicked = true;
PasswordFieldDecoration({required BuildContext context, required state}) =>
    InputDecoration(
      suffixIcon: InkWell(
          onTap: () {
            eyeClicked = !eyeClicked;
            print(eyeClicked);
            state(() {});
            print(eyeClicked);
          },
          child: Icon(Icons.remove_red_eye_outlined)),
      // helperText: "",
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
    );
