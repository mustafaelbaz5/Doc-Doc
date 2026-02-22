import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/router/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../core/themes/app_text_styles.dart';
import '../../../../../../../core/utils/spacing.dart';
import '../../../logic/cubit/home_cubit.dart';
import 'doctor_recommendation_list_view.dart';
import 'doctors_shimmer_loading.dart';

class HomeRecommendationDoctor extends StatelessWidget {
  const HomeRecommendationDoctor({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "home.recommended_doctors".tr(),
              style: AppTextStyles.font18SemiBold,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                context.pushNamed(Routes.recommendationDoctorScreen);
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
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (final context, final state) {
              if (state is SpecializationsLoading) {
                return const DoctorsShimmerLoading();
              } else if (state is SpecializationsSuccess &&
                  state.doctorsList != null) {
                return DoctorRecommendationListView(
                  doctors: state.doctorsList!,
                );
              } else if (state is SpecializationsFailure) {
                return Center(child: Text(state.error.messageKey.tr()));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
