import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/modules/users/features/home/logic/cubit/home_cubit.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/doctor_recommendation/doctor_recommendation_list_view.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/doctor_recommendation/doctors_shimmer_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              onTap: () {},
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
                return Center(child: Text("${state.error}"));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
