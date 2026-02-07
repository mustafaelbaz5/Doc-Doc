import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/router/routes.dart';
import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/modules/users/features/home/logic/cubit/home_cubit.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/doctor_specialty/home_specialty_list_view.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/doctor_specialty/specialty_shimmer_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDoctorSpecialty extends StatelessWidget {
  const HomeDoctorSpecialty({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "home.Doctor_specialty".tr(),
              style: AppTextStyles.font18SemiBold,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                context.pushNamed(Routes.doctorSpecialtyScreen);
              },
              child: Text(
                "home.see_all".tr(),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.primary300,
                ),
              ),
            ),
          ],
        ),
        verticalSpacing(16),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (final context, final state) {
            if (state is SpecializationsLoading) {
              return const SpecialtyShimmerLoading();
            } else if (state is SpecializationsSuccess) {
              return HomeSpecialtyListView(
                specializationList: state.specializations,
              );
            } else if (state is SpecializationsFailure) {
              return Center(child: Text(state.error.messageKey.tr()));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
