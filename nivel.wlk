import personajes.*
import objetos.*

object textoNivel {
  method esHostil() = false

  var texto = "Vida: " + heroe.vida().toString() + "  |  Objetivo: Llegar a la puerta y salir de la mazmorra"

  method position() = game.at(5,14)
  method text() = texto
  method textColor() = "FF0000FF"
  method height() = "60px"
  method width() = "60px"

  method gameOver(){
    texto = "Game Over"
  }

  method win(){
    texto = "Felicitaciones, Saliste de la mazmorra!"
  }

  method actualizarVidaPlayer(){
    texto = "Vida: " + heroe.vida().toString() + "  |  Objetivo: Llegar a la puerta y salir de la mazmorra"
  }

  method faseFinal(){
    texto = "Vida: " + heroe.vida().toString() + "  |  Objetivo: Llegar a la puerta y salir de la mazmorra / Fase final"
  }
}

object contadorFaseFinal{
  method esHostil() = false

  var segundosRestantes = 35

  var texto = segundosRestantes.toString() + " segundos para salir!"

  method position() = game.at(31, 14)
  method text() = texto

  method textColor() = "FF0000FF"

  method actualizarSegundos(){
    if(segundosRestantes > 0){
      segundosRestantes -= 1
    }

    if(segundosRestantes <= 0){
      texto = "Se te acabo el tiempo..."
      game.removeTickEvent("movimientoMurcielagos")
      game.removeTickEvent("movimientoEsqueletos")
      game.removeTickEvent("contadorFaseFinal")
      game.removeTickEvent("bordes")
      textoNivel.gameOver()
      game.stop()
    } else {
      texto = segundosRestantes.toString() + " segundos para salir!"
    }
  }

}

object nivel {
  const murcielago1 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))
  const murcielago2 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))
  const murcielago3 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))
  const murcielago4 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))
  const murcielago5 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))
  const murcielago6 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))
  const murcielago7 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))

  var murcielagosNivel = [
    murcielago1,
    murcielago2,
    murcielago3,
    murcielago4,
    murcielago5,
    murcielago6,
    murcielago7
  ]

  var picosNivel = [
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico()
  ]

  method reordenarPicos(){
    picosNivel.forEach({ p => p.reordenar() })
  }

  method aumentarDificultad(){
    const murcielago8 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))
    const murcielago9 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))
    const murcielago10 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))

    const murcielagosNivelAd = [murcielago8, murcielago9, murcielago10]
    const picosNivelAd = [new Pico(), new Pico(), new Pico()]

    murcielagosNivel += murcielagosNivelAd
    picosNivel += picosNivelAd 

    murcielagosNivelAd.forEach({ m => game.addVisual(m) })
    picosNivelAd.forEach({ p => game.addVisual(p) })
  }
  
  method setup() {
    murcielagosNivel.forEach({ m => game.addVisual(m) })
    picosNivel.forEach({ p => game.addVisual(p) })

    game.addVisual(puertaFalsa)
    game.addVisual(textoNivel)
  }
  
  method moverMurcielagos() {
    murcielagosNivel.forEach({ m => m.moverse() })
  }

  method comprobarBordes() {
    if(heroe.position().y() >= game.height()-3){
      heroe.position(heroe.position().down(1))
    }
    if(heroe.position().y() <= 2){
      heroe.position(heroe.position().up(1))
    }

    if(heroe.position().x() <= 2){
      heroe.position(heroe.position().right(1))
    }
    if(heroe.position().x() >= game.width()-3){
      heroe.position(heroe.position().left(1))
    }
  }

  method cambiarPuerta(){
    game.removeVisual(puertaFalsa)
    game.addVisual(puertaFinal)
  }

  const esqueletosEnNivel = []

  method generarEsqueletoMortal(){

    if(esqueletosEnNivel.size() >= 4){
      return
    } else {
      const nuevoEsqueleto = new EsqueletoMortal()
      esqueletosEnNivel.add(nuevoEsqueleto)
      game.addVisual(nuevoEsqueleto)
    }

  }

  method moverEsqueletos(){
    esqueletosEnNivel.forEach({ e => e.moverse() })
  }
}