import golosinas.*
object mariano {
  const golosinas = []
  const desechadas = []

  // Parte 2 - Mariano colecciones
  method comprar(unaGolosina) {
    golosinas.add(unaGolosina)
  }

  method desechar(unaGolosina) {
    golosinas.remove(unaGolosina)
    desechadas.add(unaGolosina)
  }

  method comproYDesecho(golosina) {
    return desechadas.contains(golosina)
  }

  method cantidadDeGolosinas() = golosinas.size()

  method tieneLaGolosina(unaGolosina) = golosinas.contains(unaGolosina)

  method probarGolosinas() {
    golosinas.forEach({ golosina => golosina.recibirMordisco() })
  }

  method hayGolosinaSinTACC() = golosinas.any({ golosina => golosina.esLibreDeGluten() })

  method preciosCuidados() = golosinas.all({ golosina => golosina.precio() <= 10 })

  method golosinaDeSabor(unSabor) = golosinas.find({ golosina => golosina.sabor() == unSabor })

  method golosinasDeSabor(unSabor) = golosinas.filter({ golosina => golosina.sabor() == unSabor })

  method sabores() = golosinas.map({ golosina => golosina.sabor() }).asSet()

  method golosinaMasCara() = golosinas.max({ golosina => golosina.precio() })

  method pesoGolosinas() = golosinas.sum({ golosina => golosina.peso() })

  // Bañar golosina
  method baniar(unaGolosina) {
       const golosinaBaniada = new GolosinaBaniada(golosinaBase=unaGolosina)
       self.comprar(golosinaBaniada)
   }

  // Estadísticas
  method golosinasFaltantes(golosinasDeseadas) {
    return golosinasDeseadas.filter({ golosina => not self.tieneLaGolosina(golosina) })
  }

  method gustosFaltantes(gustosDeseados) {
    return gustosDeseados.filter({ gusto => not self.sabores().contains(gusto) })
  }

  // Requerimientos adicionales
  method gastoEn(sabor) {
    return self.golosinasDeSabor(sabor).sum({ golosina => golosina.precio() })
  }

  method saborMasPopular() {
    return self.sabores().max({ unSabor => self.cantidadDeGolosinasDeSabor(unSabor) })
  }

  method cantidadDeGolosinasDeSabor(sabor) {
    return self.golosinasDeSabor(sabor).size()
  }

  method saborMasPesado() {
    return self.sabores().max({ unSabor => self.pesoDeGolosinasDeSabor(unSabor) })
  }

  method pesoDeGolosinasDeSabor(sabor) {
    return self.golosinasDeSabor(sabor).sum({ golosina => golosina.peso() })
  } 
}