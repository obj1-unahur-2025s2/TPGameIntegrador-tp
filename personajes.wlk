import objetos.*
import screens.*
import wollok.game.*
import niveles.*

object heroe {
  var property imagen = "heroe.png"
  var property position = game.at(2, 4)
  var property vida = 125
  var property estaEnvenenado = false
  
  method image() = imagen
  
  method position() = position
  
  method estaEnvenenado() = estaEnvenenado
  
  method serEnvenenado() {
    estaEnvenenado = true
    imagen = "heroeEnvenenado.png"
    game.say(self, "Veneno... Ahora los golpes van a doler mas")
  }
  
  method vida() = vida
  
  method perderVida(cantidad) {
    var dañoRecibido = cantidad
    
    if (self.estaEnvenenado()) {
      dañoRecibido += 10
    }
    
    vida -= dañoRecibido
    imagen = "heroeDañado.png"
  }
  
  method cambiarAssetIzq() {
    if (imagen == "heroeAUnGolpe.png") {
      imagen = "heroeAUnGolpeIzq.png"
    } else {
      if (imagen == "heroe.png") {
        imagen = "heroeIzq.png"
      }
    }
  }
  
  method cambiarAssetDer() {
    if (imagen == "heroeAUnGolpeIzq.png") {
      imagen = "heroeAUnGolpe.png"
    } else {
      if (imagen == "heroeIzq.png") {
        imagen = "heroe.png"
      }
    }
  }
  
  method volverAlOrigen() {
    if (game.hasVisual(cartelNivel2)) {
      position = game.at(20, 4)
    } else {
      position = game.at(2, 4)
    }
  }
  
  method restaurarAsset() {
    imagen = "heroe.png"
    
    // el heroe esta muy debilitado
    if (((vida <= 45) and (imagen !== "heroeAUnGolpe.png")) or ((vida <= 30) and (imagen !== "heroeAUnGolpeIzq.png"))) {
      imagen = "heroeAUnGolpe.png"
      game.say(self, "Me queda poca vida...")
    }
  }
}

class MurcielagoDeCueva {
  var property vida
  var property daño = vida.div(10)
  var property esVenenoso = vida.even()
  var property image = "murcielagoDeCueva.png"
  var x = 2.randomUpTo(game.width() - 2).truncate(0)
  var y = 2.randomUpTo(game.height() - 2).truncate(0)
  var position = self.chequearPosicion(x, y)
  
  method atacaConVeneno() = false
  method esLaPuertaAlNivel2() = false
  method esLaPuertaFinal() = false
  method esHostil() = true
  method esPicoCorrupto() = false
  
  method daño() {
    if (!esVenenoso) {
      return daño
    } else {
      return daño + 15
    }
  }
  
  method image() = image
  
  method chequearPosicion(xPar, yPar) {
    if (x == 2) {
      x += 1
    }
    if (y == 4) {
      y += 1
    }
    
    position = game.at(x, y)
    return position
  }
  
  method position() = position
  
  method moverse() {
    var xNueva = 2.randomUpTo(game.width() - 2).truncate(0)
    var yNueva = 2.randomUpTo(game.height() - 2).truncate(0)
    
    if (xNueva == 2) {
      xNueva += 1
    }
    if (yNueva == 4) {
      yNueva += 1
    }
    
    position = game.at(xNueva, yNueva)
  }
}

class EsqueletoMortal {
  const x = 2.randomUpTo(game.width() - 2).truncate(0)
  const y = 2.randomUpTo(game.height() - 2).truncate(0)
  var position = game.at(x, y)
  
  method esLaPuertaAlNivel2() = false
  method esHostil() = true
  method esPicoCorrupto() = false
  method esLaPuertaFinal() = false

  method image() = corrosion.image()
  
  method atacaConVeneno() = corrosion.estado()
  
  method daño() = 30
  
  method position() = position
  
  method moverse() {
    var xNueva = 2.randomUpTo(game.width() - 2).truncate(0)
    var yNueva = 2.randomUpTo(game.height() - 2).truncate(0)
    
    if (xNueva == 2) {
      xNueva += 1
    }
    if (yNueva == 4) {
      yNueva += 1
    }
    
    position = game.at(xNueva, yNueva)
  }
}

object corrosion {
  var estado = false // si esta corrupto ataca con veneno, sino no
  var imagen = "esqueletoMortal.png"
  
  method estado() = estado
  
  method image() = imagen
  
  method corromperEsqueletos() {
    estado = true
    imagen = "esqueletoMortalCorrupto.png"
  }
}

object esqueletoCorrupto {
  var imagen = "esqueletoCorrupto.png"
  var picosCorruptosEnNivel = 3
  
  method esPicoCorrupto() = false
  
  method esLaPuertaAlNivel2() = false

  method esLaPuertaFinal() = false
  
  method esHostil() = true
  
  method atacaConVeneno() = false
  
  method daño() = 0
  
  method image() = imagen
  
  method position() = game.at(2, 4)
  
  method invocarMurcielagos() {
    if (picosCorruptosEnNivel == 2) nivel.reapareceMurcielagos()
  }

  method debilitarse(){
    if (picosCorruptosEnNivel == 1) {
      imagen = "esqueletoCorruptoDañadoFase2.png"
      game.schedule(900, { imagen = "esqueletoCorruptoFase2.png" })
    } else {
      imagen = "esqueletoCorruptoDañadoFase1.png"
      game.schedule(900, { imagen = "esqueletoCorrupto.png" })
    }
  }
  
  method serDañado() {
    picosCorruptosEnNivel -= 1
    
    if (picosCorruptosEnNivel == 0) {
      imagen = "esqueletoCorruptoDañadoFase2.png"
      game.say(self, "Esto no va a quedar asi...")
      game.schedule(1500, { game.removeVisual(self) })
      nivel.derrotarEsqueletoCorrupto()
    } else {
      self.invocarMurcielagos()
      self.debilitarse()
      game.say(self, "Ah si? ahora vas a ver!")
    }
  }
}