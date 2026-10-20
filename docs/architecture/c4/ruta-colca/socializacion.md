# Preguntas para la socialización (sección 6.2)

**1. ¿Por qué RutaColca es una sola caja en el contexto y un límite con varios contenedores en el siguiente nivel?**
Porque cada nivel responde una pregunta distinta. El contexto responde «quién lo usa y con qué se conecta» y no muestra el interior; el diagrama de contenedores hace zoom y responde «de qué aplicaciones y almacenes de datos está hecho». Mezclar ambos niveles confunde a la audiencia (regla de niveles de C4).

**2. ¿Qué diagrama mostrarían a la gerente y cuál al equipo de operaciones?**
A la gerente, el **contexto**: personas y servicios, sin tecnología. Al equipo de operaciones, **contenedores y despliegue**: tecnologías, protocolos, réplicas de la API y balanceador, que es lo que necesitan para operar la temporada alta.

**3. ¿Qué propuesta de la IA rechazaron y qué regla de C4 usaron?**
Ejemplos de este modelo: (a) la IA/plantilla dejaba fuera al guía del contexto → regla: todo rol humano que interactúa con el sistema (aunque sea vía un sistema externo) se modela como persona; (b) numerar a mano los pasos del dinámico → regla: la numeración la genera la herramienta, el modelo es fuente única; (c) dibujar Docker como contenedor → regla: un contenedor C4 es una aplicación o almacén de datos; Docker va solo como nodo de despliegue.

**4. ¿Qué cambió al resolver el reto sin conexión y en qué diagramas se nota?**
Se agregó el contenedor **Almacén local sin conexión** (IndexedDB) y la relación portal → almacén; la relación portal → API ganó una variante **diferida** con clave de idempotencia. Se nota en **ContenedoresReto** (nuevo contenedor y relaciones en naranja) y en **Despliegue** (el almacén corre en el navegador de la tablet de la agencia). No cambia el contexto.
