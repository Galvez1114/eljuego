import 'package:eljuego/modelos.dart';
import 'package:test/test.dart';

void main() {

  group('descarte ascendente', () {
    test('si el descarte ascendente acepta cuando esta vacio', () async {
    descarteAscendente descarte = descarteAscendente();
    bool acepto = descarte.recibeCarte(Carta(valor: 10));
    expect(acepto, true);
  });

test('Si el descarte ascendente acepta uno mayor', () {
  descarteAscendente descarte = descarteAscendente();
  descarte.recibeCarte(Carta(valor: 10));
  bool acepto = descarte.recibeCarte(Carta(valor: 20));
  expect(acepto, true);
});

test('si el descarte ascendente no acepta una menor', () {
  descarteAscendente descarte = descarteAscendente();
  descarte.recibeCarte(Carta(valor: 10));
  bool acepto = descarte.recibeCarte(Carta(valor: 5));
  expect(acepto, false);
});

test('si el descarte ascendente acepta una de exactamente menor en 10', () {
  descarteAscendente descarte = descarteAscendente();
  descarte.recibeCarte(Carta(valor: 20));
  bool acepto = descarte.recibeCarte(Carta(valor: 10));
  expect(acepto, true);
});
  });

  group('descarte descendente', () {
    test('si el descarte descendente acepta cuando esta vacio', () async {
    DescarteDescendente descarte = DescarteDescendente();
    bool acepto = descarte.recibeCarte(Carta(valor: 10));
    expect(acepto, true);
  });

test('Si el descarte descendente acepta uno menor', () {
  DescarteDescendente descarte = DescarteDescendente();
  descarte.recibeCarte(Carta(valor: 20));
  bool acepto = descarte.recibeCarte(Carta(valor: 10));
  expect(acepto, true);
});

test('si el descarte descendente no acepta una mayor', () {
  DescarteDescendente descarte = DescarteDescendente();
  descarte.recibeCarte(Carta(valor: 5));
  bool acepto = descarte.recibeCarte(Carta(valor: 10));
  expect(acepto, false);
});

test('si el descarte descendente acepta una de exactamente mayor en 10', () {
  DescarteDescendente descarte = DescarteDescendente();
  descarte.recibeCarte(Carta(valor: 10));
  bool acepto = descarte.recibeCarte(Carta(valor: 20));
  expect(acepto, true);
});
  });

}