import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stark/core/app_colors.dart';
import 'package:stark/core/app_text_style.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(15),
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: 20,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
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
                          'all drops',
                          style: AppTextStyles.style14Bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Gap(20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.70,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),

                      elevation: 1,
                      child: InkWell(
                        onTap: () {},
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
                                      'https://i.pinimg.com/1200x/e6/f2/59/e6f259e38f43d92e325e28708fb135c3.jpg',
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
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          'uuuuuuu',
                                          style: AppTextStyles.style12SemiBold
                                              .copyWith(
                                                color: AppColors.background,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'category',
                                    style: AppTextStyles.style12SemiBold
                                        .copyWith(color: AppColors.black),
                                  ),

                                  Text(
                                    'name',
                                    style: AppTextStyles.style17Bold,
                                  ),

                                  SizedBox(height: 5),

                                  Row(
                                    children: [
                                      Text(
                                        'price'.toString(),
                                        style: AppTextStyles.style14Bold,
                                      ),

                                      Text(
                                        " EGP",
                                        style: AppTextStyles.style10SemiBold
                                            .copyWith(
                                              color:
                                                  AppColors.boxGrayBackground,
                                            ),
                                      ),
                                      Spacer(),
                                      IconButton.filled(
                                        style: IconButton.styleFrom(
                                          backgroundColor: AppColors.black,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
