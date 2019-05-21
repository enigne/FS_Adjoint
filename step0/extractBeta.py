import sys
sys.path.append('/home/chenggong/Uppsala/myResearch/pythonCodes/src/')
from BCData import *

folderList = ['./bcData/']
expNameList = ['']

topId = 3
bedId = 1
iterStep = [-1, -1]

coordXName = 'coordinate 1'
coordYName = 'coordinate 2'
uName= 'velocity 1'
vName= 'velocity 2'

bcExp = [BCData(folder, name, iterStep=it) for (folder, name, it) in zip(folderList, expNameList, iterStep)]

beta = bcExp[0].bed[[coordXName, 'basal fric']]

def outputDatafile(data, fileName):
    text = data.to_csv( sep=' ', float_format='%.8e', index=False, header=False)
    with open(fileName, 'w') as f:
        f.write(text)
        f.close()

outputDatafile(beta, 'beta.dat')

