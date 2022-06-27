// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

// import '../api/marca_api.dart';

// class TypeAheadMarca extends StatelessWidget {
//   final marcaController;
//   final Function updateState;
//   const TypeAheadMarca({Key? key, required this.updateState, this.marcaController}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadField<Marca?>(
//       hideSuggestionsOnKeyboardHide: false,
//       textFieldConfiguration: TextFieldConfiguration(
//         controller: TextEditingController(text: (marcaController)),
//         decoration: const InputDecoration(
//           prefixIcon: Icon(Icons.search),
//           border: OutlineInputBorder(),
//           hintText: 'Buscar Marca',
//         ),
//       ),
//       suggestionsCallback: UserApi.getUserSuggestions,
//       itemBuilder: (context, Marca? suggestion) {
//         final user = suggestion!;

//         return ListTile(
//           title: Text(user.name),
//         );
//       },
//       noItemsFoundBuilder: (context) => const SizedBox(
//         height: 100,
//         child: Center(
//           child: Text(
//             'Marca no encontrada',
//             style: TextStyle(fontSize: 24),
//           ),
//         ),
//       ),
//       onSuggestionSelected: (Marca? suggestion) {
//         final marca = suggestion!;
//         marcaController = marca.name;
//         // setState(() {});
//         updateState();
//         ScaffoldMessenger.of(context)
//           ..removeCurrentSnackBar()
//           ..showSnackBar(SnackBar(
//             content: Text('Marca seleccionada: ${marca.name}'),
//           ));
//       },
//     );
//   }
// }
