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

## Integrantes Roles

| Integrante | Rol en la Parte A (Pasos 1 al 6) | Rol en la Parte B (Pasos 7 al 10 — Rotación) |
| :--- | :--- | :--- |
| **Diego** | **Modelador** (Inventario C4 y decisiones de diseño) | **Vocero** (Consolidación de la bitácora de IA) |
| **Jhon** | **Redactor del DSL** (Contexto, contenedores y vista dinámica) | **Revisor** (Verificación de despliegue y reto sin conexión) |
| **Wilber** | **Revisor** (Auditoría C4 y revisión cruzada) | **Redactor del DSL** (Despliegue en producción y exportación) |
| **Jaime** | **Vocero** (Explicación no técnica y registro inicial) | **Modelador** (Análisis del reto offline y redacción del ADR-002) |