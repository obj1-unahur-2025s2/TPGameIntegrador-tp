import wollok.game.*
import nivel.*

object heroe {
  var property imagen = "heroe.png"
  var property position = game.at(4, 7)
  var property vida = 100
  
  method image() = imagen
  method position() = position
  
  method vida() = vida 
  
  method perderVida(cantidad) {
    vida -= cantidad
    imagen = "heroeLastimado.png"
  }
  
  method volverAlOrigen() {
    position = game.at(4, 7)
  }

  method volverALaNormalidad() {
    imagen = "heroe.png"
  }
}

class MurcielagoDeCueva {
  method esLaPuertaFalsa() = false
  const property esHostil = true
  var property vida
  var property daño = vida.div(10)
  var property esVenenoso = vida.even()

  method daño() {
    if(!esVenenoso) {
      return daño
    } else {
      return (daño + 15)
    }
  }

  var property image = "murcielagoDeCueva.png"
  method image() = image

  const x = 5.randomUpTo(game.width()-3).truncate(0)
  const y = 8.randomUpTo(game.height()-7).truncate(0)

  var position = game.at(x, y)
  
  method position() = position
  
  method moverse() {
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