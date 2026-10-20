# E3 · Revisión cruzada (Paso 5)

Revisión del modelo con la lista del Anexo A (título, leyenda, elementos, siglas, relaciones, notación, audiencia) y apoyo de IA como auditor (prompt P5). Cada hallazgo se verificó contra el `workspace.dsl` antes de aceptarse.

> **Para el grupo:** esta tabla recoge los hallazgos de la auditoría del modelo base. Intercambien el `workspace.dsl` con otro grupo, agreguen **sus** hallazgos en las filas 6 en adelante y completen la columna «Responsable».

**Tabla 7. Registro de hallazgos**

| N.º | Hallazgo | Elemento o relación | Gravedad | ¿Lo aceptamos? | Motivo |
|---|---|---|---|---|---|
| 1 | El guía no aparecía en el diagrama de contexto: solo se conecta con WhatsApp y `include *` omite elementos sin relación directa con RutaColca. | Persona «Guía de turismo» | Alta | **Sí** (corregido con `include guia` en Contexto y Contenedores) | El caso (HU-04) lo define como destinatario; la verificación del contexto exige las cuatro personas. |
| 2 | Los sistemas externos salían azules en las exportaciones a C4-PlantUML (se perdía la etiqueta «Externo»). | Pasarela, WhatsApp, AUTOCOLCA | Media | **Sí** (propiedad `c4plantuml.tags "true"`) | El Anexo A pide notación explicada y externos en gris. |
| 3 | La vista dinámica mostraba la numeración duplicada («1: 1. …») por numerar a mano. | Vista «Dinamico» | Baja | **Sí** (se quitó la numeración manual) | Structurizr ya numera los pasos; evita confusión. |
| 4 | En el despliegue aparecían flechas directas web→API además de las que pasan por el balanceador. | Vista «DespliegueProduccion» | Media | **Sí** (`exclude` de las flechas derivadas directas) | El tráfico real pasa por el balanceador. |
| 5 | Las siglas SPA y PWA no se explicaban. | Contenedores Web y Portal | Baja | **Sí** (se explican en la descripción de cada contenedor) | Anexo A, aspecto «Siglas». |
| 6 | La pasarela de pagos podría recibir directamente los datos de tarjeta desde la web (para que RutaColca nunca los toque). | Relación Web → Pasarela (no modelada) | Media | **No, por ahora** | No está en el caso ni en el ADR-001; se registra como mejora para una siguiente iteración. |

## Resultado de la lista de revisión (Anexo A)

| Aspecto | ¿Cumple? | Evidencia |
|---|---|---|
| General: título, alcance, leyenda | Sí | Cada vista tiene `title`; la leyenda se genera al exportar (`SHOW_LEGEND`). |
| Elementos: nombre, tipo, descripción, tecnología | Sí | Todas las personas, sistemas y contenedores tienen descripción; contenedores con tecnología. |
| Siglas | Sí | SPA y PWA explicadas en las descripciones. |
| Relaciones: etiqueta, dirección, protocolo | Sí | Todas unidireccionales, con verbo + preposición; entre contenedores llevan protocolo (JSON/HTTPS, JDBC, IndexedDB API). |
| Notación: colores, formas | Sí | Persona = azul oscuro con ícono; sistema propio = azul; externo = gris; contenedor = verde; almacén de datos = cilindro; reto = naranja con línea discontinua. |
| Audiencia | Parcial | Entendible sin explicación; falta probarlo con otro grupo (Paso 6). |
