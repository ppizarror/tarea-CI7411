"""
Genera un archivo leible por DEEPSOIL
"""

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

# Carga los principales datos
hz = int(data[8].replace('Sample rate: ','').replace(' Hz','').strip())
samplenum = int(data[9].replace('Sample number: ','').strip())
dt = 1.0/hz

# Genera el ew
def writedata(m,col):
    nfm = filename + m #Nombre del archivo
    if '.txt' not in nfm:
        nfm += '.txt'
    f = open(nfm,'w')
    f.write('{0}\t{1}\n'.format(samplenum,dt))
    for i in range(samplenum):
        f.write('{0}\t{1}'.format(dt*(i+1),data[i+15].strip().split('\t')[col]))
        if(i<samplenum-1):
            f.write('\n')

writedata('-ew',0)
writedata('-ns', 1)
writedata('-z', 2)
