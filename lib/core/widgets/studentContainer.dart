import 'package:flutter/material.dart';
import 'package:teacher/core/resource/colors_manager.dart';

class PlantCard extends StatelessWidget {
  final String name;
  final VoidCallback onView;

  const PlantCard({
    Key? key,
    required this.name,
    required this.onView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            end: Alignment.topRight,
            begin: Alignment.bottomLeft,
            colors: [
              Color(0xffFFF7B8),
              Color(0xffDAE7DA),
              Color(0xFFB5DDC0),
            ]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 4), //
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      
                      name,
                      style: const TextStyle(
                        color: white,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: black,
                            offset: Offset(0, 3), //
                            blurRadius: 10,
                          )
                        ],
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: onView,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color.fromARGB(255, 210, 237, 198),
                  elevation: 2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.play_arrow),
                label: const Text("عرض"),
              ),
            ],
          ),
          Image.asset(
            "assets/images/plant.png",
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
