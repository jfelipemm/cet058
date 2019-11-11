def ehInteiro(texto):
    try: 
        int(texto)
        return True
    except ValueError:
        return False

def getTrecho(texto):
    trecho = ""
    if str.isalpha(texto[0]):
        i = 0
        while (str.isalpha(c[i])):
            trecho += c[i]
            i += 1
        return trecho
    else:
        i = 0
        while (ehInteiro(c[i])):
            trecho += c[i]
            i += 1
        return trecho

def retornaToken(texto):
    if (str.isalpha(texto[0])):
        return "<identificador, " + texto + ">"
    elif (ehInteiro(texto[0])):
        return "<inteiro, " + texto + ">"
    elif (texto == "+"):
        return "<soma,>"
    elif (texto == "-"):
        return "<subtração,>"
    elif (texto == "*"):
        return "<multiplicação,>"
    elif (texto == "/"):
        return "<divisão,>"
    elif (texto == "="):
        return "<atribuição,>"
    elif (texto == "<"):
        return "<menor,>"
    elif (texto == ">"):
        return "<maior,>"
    elif (texto == ">="):
        return "<maior-igual,>"
    elif (texto == "<="):
        return "<menor-igual,>"
    elif (texto == "=="):
        return "<igualdade,>"
    elif (texto == "!="):
        return "<diferente,>"
    elif (texto == "&&"):
        return "<AND,>"
    elif (texto == "||"):
        return "<OR,>"
    elif (texto == "\n"):
        return "<EOL,>"
    else:
        return "<undefined>"
        

name = input("Insira a expressão: ")
while (name != ""):
    for palavra in name.split():
        token = retornaToken(palavra)
        print(token, end = '')
    print()
    name = input("Insira a expressão: ")