# E1 · Inventario C4 de RutaColca (Paso 1)

Clasificación de cada elemento del caso según las abstracciones del modelo C4.

| Elemento del caso | Tipo C4 | Justificación (una línea) |
|---|---|---|
| Turista | Persona | Rol humano que busca tours, reserva y paga usando la web. |
| Operador de agencia | Persona | Rol humano de la agencia que publica tours y registra reservas en el portal. |
| Guía de turismo | Persona | Rol humano que **sí** forma parte del contexto: recibe el itinerario y la lista del grupo (por WhatsApp), aunque no use la plataforma. |
| Administrador | Persona | Rol humano que aprueba agencias y consulta reportes de ventas. |
| RutaColca | Sistema de software (propio) | Es el sistema en estudio; en el contexto se dibuja como una sola caja. |
| Pasarela de pagos | Sistema de software (externo) | Servicio de terceros que procesa el cobro; RutaColca no guarda datos de tarjetas. |
| WhatsApp Business | Sistema de software (externo) | Servicio de terceros por el que se entrega el mensaje al guía. |
| Sistema de AUTOCOLCA | Sistema de software (externo) | Sistema ajeno que emite y valida el boleto turístico (supuesto didáctico, API HTTPS). |
| Web del turista | Contenedor (aplicación) | Aplicación React (SPA) que se ejecuta en el navegador del turista. |
| Portal de agencias | Contenedor (aplicación) | Aplicación React (PWA) usada por operadores y administrador. |
| API | Contenedor (aplicación) | Aplicación Java 21 con Spring Boot que concentra las reglas de negocio. |
| Base de datos | Contenedor (almacén de datos) | PostgreSQL 16; es un almacén de datos, no un servidor ni un contenedor Docker. |
| *(Reto, Paso 8)* Almacén local sin conexión | Contenedor (almacén de datos) | IndexedDB en el navegador de la tablet; guarda reservas hasta que haya internet. |

## Decisión del grupo: ¿el guía es persona del contexto?

**Sí.** C4 modela a las personas que interactúan con el sistema, y el guía es un destinatario directo del producto (HU-04), aunque la interacción pase por WhatsApp. El diagrama de contexto lo muestra conectado a **WhatsApp Business** (no a RutaColca), para dejar claro que no usa la plataforma.

## Nota sobre Docker

Docker **no** es un contenedor C4: aparece solo en el diagrama de despliegue, como nodo de infraestructura donde corre la API.
