import 'package:data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ximena_hoyos_app/common/base_scaffold.dart';
import 'package:ximena_hoyos_app/common/base_view.dart';

enum Sexes { male, female }

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({ Key? key }) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => CalculatorPage()
    );
  }

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  
  final _formKey = GlobalKey<FormState>();
  var activities = [
    "Sedentario",
    "Ligero",
    "Moderado",
    "Activo",
    "Muy activo",
    "Extra activo"
  ];
  var objectives = [
    "Mantener el peso",
    "Perder el peso",
    "Pérdida de peso extrema",
    "Aumento de peso",
    "Aumento de peso rápido"
  ];

  var selectedActivity = 'Sedentario';
  var selectedObjective = 'Mantener el peso';

  int ageField = 0;
  int weightField = 0;
  int heightField = 0;

  Sexes? selectedSex = Sexes.male;

  bool isResultShown = false;

  var IMCData = 0.0;
  var BasalData = 0.0;
  var activityGoal = 0.0;
  var caloriesGoal = 0.0;
  var IMCStatus = '';

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: BaseView(
        showBackButton: true,
        title: "Calculadora XIPROFIT",
        sliver: SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20), 
            child: Column(
              children: [
                CalculatorCaption(),
                SizedBox(height: 15,),
                Container(
                  child:
                  (isResultShown == false) ?
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            RadioListTile<Sexes>(
                              title: const Text(
                                'Masculino',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                                ),
                              ),
                              value: Sexes.male,
                              groupValue: selectedSex,
                              onChanged: (Sexes? value) {
                                setState(() {
                                  selectedSex = value;
                                });
                              },
                              tileColor: Colors.white,
                              selectedTileColor: Colors.white,
                            ),
                            RadioListTile<Sexes>(
                              title: const Text(
                                'Femenino',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                                ),
                              ),
                              value: Sexes.female,
                              groupValue: selectedSex,
                              onChanged: (Sexes? value) {
                                setState(() {
                                  selectedSex = value;
                                });
                              },
                            ),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.white
                              ),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Edad (Años)",
                                labelStyle: TextStyle(
                                  color: Colors.white 
                                ),
                                focusColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(20))
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(20))
                                )
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Edad requerida";
                                }
                              },
                              onChanged: (value){
                                ageField = int.parse(value);
                              },
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.white
                              ),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Peso (kg)",
                                labelStyle: TextStyle(
                                  color: Colors.white 
                                ),
                                focusColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(20))
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(20))
                                )
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Peso requerido";
                                }
                              },
                              onChanged: (value){
                                weightField = int.parse(value);
                              },
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.white
                              ),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Altura (cm)",
                                labelStyle: TextStyle(
                                  color: Colors.white 
                                ),
                                focusColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(20))
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(20))
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Altura requerida";
                                }
                              },
                              onChanged: (value){
                                heightField = int.parse(value);
                              },
                            ), 
                            SizedBox(height: 35,), 
                            FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      labelText: 'Factor de actividad',
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                      hintText: 'Factor de actividad',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 3,
                                          style: BorderStyle.solid
                                        )
                                      )
                                    ),
                                  isEmpty: selectedActivity == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedActivity,
                                      isDense: true,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedActivity = newValue!;
                                          state.didChange(newValue);
                                        });
                                      },
                                      items: activities.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      focusColor: Colors.white,
                                      dropdownColor: kTextColor,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ), 
                            SizedBox(height: 15,), 
                            FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      labelText: 'Seleccione su objetivo',
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                      hintText: 'Seleccione su objetivo',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 3,
                                          style: BorderStyle.solid
                                        )
                                      )
                                    ),
                                  isEmpty: selectedObjective == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedObjective,
                                      isDense: true,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedObjective = newValue!;
                                          state.didChange(newValue);
                                        });
                                      },
                                      items: objectives.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      focusColor: Colors.white,
                                      dropdownColor: kTextColor,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            ElevatedButton(
                              child: Text(
                                "Calcular".toUpperCase()
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  calculate();

                                  setState(() {
                                    isResultShown = true;
                                  });
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(kButtonGreenColor),
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                    : Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Text(
                            "IMC",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                          Text(
                            IMCData.toStringAsFixed(1),
                            style: TextStyle(
                              color: kButtonGreenColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "El índice de masa corporal es una razón que asocia la masa y la talla de un individuo",
                            style: TextStyle(
                              color: kButtonGreenColor,
                              fontSize: 18
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "TMB",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                          Text(
                            BasalData.toStringAsFixed(0),
                            style: TextStyle(
                              color: kButtonGreenColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "El metabolismo basal es la energía que necesita tu cuerpo para realizar las funciones básicas",
                            style: TextStyle(
                              color: kButtonGreenColor,
                              fontSize: 18
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "GET",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                          Text(
                            activityGoal.toStringAsFixed(0),
                            style: TextStyle(
                              color: kButtonGreenColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "caloria/dia",
                            style: TextStyle(
                              color: kButtonGreenColor,
                              fontSize: 18
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Calorías Objetivo",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                          Text(
                            caloriesGoal.toStringAsFixed(0),
                            style: TextStyle(
                              color: kButtonGreenColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "caloria/dia",
                            style: TextStyle(
                              color: kButtonGreenColor,
                              fontSize: 18
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Tu peso según tu IMC",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                          Text(
                            IMCStatus,
                            style: TextStyle(
                              color: kButtonGreenColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            child: Text(
                              "Volver".toUpperCase()
                            ),
                            onPressed: () async {
                              setState(() {
                                isResultShown = false;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(kButtonGreenColor),
                            ),
                          ),
                        ]
                      ),
                    ),
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black,
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  calculate(){
    var selectedSexValue = 0;
    var selectedActivityValue = 0.0;
    var selectedObjectiveValue = 0.0;

    if(selectedSex == Sexes.male){
      selectedSexValue = 5;
    }
    else {
      selectedSexValue = -161;
    }
    
    switch (selectedActivity) {
      case "Sedentario":
        selectedActivityValue = 1.2;
        break;
      case "Ligero":
        selectedActivityValue = 1.375;
        break;
      case "Moderado":
        selectedActivityValue = 1.465;
        break;
      case "Activo":
        selectedActivityValue = 1.55;
        break;
      case "Muy activo":
        selectedActivityValue = 1.725;
        break;
      case "Extra activo":
        selectedActivityValue = 1.9;
        break;
      default:
    }

    switch (selectedObjective) {
      case "Mantener el peso":
        selectedObjectiveValue = 1;
        break;
      case "Perder el peso":
        selectedObjectiveValue = 0.79;
        break;
      case "Pérdida de peso extrema":
        selectedObjectiveValue = 0.59;
        break;
      case "Aumento de peso":
        selectedObjectiveValue = 1.21;
        break;
      case "Aumento de peso rápido":
        selectedObjectiveValue = 1.41;
        break;
      default:
    }

    IMCData = (weightField / ((heightField / 100) * (heightField / 100)));
    BasalData = ((10 * weightField) + (6.25 * heightField) - (5 * ageField) + selectedSexValue);
    caloriesGoal = ((10 * weightField + 6.25 * heightField - 5 * ageField + selectedSexValue) * selectedActivityValue * selectedObjectiveValue);
    activityGoal = ((BasalData * selectedActivityValue) + (BasalData * 0.1));

    if (IMCData < 18.5) {
      IMCStatus = 'BAJO PESO';
    } else if (IMCData >= 18.5 && IMCData <= 24.9) {
      IMCStatus = 'NORMAL';
    } else if (IMCData >= 25 && IMCData <= 29.9) {
      IMCStatus = 'SOBREPESO';
    } else {
      IMCStatus = 'OBESO';
    }
  }
}

class CalculatorCaption extends StatelessWidget {
  const CalculatorCaption({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Importante!",
          style: TextStyle(
            color: kButtonGreenColor,
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 15,),
        Text(
          "Esta información brinda un diagnóstico del momento, no debe usarse para efectos de seguimiento nutricional.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
        SizedBox(height: 5,),
        Divider(
          height: 5,
          color: Colors.white,
        ),
        SizedBox(height: 5,),
        Text(
          "El resultado esta basado en el cálculo nutricional según los parámetros ingresados.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
        SizedBox(height: 5,),
        Divider(
          height: 5,
          color: Colors.white,
        ),
        SizedBox(height: 5,),
        Text(
          "Para mayor información acércate a tu profesional de la salud de confianza.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
        SizedBox(height: 5,),
        Divider(
          height: 5,
          color: Colors.white,
        ),
        SizedBox(height: 5,),
        Text(
          "Recuerda: recurre a tu profesional nutricionista para una mejor información de carácter nutricional",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        )
      ],
    );
  }
}