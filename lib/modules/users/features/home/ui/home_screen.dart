import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/modules/users/features/home/data/models/specializations_response_body.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/doctors_blue_container.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/home_app_bar.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/home_doctor_specialty.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/home_recommendation_doctor.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeAppBar(),
            const DoctorsBlueContainer(),
            verticalSpacing(24),
            const HomeDoctorSpecialty(),
            verticalSpacing(24),
            // Give it fixed height or Expanded
            const Expanded(child: HomeRecommendationDoctor()),
          ],
        ),
      ),
    );
  }
}

// Simple fake doctor for UI testing
final List<Doctor> dummyRecommendedDoctors = [
  Doctor(
    id: 101,
    name: "Prof. Ahmed Mansour",
    email: "ahmed.mansour@hospital.eg",
    phone: "+20 100 123 4567",
    photo: "", // leave empty → will use gender-based asset
    gender: "male",
    address: "Downtown, Cairo",
    description: "Senior Cardiologist",
    degree: "Professor",
    specialization: SpecializationMini(id: 1, name: "Cardiology"),
    city: City(
      id: 1,
      name: "Cairo",
      governrate: Governrate(id: 1, name: "Cairo"),
    ),
    appointPrice: 450,
    startTime: "15:00:00",
    endTime: "21:00:00",
  ),
  Doctor(
    id: 102,
    name: "Dr. Sara Khaled",
    email: "sara.khaled@clinic.com",
    phone: "+20 101 987 6543",
    photo: "",
    gender: "female",
    address: "Maadi, Cairo",
    description: "Skin & Laser Specialist",
    degree: "Consultant",
    specialization: SpecializationMini(id: 2, name: "Dermatology"),
    city: City(
      id: 1,
      name: "Cairo",
      governrate: Governrate(id: 1, name: "Cairo"),
    ),
    appointPrice: 380,
    startTime: "14:00:00",
    endTime: "20:00:00",
  ),
  Doctor(
    id: 103,
    name: "Dr. Omar Hassan",
    email: "omar.hassan@med.eg",
    phone: "+20 112 345 6789",
    photo: "",
    gender: "male",
    address: "Nasr City",
    description: "Pediatric Neurologist",
    degree: "Specialist",
    specialization: SpecializationMini(id: 3, name: "Neurology"),
    city: City(
      id: 1,
      name: "Cairo",
      governrate: Governrate(id: 1, name: "Cairo"),
    ),
    appointPrice: 420,
    startTime: "16:00:00",
    endTime: "22:00:00",
  ),
  Doctor(
    id: 104,
    name: "Dr. Fatima Ali",
    email: "fatima.ali@hospital.com",
    phone: "+20 122 567 8901",
    photo: "",
    gender: "female",
    address: "Heliopolis",
    description: "Child Health Expert",
    degree: "Consultant",
    specialization: SpecializationMini(id: 5, name: "Pediatrics"),
    city: City(
      id: 1,
      name: "Cairo",
      governrate: Governrate(id: 1, name: "Cairo"),
    ),
    appointPrice: 350,
    startTime: "10:00:00",
    endTime: "18:00:00",
  ),
  Doctor(
    id: 105,
    name: "Prof. Khalid Samir",
    email: "khalid.samir@ortho.eg",
    phone: "+20 111 222 3333",
    photo: "",
    gender: "male",
    address: "Giza",
    description: "Joint & Spine Surgeon",
    degree: "Professor",
    specialization: SpecializationMini(id: 4, name: "Orthopedics"),
    city: City(
      id: 1,
      name: "Giza",
      governrate: Governrate(id: 1, name: "Giza"),
    ),
    appointPrice: 600,
    startTime: "17:00:00",
    endTime: "23:00:00",
  ),
];
