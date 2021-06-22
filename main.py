#Prototipo de ensamblador en python
from textwrap import wrap
import re
def bindigits(n, bits):
    s = bin(n & int("1"*bits, 2))[2:]
    return("{0:0>%s}" % (bits)).format(s)
def shift(n):
    size = len(n)
    mod_string = n[:size - 2]
    mod_string = "11" + mod_string
    return mod_string

path = "lectura.s"
path2 = "prueba.mem"
regi = {
    "zero":"00000",
    "at":"00001",
    "v0":"00010",
    "v1":"00011",
    "a0":"00100",
    "a1":"00101",
    "a2":"00110",
    "a3":"00111",
    "t0":"01000",
    "t1":"01001",
    "t2":"01010",
    "t3":"01011",
    "t4":"01100",
    "t5":"01101",
    "t6":"01110",
    "t7":"01111",
    "s0":"10000",
    "s1":"10001",
    "s2":"10010",
    "s3":"10011",
    "s4":"10100",
    "s5":"10101",
    "s6":"10110",
    "s7":"10111",
    "t8":"11000",
    "t9":"11001",
    "k0":"11010",
    "k1":"11011",
    "gp":"11100",
    "sp":"11101",
    "fp":"11110",
    "ra":"11111"
}
opcode = { #Diccionario donde se comparan las funciones cuando se lee la linea del archivo lectura
    "add":["R", "000000", "100000"],
    "sub":["R", "000000", "100010"],
    "mul":["R", "011100", "000010"],
    "div":["R", "000000", "011010"],
    "or": ["R", "000000", "100101"],
    "and":["R", "000000", "100100"],
    "slt":["R", "000000", "101010"],
    "nop":["R", "000000", "000000"],
    "xor":["R", "000000", "100110"],
    "nor":["R", "000000", "100111"],
    "lw": ["IW", "100011"],
    "sw": ["IW", "101011"],
    "slti":["I", "001010"],
    "beq":["B", "000100"],
    "b":["BI", "000100"], 
    "andi":["I", "001100"],
    "ori":["I", "001101"],
    "addi": ["I", "001000"],
    "xori":["I", "001110"],
    "j": ["J", "000010"],
    "jr":["J", "000000", "001001"]
}
tags = {}
contador = 0
f = open(path2, "w")
f.write("")
f.close()
with open(path) as archivo: #Se abre archivo lectura para lectura
    for linea in archivo:   
        cadena = ""
        num1 = ""
        num2 = ""
        num3 = ""
        r = linea.strip("\n").split()
        if(r[0].startswith('.')):
            tags[r[0]] = contador
        elif(r[0] == "nop"):
            cadena = "00000000000000000000000000000000"
        elif(opcode[r[0]][0] == "R"):
            rd = list(r[1])
            for a in rd:
                if(a.isalnum()):
                    num1+=a
                    if num1 in regi:
                        num1=regi[num1]      
            rs = list(r[2])
            for a in rs:
                if(a.isalnum()):
                    num2+=a
                    if num2 in regi:
                        num2=regi[num2]      
            rt = list(r[3])
            for a in rt:
                if(a.isalnum()):
                    num3+=a
                    if num3 in regi:
                        num3=regi[num3]
            try:
                cadena += opcode[r[0]][1]
                cadena += num2
                cadena += num3
                cadena += num1
                cadena += "00000"
                cadena += opcode[r[0]][2]
            except KeyError:
                cadena = "No pude leer tu cadena"
        elif(opcode[r[0]][0] == "I"):
            rt = list(r[1])
            for a in rt:
                if(a.isalnum()):
                    num1+=a
                    if num1 in regi:
                        num1=regi[num1] 
            rs = list(r[2])
            for a in rs:
                if(a.isalnum()):
                    num2+=a
                    if num2 in regi:
                        num2=regi[num2]
            inm = list(r[3])
            for a in inm:
                if(a.isnumeric()):
                    num3+=a
            num3.strip()
            num3 = int(num3)
            num3 = bin(num3)[2:].zfill(16)
            num3 = str(num3)
            try:
                cadena += opcode[r[0]][1]
                cadena += num2
                cadena += num1
                cadena += num3
            except KeyError:
                cadena = "No pude leer tu cadena"
        elif(opcode[r[0]][0] == "IW"):
            rt = list(r[1])
            for a in rt:
                if(a.isalnum()):
                    num1+=a
                    if num1 in regi:
                        num1=regi[num1]
            base = r[2].partition("(")[2]
            offset = r[2].partition("(")[0]
            for a in base:
                if(a.isalnum()):
                    num2+=a
                    if num2 in regi:
                        num2=regi[num2]
            for a in offset:
                if(a.isnumeric()):
                    num3+=a
            num3.strip()
            num3 = int(num3)
            num3 = bin(num3)[2:].zfill(16)
            num3 = str(num3)
            try:
                cadena += opcode[r[0]][1]
                cadena += num2
                cadena += num1
                cadena += num3
            except KeyError:
                cadena = "No pude leer tu cadena"
        elif(opcode[r[0]][0] == "J"):
            index = list(r[1])
            for a in index:
                if(a.isalnum()):
                    num1+=a
            num1.strip()
            num1 = int(num1)
            num1 = bin(num1)[2:].zfill(26)
            num1 = str(num1)
            try:
                cadena += opcode[r[0]][1]
                cadena += num1
            except KeyError:
                cadena = "No pude leer tu cadena"
        elif(opcode[r[0]][0] == "BI"):
            num1 = "zero"
            if num1 in regi:
                num1=regi[num1] 
            num2 = "zero"
            if num2 in regi:
                num2=regi[num2]
            off = r[1]
            if off in tags:
                num3 = tags[off]
                num3 = int(num3)
                num3 =  num3 - contador
                num3 = bindigits(num3, 16)
                num3 = shift(num3)
                num3 = str(num3)
            else:
                for a in off:
                    if(a.isnumeric()):
                        num3+=a
                num3.strip()
                num3 = int(num3)
                num3 = bin(num3)[2:].zfill(16)
                num3 = str(num3)
            try:
                cadena += opcode[r[0]][1]
                cadena += num2
                cadena += num1
                cadena += num3
            except KeyError:
                cadena = "No pude leer tu cadena"
        elif(opcode[r[0]][0] == "B"):
            rt = list(r[1])
            for a in rt:
                if(a.isalnum()):
                    num1+=a
                    if num1 in regi:
                        num1=regi[num1] 
            rs = list(r[2])
            for a in rs:
                if(a.isalnum()):
                    num2+=a
                    if num2 in regi:
                        num2=regi[num2]
            off = r[3]
            if off in tags:
                num3 = tags[off]
                num3 = int(num3)
                num3 =  num3 - contador
                num3 = bindigits(num3, 16)
                num3 = shift(num3)
                num3 = str(num3)
            else:
                for a in off:
                    if(a.isnumeric()):
                        num3+=a
                num3.strip()
                num3 = int(num3)
                num3 = bin(num3)[2:].zfill(16)
                num3 = str(num3)
            try:
                cadena += opcode[r[0]][1]
                cadena += num2
                cadena += num1
                cadena += num3
            except KeyError:
                cadena = "No pude leer tu cadena"
        s = wrap(cadena, 8)
        f = open(path2, "a")#Se abre archivo prueba para escribir la cadena
        for x in s:
            f.write(x)
            f.write("\n")
        f.close()
        if not r[0].startswith('.'):
            contador+=4