# Carga el archivo
from __future__ import print_function
import sys

if (len(sys.argv) < 1):
    print('El archivo no ha sido pasado por argumento, llamado: python correctada.py <filedata>')
filename = sys.argv[1]

# Carga el archivo a una lista
data = []
f = open(filename)
for i in f:
    data.append(i.strip())
f.close()  # Cierra el archivo

# Guarda el archivo sin el strip
u = open(filename, 'w')
k = 1  # Número de línea
for i in data:
    if (k >= 16):
        i = i.replace('  ', ' ')
        i = i.replace(' ', '\t')
    u.write(i+'\n')
    k += 1

# Cierra el archivo
u.close()
