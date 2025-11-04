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

object nivel1{

  method setup() {
    menuInicial.removeVisualElements()

    game.addVisual(paredMazmorra)
    game.addVisual(nivel1Keys)
    game.addVisualCharacter(heroe)

    game.onTick(200, "bordes", { movimiento.comprobarBordes() })
    game.onTick(100, "movimientoHeroe", { movimiento.cambiarMediosHeroe() })

    game.addVisual(puertaFalsa)
    
  }

}