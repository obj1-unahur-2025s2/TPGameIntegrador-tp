import personajes.*
import objetos.*
import screens.*
import enemigos.*

object colisiones {
  
  // colisiones del heroe con el entorno (evita que atraviese las paredes)
  method comprobarBordes() {
    if (heroe.position().y() >= (game.height() - 2)) heroe.position(
        heroe.position().down(1)
      )
    if (heroe.position().y() <= 1) heroe.position(heroe.position().up(1))
    if (heroe.position().x() <= 1) heroe.position(heroe.position().right(1))
    if (heroe.position().x() >= (game.width() - 2)) heroe.position(heroe.position().left(1))
  }
  
  method cambiarMediosHeroe() {
    keyboard.left().onPressDo({ heroe.cambiarAssetIzq() })
    keyboard.right().onPressDo({ heroe.cambiarAssetDer() })
  }
  
  method comprobarColisionesConHostiles() {

    game.whenCollideDo(
      heroe,
      { elemento =>
        if (elemento.esHostil()) {
          heroe.perderVida(elemento.daño())
          heroe.volverAlOrigen()
          nivel.reordenarPicos()
          
          if (!game.hasVisual(cartelNivel2)) {
            nivel.generarEsqueletoMortal()
          } else {
            nivel.generarEsqueletoMortal()
            nivel.generarEsqueletoMortal()
          }
          
          if (elemento.atacaConVeneno()) heroe.serEnvenenado()
          
          game.schedule(700, { heroe.restaurarAsset() })
          
          if (heroe.vida() <= 0) {
            game.addVisual(gameOverScreen)
            game.stop()
          }
        }
        
        if (elemento.esLaPuertaAlNivel2()) nivel.setupNivel2()

        if(elemento.esPicoCorrupto() and !elemento.estaDestruido()){
          esqueletoCorrupto.serDañado() 
          elemento.romperse() 
          nivel.reordenarPicosCorruptos()
        }

        if (elemento.esLaPuertaFinal()) nivel.escaparDeLaMazmorra()

      }
    )
  }
}

object nivel {
  
  const picosNivel = enemigosNivel.picosNivel()
  const murcielagosNivel = enemigosNivel.murcielagosNivel()
  var esqueletosEnNivel = enemigosNivel.esqueletosEnNivel()

  method reordenarPicos() {
    picosNivel.forEach({ p => p.reordenar() })
  }
  
  method moverMurcielagos() {
    murcielagosNivel.forEach({ m => m.moverse() })
  }
  
  method generarEsqueletoMortal() {
    if (esqueletosEnNivel.size() == 4) {
      return
    } else {
      const nuevoEsqueleto = new EsqueletoMortal()
      
      esqueletosEnNivel.add(nuevoEsqueleto)
      game.addVisual(nuevoEsqueleto)
    }
  }
  
  method moverEsqueletos() {
    esqueletosEnNivel.forEach({ e => e.moverse() })
  }

  const ambientacion = game.sound("ambientacion.mp3")
  
  // se inicia el nivel 1
  method setupNivel1() {
    if (!game.hasVisual(cartelNivel2) and !game.hasVisual(cartelNivel1)) {
      ambientacion.volume(0.7)
      ambientacion.play()
      ambientacion.shouldLoop(true)

      menuInicial.removeVisualElements()
      game.addVisual(fondoNivel1)
      game.addVisual(nivel1Keys)
      game.addVisual(cartelNivel1)
      game.addVisualCharacter(heroe)
      
      game.onTick(200, "bordes", { colisiones.comprobarBordes() })
      game.onTick(100, "movimientoHeroe", { colisiones.cambiarMediosHeroe() })
      
      colisiones.comprobarColisionesConHostiles()
      
      self.generarEsqueletoMortal()
      murcielagosNivel.forEach({ m => game.addVisual(m) })
      // cada 0.9s se mueven los murcielagos
      game.onTick(900, "movimientoMurcielagos", { self.moverMurcielagos() })
      // cada 1.5s se mueven los murcielagos
      game.onTick(1500, "movimientoEsqueletos", { self.moverEsqueletos() })
      
      picosNivel.forEach({ p => game.addVisual(p) })
      
      game.addVisual(puertaANivel2)
    }
  }
  
  const picoCorrupto1 = new PicoCorrupto()
  const picoCorrupto2 = new PicoCorrupto()
  const picoCorrupto3 = new PicoCorrupto()

  const picosCorruptosEnNivel = [picoCorrupto1, picoCorrupto2, picoCorrupto3]

  method reordenarPicosCorruptos(){
    picosCorruptosEnNivel.forEach({ pc => pc.reordenar() })
  }

  method picosCorruptosEnNivel() = picosCorruptosEnNivel

  method reapareceMurcielagos(){
    murcielagosNivel.forEach({ m => game.addVisual(m) })
  }

  // se inicia el nivel 2
  method setupNivel2() {
    esqueletosEnNivel = []
    corrosion.corromperEsqueletos()
    
    // ordenar visualmente los assets del nivel
    game.removeVisual(fondoNivel1)
    game.addVisual(fondoNivel2)
    
    game.removeVisual(nivel1Keys)
    game.removeVisual(cartelNivel1)
    
    game.addVisual(nivel2Keys)
    
    game.removeVisual(puertaANivel2)
    
    esqueletosEnNivel.forEach({ e => game.removeVisual(e) })
    murcielagosNivel.forEach({ m => game.removeVisual(m) })
    
    picosNivel.forEach({ p => game.removeVisual(p) })
    picosNivel.forEach({ p => game.addVisual(p) })

    picosCorruptosEnNivel.forEach({ pc => game.addVisual(pc) })

    game.removeVisual(heroe)
    game.addVisual(heroe)
    
    game.addVisual(esqueletoCorrupto)
    game.addVisual(cartelNivel2)
    self.reordenarPicos()
  }

  method derrotarEsqueletoCorrupto(){

    esqueletosEnNivel.forEach({ e => game.removeVisual(e) })
    murcielagosNivel.forEach({ m => game.removeVisual(m) })
    picosNivel.forEach({ p => game.removeVisual(p) })
    picosCorruptosEnNivel.forEach({ pc => game.removeVisual(pc) })
    game.removeVisual(nivel2Keys)

    game.removeTickEvent("movimientoMurcielagos")
    game.removeTickEvent("movimientoEsqueletos")
    game.removeTickEvent("bordes")
    game.removeTickEvent("movimientoHeroe")

    game.addVisual(puertaFinal)
  }

  method escaparDeLaMazmorra(){
    game.removeVisual(puertaFinal)

    game.removeVisual(fondoNivel2)
    game.addVisual(fondoEscape)

    titulo.pantallaFinal()
    game.addVisual(titulo)

    game.stop()
  }

}