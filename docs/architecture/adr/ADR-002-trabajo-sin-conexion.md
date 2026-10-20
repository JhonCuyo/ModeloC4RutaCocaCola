# ADR-002: Trabajo sin conexión para reservas presenciales en Chivay

- **Estado:** Aceptada
- **Fecha:** 2026-10-20
- **Historia relacionada:** HU-05 · **Decisión previa:** ADR-001 (tecnología)

## Contexto

Las agencias de Chivay tienen conexión intermitente, pero deben registrar reservas presenciales y sincronizarlas cuando vuelva internet. El MVP debe salir en 1 mes con 4 desarrolladores y el ADR-001 ya fijó React (PWA), Java 21 con Spring Boot y PostgreSQL 16. No conviene introducir nuevas tecnologías de servidor.

## Decisión

El **portal de agencias**, que ya es una PWA, guarda las reservas presenciales en un nuevo contenedor local y las envía a la API cuando detecta conexión.

| Pregunta del reto | Respuesta |
|---|---|
| ¿Qué contenedor nuevo aparece? ¿Aplicación o almacén de datos? ¿Tecnología? | **Almacén local sin conexión**: es un **almacén de datos**, con tecnología **IndexedDB** (navegador). Se escribe desde el service worker/portal. |
| ¿Qué relación nueva tiene el portal y qué cambia en portal → API? | Nueva: *Portal → Almacén local* «Guarda reservas pendientes en» (IndexedDB API). Cambia: la relación portal → API gana una variante **diferida**, «Sincroniza reservas pendientes con» (JSON/HTTPS, con clave de idempotencia), que ocurre al volver la conexión, no en el momento de la venta. |
| ¿En qué nodo del despliegue corre el contenedor nuevo? | En el nodo **Navegador web** de la **Tablet de la agencia**, junto al portal. |
| ¿Qué riesgo introduce y qué regla lo resuelve? | Riesgo: **sobreventa** (dos agencias venden el último cupo mientras están sin conexión). Regla abajo. |

### Regla para evitar la sobreventa

1. **Cupo de contingencia:** antes de quedar sin conexión, cada agencia recibe de la API una cuota de cupos por salida (el portal la descarga y la guarda). Sin conexión solo se vende dentro de esa cuota.
2. **El servidor manda:** toda reserva offline se guarda como *pendiente de confirmación*; la API la confirma al sincronizar y, si ya no hay cupo, la rechaza con el motivo «sin cupo» y la agencia contacta al turista.
3. **Idempotencia:** cada reserva lleva una clave única generada en la tablet; reenviar no duplica la reserva.
4. **Boleto del Colca:** la validación con AUTOCOLCA requiere conexión; las reservas offline quedan *pendientes de validación* y se validan al sincronizar.
5. **Pagos:** el cobro en línea no se hace offline; las reservas presenciales registran el pago como «cobrado en agencia» y se concilian después.

## Consecuencias

**Positivas**
- Reutiliza el stack del ADR-001; no agrega servidores ni mensajería.
- La agencia de Chivay puede vender aunque se caiga internet.

**Negativas / riesgos**
- Existe un periodo en que la reserva offline no está confirmada; se debe comunicar claramente al turista.
- La cuota de contingencia puede dejar cupos sin vender; hay que calibrarla por agencia.
- Datos guardados en la tablet: deben limitarse al mínimo y no incluir datos de tarjetas.
- Más pruebas: sincronización, conflictos y reintentos.

**Impacto en el modelo C4:** nuevo contenedor y relaciones en `ContenedoresReto`; nueva instancia en el nodo de la tablet en `DespliegueProduccion`. El contexto no cambia.
