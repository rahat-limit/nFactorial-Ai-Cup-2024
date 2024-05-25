import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfactorial_cup/helpers/app_colors.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_cubit.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_state.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlansCubit, PlanState>(builder: (context, state) {
      switch (state.menuStatus) {
        case OkMenuStatus():
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.menu.context.length,
            reverse: true,
            itemBuilder: (context, index) {
              var item = state.menu.context[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.explanation != null)
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: AppColors.errorBackgroundColor,
                            borderRadius: BorderRadius.circular(18),
                            border:
                                Border.all(color: AppColors.errorBorderColor)),
                        child: Row(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Image.asset('assets/pngs/Speaker.png',
                                    width: 35, height: 35)),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(item.explanation!,
                                    style: AppFonts.w700s10.copyWith(
                                      fontSize: 20,
                                    )))
                          ],
                        )),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 3.8,
                          width: MediaQuery.of(context).size.width / 3.8,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${item.title}, ${item.volume}, ${item.price}',
                                    style: AppFonts.w800s24.copyWith(
                                        fontFamily: 'BlinkerSemiBold'),
                                    textAlign: TextAlign.start),
                                Text(item.description,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFonts.w600s16
                                        .copyWith(color: AppColors.textGrey)),
                              ]),
                        )
                      ]),
                  const SizedBox(height: 20)
                ],
              );
              // ListTile(

              // title: Text('${item.title}, ${item.volume}',
              //     style: AppFonts.w700s20),
              // subtitle: Text(item.description,
              //     style: AppFonts.w600s14
              //         .copyWith(color: AppColors.textGrey)),
              //     trailing: Text(item.price, style: AppFonts.w800s24));
            },
          );
        case LoadingMenuStatus():
          return const Column(
            children: [
              SizedBox(height: 50),
              Center(child: CircularProgressIndicator())
            ],
          );
        default:
          return const SizedBox();
      }
    });
  }
}
