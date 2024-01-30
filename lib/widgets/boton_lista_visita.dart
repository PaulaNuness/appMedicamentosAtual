import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonListaVisita extends StatelessWidget {
  final IconData icono;
  final String especialidad;
  final String doctor;
  final String lugar;
  final String fecha;
  final Color color1;
  final Color color2;
  final Function onPress;
  final Color colorTexto;
  const BotonListaVisita(
      {super.key,
      this.icono = FontAwesomeIcons.powerOff,
      required this.especialidad,
      required this.doctor,
      required this.lugar,
      required this.fecha,
      this.color1 = const Color(0xFF6989F5),
      this.color2 = const Color(0xFF906EF5),
      required this.onPress,
      this.colorTexto = Colors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Stack(
        children: [
          _BotonFondo(icono: this.icono,color1: this.color1,color2: this.color2,colorTexto: this.colorTexto,),
          Row(
            children: [
              const SizedBox(
                height: 140,
                width: 40,
              ),
              FaIcon(icono, size: 40, color: colorTexto),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fecha,
                      style: TextStyle(
                        color: colorTexto, 
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          especialidad,
                          style: TextStyle(
                            color: colorTexto, 
                            fontSize: 20),
                        ),
                        Expanded(
                          child: const SizedBox(
                            width: 20,
                          ),
                        ),
                        Text(
                          "("+lugar+")",
                          style: TextStyle(color: colorTexto, fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      doctor,
                      style: TextStyle(color: colorTexto, fontSize: 14),
                    ),
                  ],
                ),
              ),
              FaIcon(FontAwesomeIcons.chevronRight, size: 40, color: colorTexto,),
              const SizedBox(
                width: 40,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _BotonFondo extends StatelessWidget {
  final IconData icono;
  final Color color1;
  final Color color2;
  final Color colorTexto;
  const _BotonFondo({
    super.key,
    required this.icono,
    required this.color1,
    required this.color2, 
     this.colorTexto=Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color1,
            color2,
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            offset: const Offset(4, 6),
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(children: <Widget>[
          Positioned(
            right: -30,
            top: -30,
            child: FaIcon(
              icono,
              size: 170,
              color: colorTexto.withOpacity(.2),
            ),
          ),
        ]),
      ),
      
    );
  }
}
