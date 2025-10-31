import wollok.game.*
import nivel.*

object heroe {
  var property imagen = "heroe.png"
  var property position = game.at(4, 7)
  var property vida = 100
  
  method image() = imagen
  method position() = position

  var property estaEnvenenado = false
  method estaEnvenenado() = estaEnvenenado

  method envenenar() {
    estaEnvenenado = true
    imagen = "heroeEnvenenado.png"
  }

  method dialogoVeneno(){
    game.say(self, "Veneno... Ahora los golpes van a doler mas")
  }
  
  method vida() = vida 
  
  method perderVida(cantidad) {

    var dañoRecibido = cantidad
    
    if(self.estaEnvenenado()) dañoRecibido += 10
  
    vida -= dañoRecibido
    imagen = "heroeLastimado.png"
  }
  
  method volverAlOrigen() {
    position = game.at(4, 7)
  }

  method volverALaNormalidad() {
    if(self.estaEnvenenado()) {
      imagen = "heroeEnvenenado.png"
    } else {
      imagen = "heroe.png"
    }
  }
}

class MurcielagoDeCueva {
  method atacaConVeneno() = false
  method esLaPuertaFalsa() = false
  method esHostil() = true
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

class EsqueletoMortal {
  method esLaPuertaFalsa() = false
  method esHostil() = true
  method image() = "esqueletoMortal.png"

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

  method daño() = 30
  method atacaConVeneno() = true
  
}