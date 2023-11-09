class ColaCircular<T> {
  final List<T> _lista = [];

  //Iterable es la clase padre de cualquier conjunto de datos, listas, sets, maps, etc
  ColaCircular(Iterable<T> valoresIniciaales) {
    if (valoresIniciaales.isEmpty) {
       throw 'Ingresa datos a la cola';
    }
    _lista.addAll(valoresIniciaales);
  }

  ColaCircular.desordenar(Iterable<T> valoresIniciaales) {
    _lista.addAll(valoresIniciaales);
    _lista.shuffle();
  }

  T get quienVa {
    if(_lista.isEmpty){
      throw 'No quedan mas elementos';
    }
    return _lista.first;
  }

  T siguiente() {
    if (_lista.isEmpty) {
      throw 'La cola está vacía';
    }
    var primero = _lista.first;
    _lista.add(primero);
    _lista.removeAt(0);
    return quienVa;
  }

  T sacar(T elemento) {
    if (_lista.isEmpty) {
       throw 'Cola vacía';
    }
    _lista.remove(elemento);
    return quienVa;
  }
}
