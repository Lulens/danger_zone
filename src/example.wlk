class Empleado {
  var salud = 100
  const habilidades = []
  var puesto

  method estaIncapacitado() = salud < self.saludCritica()
  method saludCritica() = puesto.saludCritica()

  method puedeUsar(habilidad) = !self.estaIncapacitado() && self.poseeHabilidad(habilidad)

  method poseeHabilidad(habilidad) = habilidades.contains(habilidad)
  
  method cumplirMision(habilidadesRequeridas, peligrosidad) {
    if (self.puedeCumplirMision(habilidadesRequeridas)) {
      self.recibirDanio(peligrosidad)
      if (self.salud > 0) {
        self.registrarMisionCompletada()
      }
    }
    }
  method registrarMisionCompletada()
}

class Jefe inherits Empleado {
  const subordinados = []

  override method poseeHabilidad(habilidad) =
    super(habilidad) or self.algunSubordinadoLaTiene(habilidad)

  method algunSubordinadoLaTiene(habilidad) =
    subordinados.any { subordinado => subordinado.puedeUsar(habilidad) }
    
  override method registrarMisionCompletada()
}

object PuestoEspia {
  method saludCritica() = 15
}

class PuestoOficinista {
  var cantEstrellas = 0
  method saludCritica() = 40 - 5 * cantEstrellas
  
    override method registrarMisionCompletada() {
    self.cantEstrellas = self.cantEstrellas + 1
    if (self.cantEstrellas == 3) {
      self.promoverAEspia()
    }
  }

  method promoverAEspia()
}

class Equipo {
  var miembros = []

  method puedeCumplirMision(habilidadesRequeridas) =
    miembros.any { miembro => miembro.cumplirMision(habilidadesRequeridas) }

  method recibirDanioEquipo(peligrosidad) =
    miembros.forEach { miembro => miembro.recibirDanio(peligrosidad / miembros.size) }
    
    method cumplirMision(habilidadesRequeridas, peligrosidad) {
    if (self.puedeCumplirMision(habilidadesRequeridas)) {
      self.recibirDanioEquipo(peligrosidad)
      self.registrarMisionCompletadaEquipo()
    }
  }

  method registrarMisionCompletadaEquipo()
}
