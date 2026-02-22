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
  void initState() {
    super.initState();
    context.read<AllDoctorsCubit>().getAllDoctors();
    context.read<FilterDataCubit>().loadFilterData();
  }

  void _applyFilter() {
    context.read<AllDoctorsCubit>().filterDoctors(
      specializationId: _selectedSpecializationId,
      cityId: _selectedCityId,
    );
  }

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
                final specializations = state is FilterDataLoaded
                    ? state.specializations.map((final e) => e.name).toList()
                    : <String>[];
                final cities = state is FilterDataLoaded
                    ? state.cities.map((final e) => e.name).toList()
                    : <String>[];

                return AllDoctorsTopBar(
                  controller: _searchController,
                  onSearchChanged: (final query) =>
                      context.read<AllDoctorsCubit>().searchDoctors(query),
                  specializations: specializations,
                  cities: cities,
                  prices: const ['< 100', '100 - 200', '200 - 300', '> 300'],
                  selectedSpecialization: _selectedSpecializationName,
                  selectedCity: _selectedCityName,
                  selectedPrice: _selectedPrice,
                  onSpecializationChanged: (final val) {
                    if (state is FilterDataLoaded && val != null) {
                      final match = state.specializations.firstWhere(
                        (final e) => e.name == val,
                      );
                      setState(() {
                        _selectedSpecializationName = match.name;
                        _selectedSpecializationId = match.id.toString();
                      });
                    } else {
                      setState(() {
                        _selectedSpecializationName = null;
                        _selectedSpecializationId = null;
                      });
                    }
                    _applyFilter();
                  },
                  onCityChanged: (final val) {
                    if (state is FilterDataLoaded && val != null) {
                      final match = state.cities.firstWhere(
                        (final e) => e.name == val,
                      );
                      setState(() {
                        _selectedCityName = match.name;
                        _selectedCityId = match.id.toString();
                      });
                    } else {
                      setState(() {
                        _selectedCityName = null;
                        _selectedCityId = null;
                      });
                    }
                    _applyFilter();
                  },
                  onPriceChanged: (final val) {
                    setState(() => _selectedPrice = val);
                    context.read<AllDoctorsCubit>().filterByPrice(val);
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
