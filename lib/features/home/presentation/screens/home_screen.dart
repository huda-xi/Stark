import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:stark/core/app_colors.dart';
import 'package:stark/core/app_text_style.dart';
import 'package:stark/features/categories/presentaion/cubit/categories_cubit.dart';
import 'package:stark/features/categories/presentaion/cubit/categories_states.dart';
import 'package:stark/features/details/presentation/screens/details_screen.dart';
import 'package:stark/features/home/presentation/cubit/products_cubit.dart';
import 'package:stark/features/home/presentation/cubit/products_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        title: Text('STARK', style: AppTextStyles.style20Bold),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton.filled(
              iconSize: 24,
              onPressed: () {},
              icon: Icon(Icons.notifications_none),
              style: IconButton.styleFrom(backgroundColor: Colors.white),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(15),

            SizedBox(
              height: 50,
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CategoriesFailureState) {
                    return Center(child: Text('error'));
                  } else if (state is CategoriesSuccessState) {
                    return ListView.builder(
                      itemCount: state.categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final cat = state.categories[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromARGB(255, 186, 188, 189),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                cat.name,
                                style: AppTextStyles.style14Bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else
                    return SizedBox.shrink();
                },
              ),
            ),

            Gap(20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'All Products',
                style: AppTextStyles.style20MediumPlay,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<ProductsCubit, ProductsStates>(
                  builder: (context, state) {
                    if (state is ProductsLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ProductsFailiurState) {
                      return Center(child: Text(state.message));
                    } else if (state is ProductsSuccessState) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.70,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),

                            elevation: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsScreen(detailsID: product.id),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: Image.network(
                                            product.coverPictureUrl,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),

                                        Positioned(
                                          top: 8,
                                          left: 8,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black.withValues(
                                                alpha: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                '',
                                                style: AppTextStyles
                                                    .style12SemiBold
                                                    .copyWith(
                                                      color:
                                                          AppColors.background,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      bottom: 5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.categories,
                                          style: AppTextStyles.style12SemiBold
                                              .copyWith(color: AppColors.black),
                                        ),

                                        Text(
                                          product.name,
                                          style: AppTextStyles.style17Bold,
                                        ),

                                        SizedBox(height: 5),

                                        Row(
                                          children: [
                                            Text(
                                              product.price.toString(),
                                              style: AppTextStyles.style14Bold,
                                            ),

                                            Text(
                                              " EGP",
                                              style: AppTextStyles
                                                  .style10SemiBold
                                                  .copyWith(
                                                    color: AppColors
                                                        .boxGrayBackground,
                                                  ),
                                            ),
                                            Spacer(),
                                            IconButton.filled(
                                              style: IconButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.black,
                                              ),
                                              onPressed: () {},
                                              icon: Icon(Icons.add),
                                              iconSize: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else
                      return SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
