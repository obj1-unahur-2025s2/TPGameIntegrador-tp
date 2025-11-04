
object puertaFalsa {
  method esHostil() = false
  method esLaPuertaFinal() = false
  method esLaPuertaFalsa() = true
  var property image = "puertaFalsa.png"
  var property position = game.at(23, 4)
  
  // getters
  method position() = position
  method image() = image
}

object puertaFinal {
  method esHostil() = false
  method esLaPuertaFinal() = true
  method esLaPuertaFalsa() = false
  var property image = "puertaFinal.png"
  var property position = game.at(23, 4)
  
  // getters
  method position() = position
  method image() = image

  method buenIntento(){
    game.say(self, "Buen intento.. Veamos si podes escapar ahora...")
  }
}

class Pico {
  method esLaPuertaFalsa() = false
  method esLaPuertaFinal() = false
  method esHostil() = true
  method atacaConVeneno() = false

  var x = 1.randomUpTo(game.width()-3).truncate(0)
  var y = 1.randomUpTo(game.height()-3).truncate(0)

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
    var xNueva = 1.randomUpTo(game.width()-3).truncate(0)
    var yNueva = 1.randomUpTo(game.height()-3).truncate(0)

    if(xNueva == 2){
      xNueva += 1
    }
    if(yNueva == 4){
      yNueva += 1
    }

    position = game.at(xNueva, yNueva)
  }

}