import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/blog_model.dart';

class BlogsController extends GetxController {
  var isLoading = false.obs;
  var blogsList = <BlogModel>[].obs;
  var filteredBlogsList = <BlogModel>[].obs;
  var selectedCategory = 'All'.obs;

  final categories = ['All', 'Health Tips', 'Medical News', 'Wellness', 'Prevention', 'Treatment'];

  @override
  void onInit() {
    super.onInit();
    loadBlogsData();
  }

  void loadBlogsData() {
    // Mock data matching screenshot
    blogsList.value = [
      BlogModel(
        blogId: 1,
        title: "The Importance of Regular Health Check-ups: Why They're Not Optional",
        subtitle: "Regular health check-ups are an essential part of maintaining good health",
        content: "Lorem ipsum dolor sit amet consectetur. Pulvinar libero phasellus a nisl et",
        authorName: "Dr. Neha Kale",
        authorImage: "assets/images/doctor1.jpg",
        authorSpecialization: "Pediatrician",
        publishedDate: "2024-01-15",
        readTime: "5 min read",
        image: "assets/images/doctor.png",
        category: "Health Tips",
        likes: 15,
        comments: 8,
        bookmarks: 12,
        isLiked: false,
        isBookmarked: false,
        tags: ["health", "checkup", "prevention"],
      ),
      BlogModel(
        blogId: 2,
        title: "Understanding Diabetes: Prevention and Management",
        subtitle: "A comprehensive guide to diabetes prevention and management",
        content: "Lorem ipsum dolor sit amet consectetur. Pulvinar libero phasellus a nisl et",
        authorName: "Dr. Neha Kale",
        authorImage: "assets/images/doctor1.jpg",
        authorSpecialization: "Pediatrician",
        publishedDate: "2024-01-10",
        readTime: "7 min read",
        image: "assets/images/doctorAppointment.png",
        category: "Medical News",
        likes: 23,
        comments: 15,
        bookmarks: 18,
        isLiked: true,
        isBookmarked: true,
        tags: ["diabetes", "prevention", "management"],
      ),
      BlogModel(
        blogId: 3,
        title: "Mental Health Awareness: Breaking the Stigma",
        subtitle: "Why mental health is just as important as physical health",
        content: "Lorem ipsum dolor sit amet consectetur. Pulvinar libero phasellus a nisl et",
        authorName: "Dr. Neha Kale",
        authorImage: "assets/images/doctor1.jpg",
        authorSpecialization: "Pediatrician",
        publishedDate: "2024-01-05",
        readTime: "6 min read",
        image: "assets/images/introImage1.png",
        category: "Wellness",
        likes: 31,
        comments: 22,
        bookmarks: 25,
        isLiked: false,
        isBookmarked: true,
        tags: ["mental health", "awareness", "wellness"],
      ),
    ];
    
    filteredBlogsList.value = blogsList;
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (category == 'All') {
      filteredBlogsList.value = blogsList;
    } else {
      filteredBlogsList.value = blogsList.where((blog) => blog.category == category).toList();
    }
  }

  void toggleLike(BlogModel blog) {
    blog.isLiked = !blog.isLiked!;
    if (blog.isLiked!) {
      blog.likes = blog.likes! + 1;
    } else {
      blog.likes = blog.likes! - 1;
    }
    blogsList.refresh();
    filteredBlogsList.refresh();
  }

  void toggleBookmark(BlogModel blog) {
    blog.isBookmarked = !blog.isBookmarked!;
    if (blog.isBookmarked!) {
      blog.bookmarks = blog.bookmarks! + 1;
    } else {
      blog.bookmarks = blog.bookmarks! - 1;
    }
    blogsList.refresh();
    filteredBlogsList.refresh();
  }

  void openBlogDetail(BlogModel blog) {
    // Navigate to blog detail screen
    Get.snackbar(
      "Blog Detail",
      "Opening: ${blog.title}",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
