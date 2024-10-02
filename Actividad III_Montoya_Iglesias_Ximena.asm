
ORG 0x1000   ; Dirección de inicio del programa

; Variables
randomNumbers:  DS 20   ; Espacio para 20 números aleatorios
sortedNumbers:  DS 20   ; Espacio para números ordenados
seed:          DB 0xA5  ; Semilla para la generación de números aleatorios
option:        DB 0     ; Opción de orden: 0 = ascendente, 1 = descendente

INICIO
    ; Mostrar mensaje de inicio
    LD DE, MENSAJE_INICIO
    CALL IMPRIMIR_TEXTO

    ; Generar 20 números aleatorios
    CALL GENERAR_NUMEROS

    ; Mostrar números generados
    CALL MOSTRAR_NUMEROS

    ; Preguntar si ordenar ascendente o descendente
    LD DE, MENSAJE_ORDEN
    CALL IMPRIMIR_TEXTO
    CALL LEER_OPCION
    LD (option), A

    ; Ordenar los números
    CALL ORDENAR_NUMEROS

    ; Mostrar números ordenados
    CALL MOSTRAR_ORDENADOS

    ; Preguntar si continuar o terminar
    LD DE, MENSAJE_CONTINUAR
    CALL IMPRIMIR_TEXTO
    CALL LEER_OPCION
    CP 'S'       ; Si elige 'S', volver a empezar
    JP Z, INICIO

    ; Si no, mostrar mensaje de salida
    LD DE, MENSAJE_SALIR
    CALL IMPRIMIR_TEXTO

    HALT         ; Termina el programa

; Subrutinas

GENERAR_NUMEROS:
    LD HL, randomNumbers
    LD B, 20     ; Generar 20 números
LOOP_GENERAR:
    CALL GENERADOR_ALEATORIO
    LD (HL), A
    INC HL
    DJNZ LOOP_GENERAR
    RET

GENERADOR_ALEATORIO:
    LD A, (seed)
    XOR 0xA5      ; XOR con un valor constante
    LD (seed), A  ; Actualizar
    RET

MOSTRAR_NUMEROS:
    LD HL, randomNumbers
    LD B, 20
LOOP_MOSTRAR:
    LD A, (HL)
    CALL IMPRIMIR_NUMERO
    INC HL
    DJNZ LOOP_MOSTRAR
    RET

ORDENAR_NUMEROS:
    LD A, (option)
    CP 'A'         ; Ver si es ascendente (A) o descendente (D)
    JP Z, ORDENAR_ASC
    JP ORDENAR_B_DESC

ORDENAR_ASC:
    ; Ordenar de manera ascendente
    LD HL, randomNumbers
    LD DE, sortedNumbers
    CALL ORDENAR_B_ASC
    RET

ORDENAR_DESC:
    ; Ordenar de manera descendente
    LD HL, randomNumbers
    LD DE, sortedNumbers
    CALL ORDENAR_B_DESC
    RET

MOSTRAR_ORDENADOS:
    LD HL, sortedNumbers
    LD B, 20
LOOP_MOSTRAR_ORDENADOS:
    LD A, (HL)
    CALL IMPRIMIR_NUMERO
    INC HL
    DJNZ LOOP_MOSTRAR_ORDENADOS
    RET

; Subrutinas para imprimir texto y números
IMPRIMIR_TEXTO:
    ; Imprime el texto en DE hasta encontrar 0
    RET

IMPRIMIR_NUMERO:
    ; Imprime el número en A en decimal
    RET

LEER_OPCION:
    ; Leer opción del usuario
    RET

ORDENAR_B_ASC:
    ; Algoritmo para orden ascendente
    RET

ORDENAR_B_DESC:
    ; Algoritmo para orden descendente
    RET

; Mensajes
MENSAJE_INICIO:    DB 'Generando numeros aleatorios...', 0
MENSAJE_ORDEN:     DB 'Ordenar Ascendente (A) o Descendente (D)?', 0
MENSAJE_CONTINUAR: DB 'Continuar? (S/N)', 0
MENSAJE_SALIR:     DB 'Saliendo del programa...', 0

END
