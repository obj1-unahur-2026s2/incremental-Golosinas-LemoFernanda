// (Objeto/mensaje/polimorfismo)
/*
De cada golosina interesan: el precio, el sabor, su peso en gramos y si contiene gluten.
Además, cada vez que una golosina recibe un mordisco se reduce la cantidad de gramos que posee.
*/
class Golosina {
  var peso

  method peso() = peso
  method esLibreDeGluten() = false
  method precio()
  method sabor()
  method recibirMordisco()
}

class Bombon inherits Golosina(peso = 15) {
  override method precio() = 5
  override method sabor() = frutilla
  override method esLibreDeGluten() = true
  override method recibirMordisco() {
    peso = ((peso * 0.8) - 1).max(0)
  }
}

class Alfajor inherits Golosina(peso = 300) {
  override method precio() = 12
  override method sabor() = chocolate
  override method recibirMordisco() {
    peso = peso * 0.8
  }
}

class Caramelo inherits Golosina(peso = 5) {
  override method precio() = 1
  override method sabor() = frutilla
  override method esLibreDeGluten() = true
  override method recibirMordisco() {
    peso = (peso - 1).max(0)
  }
}

class Chupetin inherits Golosina(peso = 7) {
  override method precio() = 2
  override method sabor() = naranja
  override method esLibreDeGluten() = true
  override method recibirMordisco() {
    if (peso >= 2) {
      peso = peso * 0.9
    }
  }
}

class Oblea inherits Golosina(peso = 250) {
  override method precio() = 5
  override method sabor() = vainilla
  override method recibirMordisco() {
    peso = 0.max(peso - if (peso > 70) peso * 0.5 else peso * 0.25)
  }
}

class Chocolatin inherits Golosina(peso = 0) {
  const pesoInicial
  var gramosConsumidos = 0

  override method peso() = 0.max(pesoInicial - gramosConsumidos)
  override method precio() = 0.5 * pesoInicial
  override method sabor() = chocolate
  override method recibirMordisco() {
    gramosConsumidos += 2
  }
}

class GolosinaBaniada inherits Golosina(peso = 0) {
  const golosinaBase
  var gramosDeBaniado = 4

  override method precio() = golosinaBase.precio() + 2
  override method peso() = golosinaBase.peso() + gramosDeBaniado
  override method sabor() = golosinaBase.sabor()
  override method esLibreDeGluten() = golosinaBase.esLibreDeGluten()
  
  override method recibirMordisco() {
    golosinaBase.recibirMordisco()
    gramosDeBaniado = (gramosDeBaniado - 2).max(0)
  }
}

class PastillaTuttiFrutti inherits Golosina(peso = 5) {
  const esLibreDeGluten
  var sabor = frutilla

  override method precio() = if (esLibreDeGluten) 7 else 10
  override method esLibreDeGluten() = esLibreDeGluten
  override method sabor() = sabor
  override method recibirMordisco() {
    sabor = sabor.siguienteSabor()
  }
}

// Sabores

object frutilla { method siguienteSabor() = chocolate }
object chocolate { method siguienteSabor() = naranja }
object naranja { method siguienteSabor() = frutilla }
object vainilla { }

// Mas variantes

class BombonDuro inherits Bombon {
  override method recibirMordisco() {
    peso = (peso - 1).max(0)
  }

  method gradoDeDureza() = 1 + if (peso > 12) 2 else if (peso >= 8) 1 else 0
}

class CarameloDeSabor inherits Caramelo {
  const sabor
  override method sabor() = sabor
}

class CarameloRelleno inherits Caramelo {
  var sabor = frutilla

  override method sabor() = sabor
  override method recibirMordisco() {
    super()
    sabor = chocolate
  }
  override method precio() = super() + 1
}

class ObleaCrujiente inherits Oblea {
  var mordiscos = 0

  override method recibirMordisco() {
    super()
    peso = peso - if (self.estaDebil()) 3 else 0
    mordiscos += 1
  }

  method estaDebil() = mordiscos > 3
}

class ChocolatinVIP inherits Chocolatin {
  override method peso() = super() * (1 + self.humedad())
  method humedad() = heladeraDeMariano.coeficienteDeHumedad()
}

class ChocolatinPremium inherits ChocolatinVIP {
  override method humedad() = heladeraDeMariano.coeficienteDeHumedad() / 2
}

object heladeraDeMariano {
  var coeficienteDeHumedad = 0

  method cambiarCoeficienteDeHumedad(nuevoValor) {
    coeficienteDeHumedad = 0.max(nuevoValor).min(1)
  }
  method coeficienteDeHumedad() = coeficienteDeHumedad
}