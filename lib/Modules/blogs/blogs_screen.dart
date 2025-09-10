import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Themes/app_colors_theme.dart';
import '../../Themes/app_text_theme.dart';
import '../../model/blog_model.dart';
import 'blogs_controller.dart';

class BlogsScreen extends StatefulWidget {
  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  final BlogsController blogsController = Get.put(BlogsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Health Articles',
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.blackColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 2.h),
          
          // Articles List
          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              itemCount: blogsController.filteredBlogsList.length,
              itemBuilder: (context, index) {
                final blog = blogsController.filteredBlogsList[index];
                return blogCard(blog);
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget blogCard(BlogModel blog) {
    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Info
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primaryColor.withOpacity(0.1),
                  ),
                  child: ClipOval(
                    child: blog.authorImage != null && blog.authorImage!.isNotEmpty
                        ? Image.asset(
                            blog.authorImage!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildAuthorAvatar(blog.authorName ?? "");
                            },
                          )
                        : _buildAuthorAvatar(blog.authorName ?? ""),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog.authorName ?? "",
                        style: AppTextStyle.boldText.copyWith(
                          color: AppColor.blackColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        blog.authorSpecialization ?? "",
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.blackColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_horiz,
                  color: AppColor.blackColor.withOpacity(0.6),
                ),
              ],
            ),
          ),

          // Blog Image
          Container(
            height: 25.h,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.greyColor.withOpacity(0.2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: blog.image != null && blog.image!.isNotEmpty
                  ? Image.asset(
                      blog.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderImage();
                      },
                    )
                  : _buildPlaceholderImage(),
            ),
          ),

          // Blog Content
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Action Buttons Row
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => blogsController.toggleLike(blog),
                      child: Row(
                        children: [
                          Icon(
                            blog.isLiked! ? Icons.favorite : Icons.favorite_border,
                            color: blog.isLiked! ? Colors.red : AppColor.blackColor,
                            size: 20,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            blog.likes.toString(),
                            style: AppTextStyle.mediumText.copyWith(
                              color: AppColor.blackColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Row(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: AppColor.blackColor,
                          size: 20,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          blog.comments.toString(),
                          style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 6.w),
                    Row(
                      children: [
                        Icon(
                          Icons.share_outlined,
                          color: AppColor.blackColor,
                          size: 20,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          blog.bookmarks.toString(),
                          style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => blogsController.toggleBookmark(blog),
                      child: Icon(
                        blog.isBookmarked! ? Icons.bookmark : Icons.bookmark_border,
                        color: blog.isBookmarked! ? AppColor.primaryColor : AppColor.blackColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.w),

                // Blog Title and Content
                GestureDetector(
                  onTap: () => blogsController.openBlogDetail(blog),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog.authorName ?? "",
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.blackColor.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 1.w),
                      Text(
                        blog.title ?? "",
                        style: AppTextStyle.boldText.copyWith(
                          color: AppColor.blackColor,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.w),
                      Text(
                        blog.content ?? "",
                        style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.blackColor.withOpacity(0.7),
                          fontSize: 14,
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorAvatar(String name) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor,
            AppColor.primaryColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : "A",
          style: AppTextStyle.boldText.copyWith(
            color: AppColor.whiteColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.greyColor.withOpacity(0.3),
            AppColor.greyColor.withOpacity(0.1),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.image,
          color: AppColor.greyColor,
          size: 60,
        ),
      ),
    );
  }
}
