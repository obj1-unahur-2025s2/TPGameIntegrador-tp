import screens.*
import wollok.game.*
import niveles.*

object heroe {
  var property imagen = "heroe.png"
  var property position = game.at(2, 4)
  var property vida = 200
  
  method image() = imagen
  method position() = position

  var property estaEnvenenado = false
  method estaEnvenenado() = estaEnvenenado

  method serEnvenenado() {
    estaEnvenenado = true
    imagen = "heroeEnvenenado.png"
    game.say(self, "Veneno... Ahora los golpes van a doler mas")
  }
  
  method vida() = vida 
  
  method perderVida(cantidad) {

    var dañoRecibido = cantidad
    
    if(self.estaEnvenenado()) dañoRecibido += 10
  
    vida -= dañoRecibido
    imagen = "heroeDañado.png"
  }

  method cambiarAssetIzq(){
    if(imagen == "heroeAUnGolpe.png"){
      imagen = "heroeAUnGolpeIzq.png"
    } else if(imagen == "heroe.png"){
      imagen = "heroeIzq.png"
    }
  }

  method cambiarAssetDer(){
    if(imagen == "heroeAUnGolpeIzq.png"){
      imagen = "heroeAUnGolpe.png"
    } else if(imagen == "heroeIzq.png"){
      imagen = "heroe.png"
    }
  }
  
  method volverAlOrigen() {
    if(game.hasVisual(cartelNivel2)){
      position = game.at(20, 4)
    } else {
      position = game.at(2, 4)
    }
  }

  method cambiarAsset() {
    imagen = "heroe.png"

    // el heroe esta muy debilitado
    if(vida <= 40 and imagen !== "heroeAUnGolpe.png" or vida <= 30 and imagen !== "heroeAUnGolpeIzq.png"){
      imagen = "heroeAUnGolpe.png"
      game.say(self, "Me queda poca vida...")
    }
  }

}

class MurcielagoDeCueva {
  method atacaConVeneno() = false
  method esLaPuertaAlNivel2() = false
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
  
  method moverse() {
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

class EsqueletoMortal {
  method esLaPuertaAlNivel2() = false
  method esHostil() = true

  method image() = corrosion.image()
  method atacaConVeneno() = corrosion.estado()
  method daño() = 30

  const x = 1.randomUpTo(game.width()-3).truncate(0)
  const y = 1.randomUpTo(game.height()-3).truncate(0)

  var position = game.at(x, y)
  method position() = position

  method moverse() {
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

object corrosion{
  var estado = false // si esta corrupto ataca con veneno, sino no
  method estado() = estado

  var imagen = "esqueletoMortal.png"
  method image() = imagen

  method corromperEsqueletos(){
    estado = true
    imagen = "esqueletoMortalCorrupto.png"
  }
}

object esqueletoCorrupto{
  method esLaPuertaAlNivel2() = false
  method esHostil() = true
  method atacaConVeneno() = false
  method daño() = 0

  var vida = 300
  method vida() = vida

  method serDañado(){
    vida -= 100
  }

  method image() = "esqueletoCorrupto.png"
  method position() = game.at(2, 4)
}