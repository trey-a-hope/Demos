import 'package:flutter/material.dart';

class CategoryBoxes extends StatefulWidget {
  final Function(bool isSelected)? onPressed;
  final String? text;

  const CategoryBoxes({Key? key, this.onPressed, this.text}) : super(key: key);

  @override
  State<CategoryBoxes> createState() => _CategoryBoxesState();
}

class _CategoryBoxesState extends State<CategoryBoxes> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            widget.onPressed!(isSelected);
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected
                  ? const Color(0xff4A80F0)
                  : const Color(0xff1C2031),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                          color: const Color(0xff4A80F0).withOpacity(0.3),
                          offset: const Offset(0, 4),
                          blurRadius: 20),
                    ]
                  : [],
            ),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Text(
                  widget.text!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
