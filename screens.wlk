import niveles.*

object menuInicial{
    method image() = "fondoMenu.png"
    method position() = game.at(0, 0)

    method setup(){
        game.addVisual(self)
        game.addVisual(bordeMenu)
        game.addVisual(titulo)
        game.addVisual(btnIniciar)


        keyboard.enter().onPressDo({nivel.setupNivel1()})
    }

    method removeVisualElements(){
        game.removeVisual(self)
        game.removeVisual(titulo)
        game.removeVisual(btnIniciar)
        game.removeVisual(bordeMenu)
    }
}

object titulo{
    method image() = "tituloMenu.png"

    var posicion = game.at(8, 3)
    method position() = posicion

    method pantallaFinal(){
      posicion = game.at(2, 3)
    }
}

object btnIniciar{
    method image() = "botonJugar.png"
    method position() = game.at(8, -1)
}

object bordeMenu{
    method image() = "bordeMenu.png"
    method position() = game.at(0, 0)
}

object fondoNivel1{
  method esHostil() = false
  method esLaPuertaAlNivel2() = false

  method image() = "fondoNivel1.png"
  method position() = game.at(0, 0)
}

object fondoNivel2{
  method esHostil() = false
  method esLaPuertaAlNivel2() = false
  method esPicoCorrupto() = false

  method image() = "fondoNivel2.png"
  method position() = game.at(0, 0)
}

object nivel1Keys{
  method esHostil() = false
  method esLaPuertaAlNivel2() = false

  method image() = "nivel1Keys.png"
  method position() = game.at(1.5, 1.5)
}

object nivel2Keys{
  method esHostil() = false
  method esLaPuertaAlNivel2() = false
  method esPicoCorrupto() = false

  method image() = "nivel2Keys.png"
  method position() = game.at(20, 1.5)
}

object cartelNivel1{
  method esHostil() = false
  method esLaPuertaAlNivel2() = false

  method image() = "cartelNivel1.png"
  method position() = game.at(11, -1)
}

object cartelNivel2{
  method esHostil() = false
  method esLaPuertaAlNivel2() = false
  method esPicoCorrupto() = false

  method image() = "cartelNivel2.png"
  method position() = game.at(11, -1)
}

object gameOverScreen{
  method esHostil() = false
  method esLaPuertaAlNivel2() = false

  method image() = "gameOverScreen.png"
  method position() = game.at(0, 0)
}

object fondoEscape{
  method esHostil() = false
  method esLaPuertaAlNivel2() = false

  method image() = "fondoEscape.png"
  method position() = game.at(0, 0)
}