import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data/models/profile_model.dart';
import 'package:ximena_hoyos_app/app/profile/bloc/profile_bloc.dart';
import 'package:ximena_hoyos_app/common/app_error_view.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';

class ProfilePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => ProfilePage());
  }

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _lastController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) =>
            ProfileBloc(RepositoryProvider.of(ctx))..add(FetchProfileEvent()),
        child:
            BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
          if (state.isUpdated) {
            final snackbar =
                SnackBar(content: Text('Perfil de usuario actualizado'));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        }, builder: (context, data) {
          switch (data.status) {
            case ProfileStatus.initial:
              return SizedBox.shrink();
            case ProfileStatus.loading:
              return SizedBox(
                height: 400,
                child:
                    Center(child: Center(child: CircularProgressIndicator())),
              );
            case ProfileStatus.success:
              _initTextFieldController(data.data!);

              return _ProfileBody(
                emailController: _emailController,
                lastController: _lastController,
                nameController: _nameController,
                profile: data.data!,
              );

            case ProfileStatus.error:
              return Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: AppErrorView(
                    onPressed: () {
                      context.read()<ProfileBloc>().add(FetchProfileEvent());
                    },
                    onClose: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
          }
        }));
  }

  _initTextFieldController(Profile data) {
    if (_emailController.text.isEmpty) {
      _emailController.text = data.email!;
    }

    if (_lastController.text.isEmpty) {
      _lastController.text = data.surname ?? '';
    }

    if (_nameController.text.isEmpty) {
      _nameController.text = data.name ?? '';
    }
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({
    Key? key,
    required TextEditingController emailController,
    required TextEditingController lastController,
    required TextEditingController nameController,
    required this.profile,
  })  : _emailController = emailController,
        _lastController = lastController,
        _nameController = nameController,
        super(key: key);

  final Profile profile;
  final TextEditingController _emailController;
  final TextEditingController _lastController;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        BaseView(
          title: 'Datos personales',
          showBackButton: true,
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(right: 24, left: 24, bottom: 60),
              child: Column(
                children: [
                  _ProfileForm(
                    emailController: _emailController,
                    lastController: _lastController,
                    nameController: _nameController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _ProfileGoalsView(),
                  SizedBox(
                    height: 30,
                  ),
                  _ProfileAdditionalView(),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: MaterialButton(
            onPressed: () => _updateProfileRegister(context),
            color: Theme.of(context).buttonColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            height: 50,
            minWidth: double.infinity,
            child:
                Text('Guardar', style: Theme.of(context).textTheme.headline2),
          ),
        )
      ],
    ));
  }

  _updateProfileRegister(BuildContext context) {
    final name = _nameController.text;
    final email = _emailController.text;
    final lastName = _lastController.text;

    ProfileBloc bloc = context.read();

    final age = bloc.currentAge;
    final weight = bloc.currentWeight;
    final size = bloc.currentSize;

    final goal = bloc.currentGoal;

    print('update profile');

    context.read<ProfileBloc>().add(
        UpdateProfileEvent(name, lastName, email, age, weight, size, goal));
  }
}

class _ProfileForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController lastController;
  final TextEditingController emailController;
  const _ProfileForm({
    Key? key,
    required this.nameController,
    required this.lastController,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProfileInput(
          hintText: 'Nombre',
          padding: const EdgeInsets.only(bottom: 16),
          controller: nameController,
        ),
        _ProfileInput(
          hintText: 'Apellido',
          padding: const EdgeInsets.only(bottom: 16),
          controller: lastController,
        ),
        _ProfileInput(
          hintText: 'Correo Electronico',
          padding: const EdgeInsets.only(bottom: 16),
          controller: emailController,
          enabled: false,
        ),
      ],
    );
  }
}

class _ProfileInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final EdgeInsetsGeometry padding;
  final bool enabled;

  const _ProfileInput({
    Key? key,
    this.controller,
    required this.hintText,
    this.padding = const EdgeInsets.all(0.0),
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.padding,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: TextField(
          enabled: enabled,
          style: Theme.of(context).textTheme.headline4,
          controller: this.controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              fillColor: Theme.of(context).primaryColorDark,
              filled: true,
              contentPadding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 24, right: 24),
              hintText: this.hintText,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[600]!, width: 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: Theme.of(context).textTheme.bodyText1,
              focusColor: Colors.white),
        ),
      ),
    );
  }
}

/// Esta Pantalla incluye la informacion las metas.

