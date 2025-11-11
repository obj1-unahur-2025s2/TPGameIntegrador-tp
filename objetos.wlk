import personajes.*

object puertaANivel2 {
  method esHostil() = false
  method esLaPuertaFinal() = false
  method esLaPuertaAlNivel2() = true
  method esPicoCorrupto() = false

  var property image = "puertaANivel2.png"
  var property position = game.at(23, 4)
  
  // getters
  method position() = position
  method image() = image
}

object puertaFinal {
  method esHostil() = false
  method esLaPuertaFinal() = true
  method esLaPuertaAlNivel2() = false
  method esPicoCorrupto() = false

  var property image = "puertaFinal.png"
  var property position = game.at(0, 4)
  
  // getters
  method position() = position
  method image() = image

  method buenIntento(){
    game.say(self, "Buen intento.. Veamos si podes escapar ahora...")
  }
}

class Pico {
  method esLaPuertaAlNivel2() = false
  method esLaPuertaFinal() = false
  method esHostil() = true
  method atacaConVeneno() = false
  method esPicoCorrupto() = false

  var x = 2.randomUpTo(game.width()-2).truncate(0)
  var y = 2.randomUpTo(game.height()-2).truncate(0)

  method chequearPosicion(xPar, yPar){
    if(x == 2){
      x += 1
    }

    if(y == 4){
      y += 1
    }

    position = game.at(x, y)
    return position
  }

  var position = self.chequearPosicion(x, y)
  method position() = position

  const esPicoVolcanico = (x + y).even()
  method esVolcanico() = esPicoVolcanico

  method image() = if (esPicoVolcanico) "picoVolcanico.png" else "pico.png"
  method daño(){ if (esPicoVolcanico) return 25 else return 15 }

  method reordenar() {
    var xNueva = 2.randomUpTo(game.width()-2).truncate(0)
    var yNueva = 2.randomUpTo(game.height()-2).truncate(0)

    if(xNueva == 2){
      xNueva += 1
    }
    if(yNueva == 4){
      yNueva += 1
    }

    position = game.at(xNueva, yNueva)
  }

}

class PicoCorrupto {
  method esLaPuertaAlNivel2() = false
  method esLaPuertaFinal() = false
  method esHostil() = false
  method atacaConVeneno() = false
  method esPicoCorrupto() = true

  var estaDestruido = false
  method estaDestruido() = estaDestruido

  var imagen = "cristalCorrupto.png"
  method image() = imagen

  const x = 2.randomUpTo(game.width()-2).truncate(0)
  const y = 2.randomUpTo(game.height()-2).truncate(0)

  var posicion = game.at(x, y)

  method reordenar() {
    var xNueva = 2.randomUpTo(game.width()-2).truncate(0)
    var yNueva = 2.randomUpTo(game.height()-2).truncate(0)

    if(xNueva == 2){
      xNueva += 1
    }
    if(yNueva == 4){
      yNueva += 1
    }

    posicion = game.at(xNueva, yNueva)
  }

  method position() = posicion

  method romperse(){
    imagen = "cristalCorruptoDestruido.png"
    estaDestruido = true
  }
  
}