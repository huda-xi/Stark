import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stark/core/app_colors.dart';
import 'package:stark/core/app_text_style.dart';
import 'package:stark/features/auth/presentation/customs/button_custom.dart';
import 'package:stark/features/details/presentation/cubit/details_cubit.dart';
import 'package:stark/features/details/presentation/cubit/details_states.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.detailsID});
  final String detailsID;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<DetailsCubit>().getdetails(widget.detailsID);
  }

  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsStates>(
      builder: (context, state) {
        if (state is DetailsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DetailsFailure) {
          return Center(child: Text(state.message));
        } else if (state is DetailsSuccess) {
          final detail = state.details;

          final String category = detail.categories.isNotEmpty
              ? detail.categories.first
              : 'Uncategorized';

          final String imageUrl = detail.pictureUrl.isNotEmpty
              ? detail.pictureUrl
              : (detail.productPictures.isNotEmpty
                    ? detail.productPictures.first
                    : '');
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.broken_image, size: 50),
                              );
                            },
                          )
                        : const Center(
                            child: Icon(Icons.image_not_supported, size: 50),
                          ),
                  ),

                  Positioned(
                    top: 20,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.chevron_left,
                        color: AppColors.background,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.background.withAlpha(100),
                      ),
                    ),
                  ),

                  DraggableScrollableSheet(
                    initialChildSize: 0.60,
                    minChildSize: 0.50,
                    maxChildSize: 0.90,
                    builder: (context, scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xffFAFAFA),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 45,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        255,
                                        211,
                                        209,
                                        209,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFF0ED),
                                        borderRadius: BorderRadius.circular(
                                          9999,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'brand',
                                          style: AppTextStyles.style12SemiBold
                                              .copyWith(color: AppColors.black),
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 15),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffF3F4F6),
                                        borderRadius: BorderRadius.circular(
                                          9999,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          category,
                                          style: AppTextStyles.style12SemiBold
                                              .copyWith(
                                                color: AppColors.rememberGrey,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Text(
                                  detail.name,
                                  style: AppTextStyles.style30ExtraBold,
                                ),

                                Row(
                                  children: [
                                    Text(
                                      detail.price.toString(),
                                      style: AppTextStyles.style28Bold.copyWith(
                                        color: AppColors.textBrown,
                                      ),
                                    ),

                                    Text(
                                      ' EGP',
                                      style: AppTextStyles.style14Bold.copyWith(
                                        color: AppColors.rememberGrey,
                                      ),
                                    ),
                                  ],
                                ),

                                Divider(),
                                SizedBox(height: 12),

                                Text(
                                  'ABOUT THIS ITEM',
                                  style: AppTextStyles.style11Bold.copyWith(
                                    color: AppColors.rememberGrey,
                                  ),
                                ),
                                SizedBox(height: 12),

                                Text(
                                  detail.description,
                                  style: AppTextStyles.style15Normal.copyWith(
                                    color: AppColors.rememberGrey,
                                  ),
                                ),

                                SizedBox(height: 800),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: AppColors.background,
              child: Row(
                children: [
                  Expanded(
                    child: ButtonCustom(
                      title: 'Add to cart · ${detail.price} EGP',
                      onpressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          );
        } else
          return SizedBox.shrink();
      },
    );
  }
}
