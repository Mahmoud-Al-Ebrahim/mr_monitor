import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_monitor3/presentation/doctor_pages/single_doctor_widget.dart';

import '../../business_logic/doctor_cubit/doctor_cubit.dart';
import '../../core/colors.dart';
import '../../data/language_code_helper/app_localizations.dart';
import '../../data/models/doctor_model.dart';
import '../doctor_pages/detail_doctor_page.dart';

class AllDoctorsModule extends StatefulWidget{
  @override
  State<AllDoctorsModule> createState() => _AllDoctorsModuleState();
}

class _AllDoctorsModuleState extends State<AllDoctorsModule> {
  final _searchTextController=TextEditingController();
  late List<Doctor> allDoctors;
  late List<Doctor> searchedForDoctors;
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(
       child: Container(
         width: double.infinity,
         child: Padding(
           padding: const EdgeInsets.all(10.0),
           child: SingleChildScrollView(
             child: Column(
               children: [
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.baseline,
                   textBaseline: TextBaseline.alphabetic,
                   children: [
                     IconButton(
                         onPressed: () => Navigator.of(context).pop(),
                         icon: const Icon(
                           Icons.arrow_back_ios_new_outlined,
                           size: 30,
                           color: primaryColor,
                         )),
                     SizedBox(
                       width: 80,
                     ),
                     Text(
                       AppLocalizations.of(context)!.translate("all_doctors_msg"),
                       style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.w900,
                           fontSize: 30),
                     ),
                     Spacer()
                   ],
                 ),
                 SizedBox(
                   height: 50,
                 ),
                 _buildSearchField(context),
                 SizedBox(
                   height: 30,
                 ),
                 buildBlocWidget(),
               ],
             ),
           ),
         ),
       ),
     ),
   );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      controller: _searchTextController,
      cursorColor: primaryColor,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: primaryColor,
        ),
        hintText: AppLocalizations.of(context)!.translate("find_msg"),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: primaryColor
            ),
            borderRadius: BorderRadius.circular(20)
        ),
      ),
      style: const TextStyle(color: Colors.grey, fontSize: 18),
      onChanged: (searchedDoctor) {
        addSearchedForItemsToSearchedList(searchedDoctor);
      },
    );
  }
  void addSearchedForItemsToSearchedList(String searchedDoctor) {
    searchedForDoctors = allDoctors
        .where((doctor) =>
        doctor.doctorName.toLowerCase().contains(searchedDoctor))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    BlocProvider.of<DoctorCubit>(context).getAllDoctors();
    super.initState();
  }
  Widget buildBlocWidget() {
    return BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state is DoctorsLoaded) {
            allDoctors = (state).doctors;
            return buildLoadedListWidgets();
          } else {
            return showLoadingIndicator();
          }
        });
  }
  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: primaryColor,
      ),
    );
  }
  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildDoctorsList(),
        ],
      ),
    );
  }
  Widget buildDoctorsList() {
    return    ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding:EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context,index)=>
          InkWell(
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailDoctorPage(
                  doctor: _searchTextController.text.isEmpty? allDoctors[index]:searchedForDoctors[index]
              ))),
              child: SingleDoctorWidget(
                doctor:_searchTextController.text.isEmpty? allDoctors[index]:searchedForDoctors[index],
              )),
      separatorBuilder: (context,index)=>SizedBox(height: 20,),
      itemCount:_searchTextController.text.isEmpty? allDoctors.length:searchedForDoctors.length,
    );
  }

}