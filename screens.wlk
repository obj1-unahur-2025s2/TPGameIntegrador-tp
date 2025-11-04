
object menuInicial{
    method image() = "fondoMenu.png"
    method position() = game.at(0, 0)

    method setup(){
        game.addVisual(self)
        game.addVisual(titulo)
        game.addVisual(btnIniciar)
    }

    method removeVisualElements(){
        game.removeVisual(self)
        game.removeVisual(titulo)
        game.removeVisual(btnIniciar)
    }
}

object titulo{
    method image() = "tituloMenu.png"
    method position() = game.at(8, 3)
}

object btnIniciar{
    method image() = "botonJugar.png"
    method position() = game.at(8, -1)
}


object paredMazmorra{
  method esHostil() = false
  method image() = "paredMazmorra.png"
  method position() = game.at(0, 0)
}

object nivel1Keys{
  method esHostil() = false
  method image() = "nivel1Keys.png"
  method position() = game.at(1.5, 1.5)
}

object cartelNivel1{
  method image() = "cartelNivel1.png"
  method position() = game.at(1.5, 1.5)
}

object cartelNivel2{
  method image() = "cartelNivel2.png"
  method position() = game.at(1.5, 1.5)
}