import 'dart:math';

import 'package:data/models/challenge_header_model.dart';
import 'package:data/models/profile_model.dart';
import 'package:data/models/recipe_model.dart';
import 'package:data/models/tip_model.dart';
import 'package:data/repositories/challenges_repository.dart';
import 'package:data/repositories/recipe_repository.dart';
import 'package:data/repositories/repositories.dart';
import 'package:data/repositories/section_repository.dart';
import 'package:data/repositories/tips_repository.dart';
import 'package:data/utils/token_store_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testUserInformation();
}

void testCompany() {
  test('Prueba de consumo de compania', () async {
    final repository = CompanyRepository();
    final company = await repository.getCompanyInfo();

    expect(company != null, true);
  });
}

void testSection() {
  test("Prueba de consumo de servicio de secciones", () async {
    var repository = SectionRepository();
    var section = await repository.fetchSection();

    expect(section.isNotEmpty, true,
        reason: 'El servicio esta retornando una lista vacia');

    var secondSections = await repository.fetchSection();

    expect(section == secondSections, false,
        reason:
            'La listas enviadas por el repositorio no puede ser iguales (referencia)');
  });
}

void testChallenge() {
  test('Prueba de consumo de servicio de cabeceras de retos', () async {
    var repository = ChallengesRepository(DummyStoreImp());

    List<ChallengeHeader> challenges = [];

    challenges.addAll(await repository.fetchChallenges(1));

    expect(challenges.isNotEmpty, true,
        reason: "Este valor no puede ser vacio");

    final selectedChallenge = challenges.first;

    expect(selectedChallenge.slug != null, true,
        reason: 'El reto no puede tener el campo Slug nulo');

    final routines =
        await repository.fetchRoutineByChallenge(selectedChallenge.slug!);

    expect(routines.isNotEmpty, true);

    final selectedRoutine = routines.first;

    final exerciseHeader = await repository.fetchDayExcersise(
        selectedRoutine.slug, selectedRoutine.id);

    final exercises =
        await repository.fetchExcercisesRoutines(exerciseHeader!.id);

    expect(exercises.isNotEmpty, true);
  });
}

void testRecipes() {
  test('Prueba de consumo de servicios de recetas', () async {
    var repository = RecipeRepository(DummyStoreImp());

    List<Recipe> recipes = [];

    recipes.addAll(await repository.fetchRecipes(1));

    expect(recipes.length == 5, true);

    recipes.addAll(await repository.fetchRecipes(2));

    expect(recipes.length == 10, true);

    var firstRecipe = recipes[0];

    var recipe = await repository.fetchRecipeDetail(firstRecipe.slug!);

    expect(recipe.id! > 0, true);

    recipe.steps.forEach((element) {
      prints(element.step.toString() + "  " + element.description);
    });
  });
}

void testTips() {
  test('Prueba de consumo de servicio de tips', () async {
    final repository = TipsRepository(DummyStoreImp());

    final tips = await repository.fetchTips(1);
    expect(tips.length, 10);
    expect(tips[0].content, '');
    expect(tips[0].publishedAt, '');

    final tip = await repository.fetchTipDetail(tips[0].slug);

    expect(tip != null, true);
    expect(tip!.content.isNotEmpty, true);
    expect(tip.publishedAt.isNotEmpty, true);
  });
}

void testAbout() {
  test('prubate de consumo de servicio de about', () async {
    final repository = TipsRepository(DummyStoreImp());

    final about = await repository.fetchAbout();
    expect(about != null, true);
  });
}

void testComments() {
  test('test comments services', () async {
    final repository = ChallengesRepository(DummyStoreImp());
    final challenges = await repository.fetchChallenges(1);
    final first = challenges[0];
    final comments = await repository.fetchComments(first.slug!);
    expect(comments.length > 0, true);
  });
}

void testUserInformation() {
  test('test user information services', () async {
    final repository = TipsRepository(DummyStoreImp());
    final userInformation = await repository.fetchProfile();
    expect(userInformation != null, true);

    final update = ProfileUpdateRaw(
        name: userInformation!.name,
        lastName: userInformation.surname,
        goal: userInformation.goal,
        additional: userInformation.additionalInformation);

    await repository.updateProfile(update);
  });
}