class _ProfileGoalsView extends StatefulWidget {
  const _ProfileGoalsView({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileGoalsViewState createState() => _ProfileGoalsViewState();
}

class _ProfileGoalsViewState extends State<_ProfileGoalsView> {
  late ProfileGoal? goal;

  @override
  void initState() {
    goal = context.read<ProfileBloc>().currentGoal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Objetivos',
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 20,
        ),
        _ProfileRadioButton(
          title: 'Sacar musculos',
          checked: goal == ProfileGoal.muscle,
          onPresed: () => _changeState(ProfileGoal.muscle, context),
        ),
        SizedBox(
          height: 16,
        ),
        _ProfileRadioButton(
          title: 'Adelgazar',
          checked: goal == ProfileGoal.slim,
          onPresed: () => _changeState(ProfileGoal.slim, context),
        ),
        SizedBox(
          height: 16,
        ),
        _ProfileRadioButton(
          title: 'Tonificar',
          checked: goal == ProfileGoal.tonify,
          onPresed: () => _changeState(ProfileGoal.tonify, context),
        ),
      ],
    );
  }

  _changeState(ProfileGoal goal, BuildContext context) {
    context.read<ProfileBloc>().currentGoal = goal;

    setState(() {
      this.goal = goal;
    });
  }
}

class _ProfileRadioButton extends StatelessWidget {
  final String title;
  final bool checked;
  final VoidCallback onPresed;

  const _ProfileRadioButton({
    Key? key,
    required this.title,
    this.checked = false,
    required this.onPresed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPresed,
      height: 70,
      minWidth: double.infinity,
      color: Theme.of(context).primaryColorDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                this.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            checked
                ? Icon(
                    Icons.circle,
                    color: Theme.of(context).buttonColor,
                  )
                : Icon(
                    Icons.radio_button_off,
                    color: Colors.white,
                  )
          ],
        ),
      ),
    );
  }
}

/// Informacion adicional del usuario, esto incluye lo siguiente
/// Edad
/// Peso
/// Talla

class _ProfileAdditionalView extends StatefulWidget {
  const _ProfileAdditionalView({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileAdditionalViewState createState() => _ProfileAdditionalViewState();
}

class _ProfileAdditionalViewState extends State<_ProfileAdditionalView> {
  final ages = List.generate(84, (index) => index + 17);
  final weight = List.generate(132, (index) => index + 19);
  final sizes = List.generate(92, (index) => index + 119);

  int? _currentAge;
  int? _currentSize;
  int? _currentWeight;

  @override
  void initState() {
    ProfileBloc bloc = context.read();
    _currentAge = bloc.currentAge;
    _currentSize = bloc.currentSize;
    _currentWeight = bloc.currentWeight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Datos Adicionales',
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 20,
        ),
        _ProfileDropDown(
          title: 'Edad',
          items: ages,
          value: _findIndex(ages, _currentAge),
          onChanged: (value) => _updateAge(value ?? 0, context),
        ),
        SizedBox(
          height: 16,
        ),
        _ProfileDropDown(
          title: 'Peso',
          suffix: 'Kg',
          items: weight,
          value: _findIndex(weight, _currentWeight),
          onChanged: (value) => _updateWeight(value ?? 0, context),
        ),
        SizedBox(
          height: 16,
        ),
        _ProfileDropDown(
          title: 'Talla',
          suffix: 'cm',
          items: sizes,
          value: _findIndex(sizes, _currentSize),
          onChanged: (value) => _updateSize(value ?? 0, context),
        ),
      ],
    );
  }

  _updateAge(int index, BuildContext context) {
    final newAge = _findValue(ages, index);

    context.read<ProfileBloc>().currentAge = newAge;

    setState(() {
      this._currentAge = newAge;
    });
  }

  _updateSize(int index, BuildContext context) {
    final newSize = _findValue(sizes, index);

    context.read<ProfileBloc>().currentSize = newSize;

    setState(() {
      this._currentSize = newSize;
    });
  }

  _updateWeight(int index, BuildContext context) {
    final newWeight = _findValue(weight, index);

    context.read<ProfileBloc>().currentWeight = newWeight;

    setState(() {
      this._currentWeight = newWeight;
    });
  }

  int? _findValue(List<int> source, int index) {
    if (index == 0) {
      return null;
    }

    return source[index];
  }

  int _findIndex(List<int> source, int? value) {
    final index = source.indexWhere((element) => element == value);
    if (index == -1) {
      return 0;
    }
    return index;
  }
}

class _ProfileDropDown extends StatelessWidget {
  final String title;
  final String? suffix;
  final List<int> items;
  final int value;
  final ValueChanged<int?>? onChanged;
  const _ProfileDropDown({
    Key? key,
    required this.title,
    this.suffix,
    required this.items,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColorDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
        ),
        child: Row(
          children: [
            Text(
              this.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Expanded(
              child: DropdownButton(
                  value: value,
                  isExpanded: true,
                  dropdownColor: Colors.grey[800],
                  iconEnabledColor: Theme.of(context).buttonColor,
                  underline: SizedBox.shrink(),
                  items: items
                      .asMap()
                      .entries
                      .map((e) => DropdownMenuItem(
                            child: Row(
                              children: [
                                Expanded(child: Container()),
                                Padding(
                                  padding: const EdgeInsets.only(right: 24),
                                  child: Text(
                                    e.key == 0
                                        ? 'Seleccionar'
                                        : "${e.value} ${suffix ?? ''}".trim(),
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            value: e.key,
                          ))
                      .toList(),
                  onChanged: onChanged),
            )
          ],
        ),
      ),
    );
  }
}
