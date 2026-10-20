# ADR-001: Tecnología base de RutaColca

- **Estado:** Aceptada (decisión dada por el caso)
- **Contexto:** MVP en 1 mes con 4 desarrolladores apoyados por asistentes de IA; picos en julio, agosto y feriados largos; los pagos los procesa un tercero.
- **Decisión:** Web del turista en React (SPA); portal de agencias en React como PWA; API en Java 21 con Spring Boot; PostgreSQL 16; despliegue en un proveedor cloud con Docker.
- **Consecuencias:** stack conocido por el equipo; la API se escala con réplicas detrás de un balanceador; la PWA permite el trabajo sin conexión (ver ADR-002).
