import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/core/widgets/custom_app_bar.dart';
import 'package:doc_doc/core/widgets/custom_text_button.dart';
import 'package:doc_doc/modules/users/features/doctor_details/logic/cubit/doctor_details_cubit.dart';
import 'package:doc_doc/modules/users/features/doctor_details/ui/widgets/doctors_details_about_view.dart';
import 'package:doc_doc/modules/users/features/doctor_details/ui/widgets/doctors_details_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsiveWidth(24),
            vertical: responsiveHeight(16),
          ),
          child: SafeArea(
            child: CustomTextButton(
              text: 'Make An Appointment',
              onPressed: () {},
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
            builder: (final context, final state) {
              if (state is DoctorDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is DoctorDetailsError) {
                return Center(child: Text(state.error.messageKey));
              } else if (state is DoctorDetailsSuccess) {
                final doctorData = state.doctor;
                return Column(
                  children: [
                    const CustomAppBar(title: 'Doctor Details'),
                    verticalSpacing(4),
                    DoctorsDetailsHeader(doctor: doctorData),
                    verticalSpacing(24),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveWidth(8),
                      ),
                      child: TabBar(
                        labelStyle: AppTextStyles.font14Bold,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: AppColors.primary300,
                        dividerColor: context.customColors.divider,
                        indicatorColor: AppColors.primary300,
                        tabs: const [
                          Tab(text: 'About'),
                          Tab(text: 'Location'),
                          Tab(text: 'Reviews'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          DoctorsDetailsAboutView(doctor: doctorData),
                          const Center(child: Text('Soon')),
                          const Center(child: Text('Soon')),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
