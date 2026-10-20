# RutaColca · Caso práctico grupal AG-08 (Modelo C4)

Construcción de Software (1703243) · 2026-B · EPIS-UNSA

## Contenido (entregables)

| Código | Archivo |
|---|---|
| E1 | `docs/architecture/c4/ruta-colca/inventario.md` |
| E2 | `docs/architecture/c4/ruta-colca/workspace.dsl` (contexto, contenedores, dinámico) |
| E3 | `docs/architecture/c4/ruta-colca/revision-cruzada.md` y `explicacion.md` |
| E4 | `workspace.dsl` con despliegue (`DespliegueProduccion`) y vista `ContenedoresReto` |
| E5 | `docs/architecture/adr/ADR-002-trabajo-sin-conexion.md` (+ `ADR-001-tecnologia.md`) |
| E6 | `docs/architecture/c4/ruta-colca/export/` (C4-PlantUML `.puml`, Mermaid `.mmd` y PNG en `export/img/`) |
| E7 | `docs/architecture/c4/ruta-colca/bitacora-ia.md` |
| Extra | `docs/architecture/c4/ruta-colca/socializacion.md` (preguntas 6.2) |

## Vistas del modelo

`Contexto` · `Contenedores` · `ContenedoresReto` · `Dinamico` · `DespliegueProduccion`

## Cómo regenerar (desde la raíz del repositorio)

```bash
./structurizr.sh validate -w docs/architecture/c4/ruta-colca/workspace.dsl
./structurizr.sh export -w docs/architecture/c4/ruta-colca/workspace.dsl -f plantuml/c4plantuml -o docs/architecture/c4/ruta-colca/export
./structurizr.sh export -w docs/architecture/c4/ruta-colca/workspace.dsl -f mermaid -o docs/architecture/c4/ruta-colca/export
cd docs/architecture/c4/ruta-colca/export && java -jar plantuml.jar -tpng -o img *.puml
```

Verificado con Structurizr CLI v2025.11.09 (validación sin errores) y PlantUML.

## Pendiente para el grupo

- Completar los nombres en la columna *Responsable* de `bitacora-ia.md`.
- Hacer la revisión cruzada real con otro grupo y agregar sus hallazgos a `revision-cruzada.md`.
- Ensayar `explicacion.md` con sus propias palabras (la versión final es del vocero).
- Subir el enlace al *commit* final al Aula Virtual.
