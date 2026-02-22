import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/core/widgets/custom_app_bar.dart';
import 'package:doc_doc/core/widgets/doctor_list_view_card.dart';
import 'package:doc_doc/modules/users/features/all_doctors/logic/cubit/all_doctors/all_doctors_cubit.dart';
import 'package:doc_doc/modules/users/features/all_doctors/logic/cubit/filter_data/filter_data_cubit.dart';
import 'package:doc_doc/modules/users/features/all_doctors/ui/widgets/all_doctors_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key});

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  final TextEditingController _searchController = TextEditingController();

  String? _selectedSpecializationId;
  String? _selectedSpecializationName;
  String? _selectedCityId;
  String? _selectedCityName;
  String? _selectedPrice;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: 'Recommended Doctors'),
            verticalSpacing(16),
            BlocBuilder<FilterDataCubit, FilterDataState>(
              builder: (final context, final state) {
                final allDoctorsCubit = context.read<AllDoctorsCubit>();
                return AllDoctorsTopBar(
                  controller: _searchController,
                  onSearchChanged: (final query) =>
                      allDoctorsCubit.searchDoctors(query),
                  selectedSpecialization: _selectedSpecializationName,
                  selectedCity: _selectedCityName,
                  selectedPrice: _selectedPrice,
                  onApply: (final spec, final city, final price) {
                    final state = context.read<FilterDataCubit>().state;
                    if (state is FilterDataLoaded) {
                      final specMatch = spec != null
                          ? state.specializations.firstWhere(
                              (final e) => e.name == spec,
                            )
                          : null;
                      final cityMatch = city != null
                          ? state.cities.firstWhere((final e) => e.name == city)
                          : null;
                      setState(() {
                        _selectedSpecializationName = specMatch?.name;
                        _selectedSpecializationId = specMatch?.id.toString();
                        _selectedCityName = cityMatch?.name;
                        _selectedCityId = cityMatch?.id.toString();
                        _selectedPrice = price;
                      });
                    }
                    allDoctorsCubit
                        .filterDoctors(
                          specializationId: _selectedSpecializationId,
                          cityId: _selectedCityId,
                        )
                        .then((final _) {
                          allDoctorsCubit.filterByPrice(price);
                        });
                  },
                );
              },
            ),
            verticalSpacing(16),
            Expanded(
              child: BlocBuilder<AllDoctorsCubit, AllDoctorsState>(
                builder: (final context, final state) {
                  if (state is AllDoctorsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is AllDoctorsError) {
                    return Center(child: Text(state.error.messageKey));
                  }
                  if (state is AllDoctorsLoaded) {
                    if (state.doctors.isEmpty) {
                      return const Center(child: Text('No doctors found'));
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveWidth(16),
                      ),
                      itemCount: state.doctors.length,
                      separatorBuilder: (_, final _) => verticalSpacing(16),
                      itemBuilder: (final context, final index) =>
                          DoctorListViewCard(doctor: state.doctors[index]),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
