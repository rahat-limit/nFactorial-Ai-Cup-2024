import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionValidator extends StatelessWidget {
  final Widget child;
  const InternetConnectionValidator({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: InternetConnection().onStatusChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingChild();
          }
          if (!snapshot.hasData) {
            return errorChild();
          }
          switch (snapshot.data!) {
            case InternetStatus.disconnected:
              return errorChild();
            default:
              return child;
          }
        });
  }

  Widget loadingChild() {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget errorChild() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Отсутствует доступ к интернету!',
                style: AppFonts.w700s16,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                'Проверьте связь и попробуйте еще раз.',
                style: AppFonts.w500s14,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
