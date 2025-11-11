import personajes.*
import objetos.*

object nivel1{
    const murcielago1 = new MurcielagoDeCueva(
    vida = 20.randomUpTo(70).truncate(0)
  )
  const murcielago2 = new MurcielagoDeCueva(
    vida = 20.randomUpTo(70).truncate(0)
  )
  const murcielago3 = new MurcielagoDeCueva(
    vida = 20.randomUpTo(70).truncate(0)
  )
  const murcielago4 = new MurcielagoDeCueva(
    vida = 20.randomUpTo(70).truncate(0)
  )
  const murcielago5 = new MurcielagoDeCueva(
    vida = 20.randomUpTo(70).truncate(0)
  )
  const murcielago6 = new MurcielagoDeCueva(
    vida = 20.randomUpTo(70).truncate(0)
  )
  const murcielago7 = new MurcielagoDeCueva(
    vida = 20.randomUpTo(70).truncate(0)
  )
  const murcielago8 = new MurcielagoDeCueva(
    vida = 20.randomUpTo(70).truncate(0)
  )
  const murcielago9 = new MurcielagoDeCueva(
    vida = 20.randomUpTo(70).truncate(0)
  )

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
  method murcielagosNivel() = murcielagosNivel

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
  method picosNivel() = picosNivel

  const esqueletosEnNivel = []
  method esqueletosEnNivel() = esqueletosEnNivel
}