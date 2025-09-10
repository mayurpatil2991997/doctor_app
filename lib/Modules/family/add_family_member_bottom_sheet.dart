import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../model/family_member_model.dart';
import 'family_controller.dart';

class AddFamilyMemberBottomSheet extends StatefulWidget {
  final FamilyMemberModel? memberToEdit;
  
  const AddFamilyMemberBottomSheet({Key? key, this.memberToEdit}) : super(key: key);

  @override
  State<AddFamilyMemberBottomSheet> createState() => _AddFamilyMemberBottomSheetState();
}

class _AddFamilyMemberBottomSheetState extends State<AddFamilyMemberBottomSheet> {
  final FamilyController familyController = Get.find<FamilyController>();
  final formKey = GlobalKey<FormState>();
  
  // Form controllers
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  
  // Selected values
  String selectedRelationship = 'Self';
  String selectedGender = 'M';
  
  // Available relationships
  final List<String> relationships = [
    'Self', 'Mother', 'Father', 'Wife', 'Husband', 
    'Son', 'Daughter', 'Brother', 'Sister', 'Grandfather', 
    'Grandmother', 'Uncle', 'Aunt', 'Cousin', 'Other'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.memberToEdit != null) {
      _prefillData();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }

  void _prefillData() {
    final member = widget.memberToEdit!;
    nameController.text = member.name ?? '';
    mobileController.text = member.phoneNumber ?? '';
    dateOfBirthController.text = member.dateOfBirth ?? '';
    selectedRelationship = member.relationship ?? 'Self';
    selectedGender = member.gender ?? 'M';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 4.w,
            right: 4.w,
            top: 2.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 2.h,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.only(bottom: 2.h),
                    decoration: BoxDecoration(
                      color: AppColor.greyColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                
                // Header
                headerSection(),
                SizedBox(height: 3.h),
                
                // Name Field
                nameField(),
                SizedBox(height: 2.h),
                
                // Relationship Section
                relationshipSection(),
                SizedBox(height: 2.h),
                
                // Mobile Number Field
                mobileField(),
                SizedBox(height: 2.h),
                
                // Date of Birth Field
                dateOfBirthField(),
                SizedBox(height: 2.h),
                
                // Gender Section
                genderSection(),
                SizedBox(height: 4.h),
                
                // Add Button
                addButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.memberToEdit != null ? 'Edit Family Member Details' : 'Add Family Member Details',
          style: AppTextStyle.boldText.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.greyColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget nameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: AppTextStyle.mediumText.copyWith(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: nameController,
          style: AppTextStyle.mediumText.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: 'Full Name',
            hintStyle: AppTextStyle.mediumText.copyWith(
              color: AppColor.greyColor,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.greyColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget relationshipSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Relations',
          style: AppTextStyle.mediumText.copyWith(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          height: 6.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: relationships.length,
            itemBuilder: (context, index) {
              final relationship = relationships[index];
              final isSelected = selectedRelationship == relationship;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRelationship = relationship;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 2.w),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.primaryColor : AppColor.greyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColor.primaryColor : AppColor.greyColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      relationship,
                      style: AppTextStyle.mediumText.copyWith(
                        color: isSelected ? AppColor.whiteColor : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget mobileField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile Number',
          style: AppTextStyle.mediumText.copyWith(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: mobileController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          style: AppTextStyle.mediumText.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: 'Enter Number',
            hintStyle: AppTextStyle.mediumText.copyWith(
              color: AppColor.greyColor,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.greyColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            counterText: '',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter mobile number';
            }
            if (value.length != 10) {
              return 'Please enter valid 10-digit number';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget dateOfBirthField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of Birth',
          style: AppTextStyle.mediumText.copyWith(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: dateOfBirthController,
          readOnly: true,
          onTap: () => _selectDate(),
          style: AppTextStyle.mediumText.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: 'DD / MM / YYYY',
            hintStyle: AppTextStyle.mediumText.copyWith(
              color: AppColor.greyColor,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.greyColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            suffixIcon: GestureDetector(
              onTap: () => _selectDate(),
              child: Icon(
                Icons.calendar_today,
                color: AppColor.greyColor,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select date of birth';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget genderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: AppTextStyle.mediumText.copyWith(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedGender = 'M';
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                    color: selectedGender == 'M' ? AppColor.primaryColor : AppColor.greyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedGender == 'M' ? AppColor.primaryColor : AppColor.greyColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: selectedGender == 'M' ? AppColor.whiteColor : Colors.black,
                        size: 30,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'M',
                        style: AppTextStyle.mediumText.copyWith(
                          color: selectedGender == 'M' ? AppColor.whiteColor : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedGender = 'F';
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                    color: selectedGender == 'F' ? AppColor.primaryColor : AppColor.greyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedGender == 'F' ? AppColor.primaryColor : AppColor.greyColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: selectedGender == 'F' ? AppColor.whiteColor : Colors.black,
                        size: 30,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'F',
                        style: AppTextStyle.mediumText.copyWith(
                          color: selectedGender == 'F' ? AppColor.whiteColor : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget addButton() {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.memberToEdit != null ? 'Update Family Member' : 'Add Family Member',
              style: AppTextStyle.mediumText.copyWith(
                color: AppColor.whiteColor,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: AppColor.whiteColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 20)), // Default to 20 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        dateOfBirthController.text = DateFormat('dd / MM / yyyy').format(picked);
      });
    }
  }

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      if (widget.memberToEdit != null) {
        // Update existing member
        final updatedMember = FamilyMemberModel(
          memberId: widget.memberToEdit!.memberId,
          name: nameController.text.trim(),
          relationship: selectedRelationship,
          phoneNumber: mobileController.text.trim(),
          dateOfBirth: dateOfBirthController.text.trim(),
          gender: selectedGender,
          isActive: true,
          createdDate: widget.memberToEdit!.createdDate,
          updatedDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        );
        
        familyController.updateFamilyMember(updatedMember);
      } else {
        // Add new member
        final member = FamilyMemberModel(
          memberId: DateTime.now().millisecondsSinceEpoch,
          name: nameController.text.trim(),
          relationship: selectedRelationship,
          phoneNumber: mobileController.text.trim(),
          dateOfBirth: dateOfBirthController.text.trim(),
          gender: selectedGender,
          isActive: true,
          createdDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        );
        
        familyController.addFamilyMemberToList(member);
      }
      
      // Reset form for next use
      _resetForm();
    }
  }

  void _resetForm() {
    nameController.clear();
    mobileController.clear();
    dateOfBirthController.clear();
    setState(() {
      selectedRelationship = 'Self';
      selectedGender = 'M';
    });
  }
}
