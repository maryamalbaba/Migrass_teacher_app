import 'package:flutter/material.dart';

class Tasmi3StudentInputUi extends StatelessWidget {
  const Tasmi3StudentInputUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9EAD3), 
      body: SafeArea(
        child: Column(
          children: [
           
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
               
              ),
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "حضور",
                            style: TextStyle(fontSize: 16),
                          ),
                          Checkbox(value: false, onChanged: (_) {}),
                        ],
                      ),
                      const Divider(),

                    
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "مقدار التسميع:",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),

                    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton<String>(
                            value: "105",
                            items: const [
                              DropdownMenuItem(value: "105", child: Text("105")),
                            ],
                            onChanged: (_) {},
                          ),
                          const Text("من آية"),
                          DropdownButton<String>(
                            value: "الإسراء",
                            items: const [
                              DropdownMenuItem(value: "الإسراء", child: Text("سورة الإسراء")),
                            ],
                            onChanged: (_) {},
                          ),
                          const Text("من"),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton<String>(
                            value: "110",
                            items: const [
                              DropdownMenuItem(value: "110", child: Text("110")),
                            ],
                            onChanged: (_) {},
                          ),
                          const Text("الى آية"),
                          DropdownButton<String>(
                            value: "الكهف",
                            items: const [
                              DropdownMenuItem(value: "الكهف", child: Text("سورة الكهف")),
                            ],
                            onChanged: (_) {},
                          ),
                          const Text("الى"),
                        ],
                      ),
                      const Divider(),

                     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("سير"),
                          Checkbox(value: false, onChanged: (_) {}),
                        ],
                      ),

                     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("محسوب أم لا"),
                          Checkbox(value: false, onChanged: (_) {}),
                        ],
                      ),
                      const SizedBox(height: 20),

                    
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD9EAD3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "إرسال",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
