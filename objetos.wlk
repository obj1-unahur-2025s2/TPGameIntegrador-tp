
object puertaFalsa {
  method esHostil() = false
  method esLaPuertaFinal() = false
  method esLaPuertaFalsa() = true
  var property image = "puertaFalsa.png"
<<<<<<< HEAD
  var property position = game.at(23, 4)
=======
  var property position = game.at(24, 6)
>>>>>>> 2dd6e8f9bcb3c4d859a4719175d2669b8014a2d4
  
  // getters
  method position() = position
  method image() = image
}

object puertaFinal {
  method esHostil() = false
  method esLaPuertaFinal() = true
  method esLaPuertaFalsa() = false
  var property image = "puertaFinal.png"
<<<<<<< HEAD
  var property position = game.at(23, 4)
=======
  var property position = game.at(24, 6)
>>>>>>> 2dd6e8f9bcb3c4d859a4719175d2669b8014a2d4
  
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
  method daño() = 15

  const x = 3.randomUpTo(game.width()-3).truncate(0)
  const y = 2.randomUpTo(game.height()-7).truncate(0)

  var position = game.at(x, y)
  method position() = position

  const esPicoVolcanico = (x + y).even()
  method esVolcanico() = esPicoVolcanico

  method image() = if (esPicoVolcanico) "picoVolcanico.png" else "pico.png"

  method reordenar() {
    var xNueva = 2.randomUpTo(game.width()-3).truncate(0)
    var yNueva = 2.randomUpTo(game.height()-7).truncate(0)

    if(xNueva == 4){
      xNueva += 1
    }
    if(yNueva == 7){
      yNueva += 1
    }

    position = game.at(xNueva, yNueva)
  }

}