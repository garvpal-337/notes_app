import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key,

  required this.label,
  required this.icon,
  required this.value,
  this.isSmall = false,
  });

  final String? value;
  final IconData? icon;
  final String? label; 
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
                  width: isSmall ? size.width / 3 -20 :double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              if(value != null)Text(
                                value!,
                                style:  TextStyle(
                                  fontSize: isSmall ? 16 :  32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Icon(icon,size: isSmall ? null : 50,),
                              const SizedBox(height: 16),
                            if(label != null)  Text(
                                label!,
                                style:  TextStyle(
                                  fontSize: isSmall ? 14 : 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                );
  }
}