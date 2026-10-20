workspace "RutaColca" "Modelo C4 de RutaColca" {

    !identifiers hierarchical

    model {
        // PASO 2 · Personas: un rol humano por elemento
        turista = person "Turista" "Visitante que busca tours del valle del Colca, reserva una salida y paga en línea."
        operador = person "Operador de agencia" "Personal de una agencia de Arequipa o Chivay que publica tours, fechas y cupos, y registra reservas."
        guia = person "Guía de turismo" "Conduce al grupo en la salida; recibe el itinerario y la lista del grupo por WhatsApp, no usa la plataforma."
        admin = person "Administrador" "Aprueba a las agencias que se registran y revisa las ventas por agencia y por mes."

        // PASO 2 · El sistema en estudio (una sola caja en el contexto)
        ruta = softwareSystem "RutaColca" "Plataforma del consorcio de agencias para publicar tours, reservar salidas, cobrar en línea y avisar a los guías." {
            // PASO 3 · Contenedores: aplicaciones y almacenes de datos
            web = container "Web del turista" "Permite buscar tours, elegir una salida, registrar el boleto turístico y pagar. SPA = aplicación de una sola página." "React (SPA)"
            portal = container "Portal de agencias" "Permite a las agencias publicar tours, fechas y cupos; al administrador aprobar agencias y ver ventas. PWA = aplicación web instalable." "React (PWA)"
            api = container "API de RutaColca" "Concentra las reglas de negocio: tours, cupos, reservas, validación del boleto, cobro y avisos." "Java 21, Spring Boot"
            db = container "Base de datos" "Guarda agencias, tours, salidas, cupos y reservas. No guarda datos de tarjetas." "PostgreSQL 16" "Base de datos"

            // PASO 8 · Reto sin conexión (HU-05): solo aparece en la vista ContenedoresReto
            offline = container "Almacén local sin conexión" "Guarda en la tablet las reservas presenciales hasta que vuelva internet." "IndexedDB (navegador)" "Base de datos,Reto"
        }

        // PASO 2 · Sistemas externos (etiqueta "Externo")
        pasarela = softwareSystem "Pasarela de pagos" "Servicio externo que procesa pagos con tarjeta o billetera móvil; guarda los datos de tarjeta." "Externo"
        whatsapp = softwareSystem "WhatsApp Business" "Servicio externo de mensajería que entrega mensajes a los guías." "Externo"
        autocolca = softwareSystem "Sistema de AUTOCOLCA" "Sistema externo que emite y valida el boleto turístico del Colca (supuesto didáctico)." "Externo"

        // Relaciones: origen -> destino "Verbo + preposición" "Protocolo"
        turista -> ruta.web "Busca tours y reserva desde" "HTTPS"
        operador -> ruta.portal "Publica tours y registra reservas en" "HTTPS"
        admin -> ruta.portal "Aprueba agencias y consulta ventas en" "HTTPS"

        ruta.web -> ruta.api "Solicita búsquedas, reservas y pagos a" "JSON/HTTPS"
        ruta.portal -> ruta.api "Envía tours, cupos y reservas a" "JSON/HTTPS"
        ruta.api -> ruta.db "Lee y guarda datos en" "JDBC"

        ruta.api -> autocolca "Valida el boleto turístico en" "JSON/HTTPS"
        ruta.api -> pasarela "Cobra las reservas en" "JSON/HTTPS"
        ruta.api -> whatsapp "Envía itinerarios y listas de grupo mediante" "JSON/HTTPS"
        whatsapp -> guia "Entrega el itinerario y la lista del grupo a" "WhatsApp"

        // PASO 8 · Relaciones del reto (etiqueta "Reto")
        ruta.portal -> ruta.offline "Guarda reservas pendientes en" "IndexedDB API" "Reto"
        ruta.portal -> ruta.api "Sincroniza reservas pendientes con" "JSON/HTTPS diferido, con clave de idempotencia" "Reto"

        // PASO 7 · Despliegue en producción (sin crear contenedores nuevos)
        prod = deploymentEnvironment "Produccion" {
            celular = deploymentNode "Celular del turista" "Android o iOS" "Smartphone" {
                navegador = deploymentNode "Navegador web" "Ejecuta la SPA del turista" "Chrome o Safari" {
                    web = containerInstance ruta.web
                }
            }
            tablet = deploymentNode "Tablet de la agencia" "Android o iPadOS" "Tablet" {
                navegador = deploymentNode "Navegador web" "Ejecuta la PWA y guarda datos locales" "Chrome o Safari" {
                    portal = containerInstance ruta.portal
                    offline = containerInstance ruta.offline
                }
            }
            cloud = deploymentNode "Proveedor cloud" "Región cercana a Perú" "Cloud" {
                lb = infrastructureNode "Balanceador de carga" "Recibe el tráfico HTTPS y lo reparte entre las réplicas de la API" "Balanceador gestionado"
                vm = deploymentNode "VM de aplicación" "Ubuntu Linux; 2 réplicas para temporada alta" "Máquina virtual" 2 {
                    docker = deploymentNode "Docker" "Ejecuta la imagen de la API" "Docker Engine" {
                        api = containerInstance ruta.api
                    }
                }
                dbnode = deploymentNode "PostgreSQL gestionado" "Servicio de base de datos administrado por el proveedor" "PostgreSQL 16" {
                    db = containerInstance ruta.db
                }
            }
        }

        // Relaciones entre nodos (fuera del bloque del entorno, con identificadores jerárquicos)
        prod.celular.navegador.web -> prod.cloud.lb "Envía peticiones a" "HTTPS"
        prod.tablet.navegador.portal -> prod.cloud.lb "Envía peticiones a" "HTTPS"
        prod.cloud.lb -> prod.cloud.vm.docker.api "Reparte peticiones a" "HTTP"
    }

    views {
        // Exportación a C4-PlantUML: conserva las etiquetas y los colores de los estilos
        properties {
            "c4plantuml.tags" "true"
        }

        // PASO 2
        systemContext ruta "Contexto" "Diagrama de contexto de RutaColca" {
            title "Contexto - RutaColca: quién lo usa y con qué servicios se conecta"
            include *
            include guia
            autolayout lr
        }

        // PASO 3
        container ruta "Contenedores" "Diagrama de contenedores de RutaColca" {
            title "Contenedores - RutaColca (MVP con ADR-001)"
            include *
            include guia
            exclude ruta.offline
            exclude "relationship.tag==Reto"
            autolayout tb
        }

        // PASO 8
        container ruta "ContenedoresReto" "Contenedores con trabajo sin conexión en Chivay (HU-05, ADR-002)" {
            title "Contenedores - RutaColca con reservas sin conexión (ADR-002)"
            include *
            include guia
            autolayout tb
        }

        // PASO 4 · Decisión: validar el boleto ANTES de cobrar (no cobrar algo que no se puede confirmar)
        dynamic ruta "Dinamico" "Reservar y pagar un tour" {
            title "Dinámico - Reservar y pagar un tour (HU-02 y HU-03)"
            turista -> ruta.web "Elige la salida, escribe su boleto y pulsa pagar"
            ruta.web -> ruta.api "Envía la reserva con el número de boleto"
            ruta.api -> ruta.db "Verifica y retiene el cupo de la salida"
            ruta.api -> autocolca "Valida el número de boleto turístico"
            ruta.api -> pasarela "Cobra el monto de la reserva"
            ruta.api -> ruta.db "Guarda la reserva confirmada"
            ruta.api -> whatsapp "Solicita enviar el itinerario de la salida"
            whatsapp -> guia "Entrega el itinerario y la lista actualizada del grupo"
            autolayout lr
        }

        // PASO 7
        deployment ruta "Produccion" "DespliegueProduccion" "Despliegue de RutaColca en producción" {
            title "Despliegue - RutaColca en producción"
            include *
            // El tráfico pasa por el balanceador: se ocultan las flechas directas derivadas del modelo estático
            exclude prod.celular.navegador.web->prod.cloud.vm.docker.api
            exclude prod.tablet.navegador.portal->prod.cloud.vm.docker.api
            autolayout lr
        }

        styles {
            element "Person" {
                shape Person
                background #0B3D62
                color #ffffff
            }
            element "Software System" {
                background #1B5E8B
                color #ffffff
            }
            element "Container" {
                background #0E7D73
                color #ffffff
            }
            element "Externo" {
                background #8C8C8C
                color #ffffff
            }
            element "Base de datos" {
                shape Cylinder
            }
            element "Reto" {
                background #B45F06
                color #ffffff
                border dashed
            }
            relationship "Reto" {
                dashed true
                color #B45F06
            }
        }
    }
}
