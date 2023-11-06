import 'package:flutter/foundation.dart';
import 'package:instagram_clone_course/views/components/constants/strings.dart';
import 'package:instagram_clone_course/views/components/dialogs/alert_diaglog_model.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
          buttons: const {
            Strings.logOut: true,
            Strings.cancel: false,
          },
        );
}
