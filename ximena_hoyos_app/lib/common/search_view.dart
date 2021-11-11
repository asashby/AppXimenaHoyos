import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  final TextEditingController controller;

  const SearchView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var isNotEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 24, left: 24, bottom: 20),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: TextField(
              controller: widget.controller
                ..addListener(() {
                  setState(() {
                    isNotEmpty = widget.controller.text.isNotEmpty;
                  });
                }),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Buscar',
                  icon: Icon(Icons.search_rounded)),
            ),
          ),
          Visibility(
            visible: isNotEmpty,
            child: Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {
                  widget.controller.clear();
                },
                icon: Icon(Icons.clear),
              ),
            ),
          )
        ],
      ),
    );
  }
}
