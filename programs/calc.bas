
INCLUDE "MBPP.BAS"

START:
  CLS
  GOSUB STARTPRG
  C = 3
  H = 11
  T = 2
  MOVE 30 13
  PRINT "Calculando..."
GOTO MAIN

MAIN:
  $5 = "Calculadora"
  $6 = "Suma|Resta|Multiplicacion|Division|Salir"
  GOSUB MENUBOX
  IF V = 1 THEN GOSUB ADD
  IF V = 2 THEN GOSUB SUB
  IF V = 3 THEN GOSUB MUL
  IF V = 4 THEN GOSUB DIV
  IF V = 5 THEN GOSUB ENDPROG
GOTO MAIN

ADD:
  V = 0
  $5 = "Suma"
  $6 = "Ingrese primer numero"
  $7 = "Ingrese segundo numero"
  GOSUB DINBOX
  a = a + b
  $6 = "Resultado:"
  $7 = ""
  GOSUB NUMBOX
RETURN

SUB:
  V = 0
  $5 = "Resta"
  $6 = "Ingrese numero base:"
  $7 = "Ingrese numero a restarle:"
  GOSUB DINBOX
  A = A - B
  $6 = "Resultado:"
  $7 = ""
  GOSUB NUMBOX
RETURN

MUL:
  V = 0
  $5 = "Multiplicacion"
  $6 = "Ingrese primer numero:"
  $7 = "Ingrese segundo numero"
  GOSUB DINBOX
  A = A * B
  $6 = "Producto:"
  $7 = ""
  GOSUB NUMBOX
RETURN

DIV:
  V = 0
  $5 = "Division"
  $6 = "Ingrese dividendo:"
  $7 = "Ingrese divisor:"
  GOSUB DINBOX
  $8 = "No es posible dividir entre cero"
  IF B = 0 THEN GOTO ERRBOX
  D = A / B
  E = A % B
  A = D
  B = E
  $6 = "Cociente:"
  $7 = "Residuo:"
  GOSUB NUMBOX
RETURN
