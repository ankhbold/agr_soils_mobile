import 'package:flutter/material.dart';

class NdviButton extends StatefulWidget {
  NdviButton({
    Key? key,
  }) : super(key: key);

  @override
  State<NdviButton> createState() => _NdviButtonState();
}

class _NdviButtonState extends State<NdviButton> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Container(
            width: 80,
            height: MediaQuery.of(context).size.height * 0.055,
            decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 239, 239, 239).withOpacity(0.85),
                borderRadius: BorderRadius.circular(12)),
            child: const Center(
                child: Text(
              'NDVI',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            )),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 239, 239, 239)
                      .withOpacity(0.85),
                  borderRadius: BorderRadius.circular(12)),
              height: MediaQuery.of(context).size.height * 0.055,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Бага (Ургамал)',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Text(
                          'Их',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(255, 255, 190, 69),
                              Color.fromARGB(255, 255, 122, 69),
                              Color.fromARGB(255, 255, 94, 0),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
