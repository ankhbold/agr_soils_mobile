import 'package:flutter/material.dart';
import 'package:mvvm/res/components/floating_fields.dart';

class NdviButton extends StatelessWidget {
  NdviButton({
    Key? key,
  }) : super(key: key);

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
            height: MediaQuery.of(context).size.height * 0.05,
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
        const FloatingFields(),
      ],
    );
  }
}
