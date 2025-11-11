import personajes.*
import objetos.*
import screens.*

object movimiento{
  method comprobarBordes() {
    if(heroe.position().y() >= game.height()-2){
      heroe.position(heroe.position().down(1))
    }
    if(heroe.position().y() <= 1){
      heroe.position(heroe.position().up(1))
    }
    if(heroe.position().x() <= 1){
      heroe.position(heroe.position().right(1))
    }
    if(heroe.position().x() >= game.width()-2){
      heroe.position(heroe.position().left(1))
    }
  }

  method cambiarMediosHeroe(){
    keyboard.left().onPressDo({ heroe.cambiarAssetIzq() })
    keyboard.right().onPressDo({ heroe.cambiarAssetDer() })
  }

}


object colisiones {
  
  method activar(){

    game.whenCollideDo( heroe,
    { elemento => 

      if (elemento.esHostil()) {

        heroe.perderVida(elemento.daño())
        heroe.volverAlOrigen()
        nivel.reordenarPicos()

        if(!game.hasVisual(cartelNivel2)){
          nivel.generarEsqueletoMortal()
        } else {
          nivel.generarEsqueletoMortal()
          nivel.generarEsqueletoMortal()
        }
        
        if(elemento.atacaConVeneno()) {
          heroe.serEnvenenado()
        }
        
        game.schedule(700, { heroe.cambiarAsset() })

        if(heroe.vida() <= 0){
          game.stop()
        }
        
      }

      if(elemento.esLaPuertaAlNivel2()){
         nivel.setupNivel2()
      }

    })
  }

}


object contadorFaseFinal{
  method esHostil() = false

  var segundosRestantes = 35

  var texto = segundosRestantes.toString() + " segundos para salir!"

  method position() = game.at(24, 13)
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
  const murcielago8 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))
  const murcielago9 = new MurcielagoDeCueva(vida = 20.randomUpTo(70).truncate(0))

  const murcielagosNivel = [
    murcielago1,
    murcielago2,
    murcielago3,
    murcielago4,
    murcielago5,
    murcielago6,
    murcielago7,
    murcielago8,
    murcielago9
  ]

  const picosNivel = [
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
  
  method moverMurcielagos() {
    murcielagosNivel.forEach({ m => m.moverse() })
  }

  const esqueletosEnNivel = []

  method generarEsqueletoMortal(){

    if(esqueletosEnNivel.size() == 4){

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

  // se inicia el nivel 1
  method setupNivel1() {
    menuInicial.removeVisualElements()
    game.addVisual(fondoNivel1)
    game.addVisual(nivel1Keys)
    game.addVisual(cartelNivel1)
    game.addVisualCharacter(heroe)

    game.onTick(200, "bordes", { movimiento.comprobarBordes() })
    game.onTick(100, "movimientoHeroe", { movimiento.cambiarMediosHeroe() })
    
    colisiones.activar()

    murcielagosNivel.forEach({ m => game.addVisual(m) })
    // cada 0.9s se mueven los murcielagos
    game.onTick(900, "movimientoMurcielagos", { self.moverMurcielagos() })
    // cada 1.5s se mueven los murcielagos
    game.onTick(1500, "movimientoEsqueletos", { self.moverEsqueletos() })

    picosNivel.forEach({ p => game.addVisual(p) })

    game.addVisual(puertaANivel2)

  }

  // se inicia el nivel 2
  method setupNivel2(){

    corrosion.corromperEsqueletos()

    // acomodar visualmente los assets del nivel
 
    game.removeVisual(fondoNivel1)
    game.addVisual(fondoNivel2)

    game.removeVisual(nivel1Keys)
    game.removeVisual(cartelNivel1)

    game.removeVisual(heroe)
    game.addVisual(heroe)

    game.removeVisual(puertaANivel2)

    esqueletosEnNivel.forEach({ e => game.removeVisual(e) })
    murcielagosNivel.forEach({ m => game.removeVisual(m) })
    
    picosNivel.forEach({ p => game.removeVisual(p) })
    picosNivel.forEach({ p => game.addVisual(p) })

    game.addVisual(esqueletoCorrupto)
    game.addVisual(cartelNivel2)
    self.reordenarPicos()
  }

}