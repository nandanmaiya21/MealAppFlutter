import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../data/dummy_data.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavoritel;

  MealDetailScreen(this.toggleFavorite, this.isFavoritel);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: _height(MediaQuery.of(context).size.height,
          MediaQuery.of(context).size.width),
      width: MediaQuery.of(context).size.width / 1.3,
      child: child,
    );
  }

  double _height(double h, double w) {
    if (h > w) {
      return MediaQuery.of(context).size.height / 3;
    } else {
      return MediaQuery.of(context).size.height / 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              child: ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                ),
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
                child: ListView.builder(
              itemCount: selectedMeal.steps.length,
              itemBuilder: (ctx, index) => Column(
                children: [
                  ListTile(
                    title: Text(selectedMeal.steps[index]),
                    leading: CircleAvatar(
                      child: Text(
                        '#${index + 1}',
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          widget.isFavoritel(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => widget.toggleFavorite(mealId),
      ),
    );
  }
}
