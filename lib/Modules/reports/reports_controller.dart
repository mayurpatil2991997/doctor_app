import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/report_model.dart';
import '../../Utils/helper_method.dart';

class ReportsController extends GetxController {
  var isLoading = false.obs;
  var selectedTabIndex = 0.obs; // 0: My Reports, 1: Shared with Me
  var reportsList = <ReportItem>[].obs;
  var sharedReportsList = <ReportItem>[].obs;
  var filteredReportsList = <ReportItem>[].obs;
  var selectedFilter = 'All'.obs;
  var searchQuery = ''.obs;
  var isUploading = false.obs;

  // File picker
  final ImagePicker _imagePicker = ImagePicker();

  // Filter options
  final List<String> filterOptions = [
    'All',
    'Blood Test',
    'X-Ray',
    'MRI',
    'CT Scan',
    'Discharge Summary',
    'Prescription',
    'Lab Results',
    'Other',
  ];

  @override
  void onInit() {
    super.onInit();
    loadReports();
  }

  // Load reports data
  void loadReports() {
    isLoading.value = true;
    
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      // Mock data for My Reports
      reportsList.value = [
        ReportItem(
          id: '1',
          title: 'Blood Test Results',
          type: 'Blood Test',
          thumbnailUrl: 'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/blood_test_thumb.jpg',
          status: 'Pending Review',
          visibility: 'Visible to Doctor',
          uploadedBy: 'Dr. Carter',
          uploadDate: 'Aug 15',
          description: 'Complete blood count and metabolic panel results',
          tags: ['Blood Test', 'CBC', 'Metabolic Panel'],
          isShared: false,
        ),
        ReportItem(
          id: '2',
          title: 'X-Ray Scan',
          type: 'X-Ray',
          thumbnailUrl: 'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/xray_thumb.jpg',
          status: 'Reviewed',
          visibility: 'Visible to Patient',
          uploadedBy: 'Patient',
          uploadDate: 'Aug 10',
          description: 'Chest X-Ray scan results',
          tags: ['X-Ray', 'Chest', 'Radiology'],
          isShared: false,
        ),
        ReportItem(
          id: '3',
          title: 'Discharge Summary',
          type: 'Discharge Summary',
          thumbnailUrl: 'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/discharge_thumb.jpg',
          status: 'Reviewed',
          visibility: 'Private',
          uploadedBy: 'Dr. Harris',
          uploadDate: 'Aug 05',
          description: 'Hospital discharge summary and care instructions',
          tags: ['Discharge', 'Summary', 'Hospital'],
          isShared: false,
        ),
      ];

      // Mock data for Shared Reports
      sharedReportsList.value = [
        ReportItem(
          id: '4',
          title: 'MRI Scan Results',
          type: 'MRI',
          thumbnailUrl: 'https://pub-0a46c5ad172e478ea0a0ac45a6dbba68.r2.dev/mri_thumb.jpg',
          status: 'Reviewed',
          visibility: 'Shared',
          uploadedBy: 'Dr. Smith',
          uploadDate: 'Aug 12',
          description: 'Brain MRI scan results',
          tags: ['MRI', 'Brain', 'Neurology'],
          isShared: true,
          sharedWith: 'Dr. Johnson',
        ),
      ];

      applyFilters();
      isLoading.value = false;
    });
  }

  // Tab selection
  void selectTab(int index) {
    selectedTabIndex.value = index;
    applyFilters();
  }

  // Apply filters and search
  void applyFilters() {
    List<ReportItem> baseList = selectedTabIndex.value == 0 ? reportsList : sharedReportsList;
    
    var filtered = List<ReportItem>.from(baseList);
    
    // Apply type filter
    if (selectedFilter.value != 'All') {
      filtered = filtered.where((report) => 
        report.type?.toLowerCase() == selectedFilter.value.toLowerCase()
      ).toList();
    }
    
    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered.where((report) {
        final query = searchQuery.value.toLowerCase();
        return report.title?.toLowerCase().contains(query) == true ||
               report.description?.toLowerCase().contains(query) == true ||
               report.uploadedBy?.toLowerCase().contains(query) == true ||
               report.tags?.any((tag) => tag.toLowerCase().contains(query)) == true;
      }).toList();
    }
    
    filteredReportsList.value = filtered;
  }

  // Filter selection
  void selectFilter(String filter) {
    selectedFilter.value = filter;
    applyFilters();
  }

  // Search
  void searchReports(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  // Upload new report
  Future<void> uploadReport() async {
    try {
      // Show upload options
      Get.bottomSheet(
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Upload Report',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildUploadOption(
                      icon: Icons.camera_alt,
                      title: 'Camera',
                      onTap: () {
                        Get.back();
                        _pickFromCamera();
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildUploadOption(
                      icon: Icons.photo_library,
                      title: 'Gallery',
                      onTap: () {
                        Get.back();
                        _pickFromGallery();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildUploadOption(
                      icon: Icons.insert_drive_file,
                      title: 'Files',
                      onTap: () {
                        Get.back();
                        _pickFromFiles();
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildUploadOption(
                      icon: Icons.scanner,
                      title: 'Scan',
                      onTap: () {
                        Get.back();
                        _scanDocument();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    } catch (e) {
      showSnackBarError(message: 'Error showing upload options: ${e.toString()}');
    }
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.blue[600],
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Pick from camera
  Future<void> _pickFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      
      if (image != null) {
        await _processUploadedFile(File(image.path), 'Camera');
      }
    } catch (e) {
      showSnackBarError(message: 'Error picking from camera: ${e.toString()}');
    }
  }

  // Pick from gallery
  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (image != null) {
        await _processUploadedFile(File(image.path), 'Gallery');
      }
    } catch (e) {
      showSnackBarError(message: 'Error picking from gallery: ${e.toString()}');
    }
  }

  // Pick from files
  Future<void> _pickFromFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: false,
      );
      
      if (result != null && result.files.single.path != null) {
        await _processUploadedFile(File(result.files.single.path!), 'Files');
      }
    } catch (e) {
      showSnackBarError(message: 'Error picking files: ${e.toString()}');
    }
  }

  // Scan document (mock implementation)
  Future<void> _scanDocument() async {
    showSnackBarSuccess(message: 'Document scanning feature coming soon!');
  }

  // Process uploaded file
  Future<void> _processUploadedFile(File file, String source) async {
    isUploading.value = true;
    
    try {
      // Simulate upload process
      await Future.delayed(Duration(seconds: 2));
      
      // Create new report item
      final newReport = ReportItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'New Report from $source',
        type: 'Other',
        thumbnailUrl: null, // Would be set after upload
        status: 'Pending Review',
        visibility: 'Private',
        uploadedBy: 'You',
        uploadDate: _formatDate(DateTime.now()),
        description: 'Report uploaded from $source',
        tags: [source],
        isShared: false,
      );
      
      // Add to reports list
      reportsList.insert(0, newReport);
      applyFilters();
      
      showSnackBarSuccess(message: 'Report uploaded successfully!');
      
    } catch (e) {
      showSnackBarError(message: 'Error uploading report: ${e.toString()}');
    } finally {
      isUploading.value = false;
    }
  }

  // View report
  void viewReport(ReportItem report) {
    // Navigate to report viewer
    Get.toNamed('/report-viewer', arguments: report);
  }

  // Share report
  void shareReport(ReportItem report) {
    // Show share options
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Share Report',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person_add, color: Colors.blue),
              title: Text('Share with Doctor'),
              onTap: () {
                Get.back();
                _shareWithDoctor(report);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add, color: Colors.green),
              title: Text('Share with Patient'),
              onTap: () {
                Get.back();
                _shareWithPatient(report);
              },
            ),
            ListTile(
              leading: Icon(Icons.link, color: Colors.purple),
              title: Text('Generate Share Link'),
              onTap: () {
                Get.back();
                _generateShareLink(report);
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Share with doctor
  void _shareWithDoctor(ReportItem report) {
    showSnackBarSuccess(message: 'Report shared with doctor successfully!');
  }

  // Share with patient
  void _shareWithPatient(ReportItem report) {
    showSnackBarSuccess(message: 'Report shared with patient successfully!');
  }

  // Generate share link
  void _generateShareLink(ReportItem report) {
    showSnackBarSuccess(message: 'Share link generated successfully!');
  }

  // Format date
  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}';
  }

  // Clear search
  void clearSearch() {
    searchQuery.value = '';
    applyFilters();
  }

  // Refresh reports
  void refreshReports() {
    loadReports();
  }
}
