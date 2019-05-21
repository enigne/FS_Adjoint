
# coding: utf-8

# In[1]:


import pandas as pd
import matplotlib.pyplot as plt


# In[2]:



def outputDEM(data, nameList, boundaryID, timeStep, xdataName, ydataName):
    bcData = data[(data['Boundary condition'] == boundaryID) & 
                 (data['Time step'] == timeStep)].sort_values(xdataName)
    
    DEMData = bcData[[xdataName, ydataName]]
    return DEMData

def outputDatafile(data, fileName):
    Nx = len(data)
    Ny = 1
    text = data.to_csv( sep=' ', float_format='%.4f', index=False, header=False)
    with open(fileName, 'w') as f:
        f.write(text)
        f.close()


# In[3]:


filename = 'reference.dat'

# Read in name list
nameList = pd.read_csv( filename + '.names', 
                       delimiter=r': ',
                       index_col=0, 
                       skiprows=range(8), 
                       names = ['ID','name'] )

# Read in data
data = pd.read_csv( filename, 
                   delim_whitespace=True, 
                   names=nameList['name'])


# In[4]:


topId = 3
bedId = 1
timeStep = 10

coordXName = 'coordinate 1'
coordYName = 'coordinate 2'
velName= 'velocity 1'
#betaName = 'stress vector 2'


surf = outputDEM(data, nameList, topId, timeStep, coordXName, coordYName)
bed =  outputDEM(data, nameList, bedId, timeStep, coordXName, coordYName)
Usurf = outputDEM(data, nameList, topId, timeStep, coordXName, velName)


# In[5]:


# Create UDEM
outputDatafile(surf, 'zsDEM.dat')    
outputDatafile(bed, 'zbDEM.dat')    
outputDatafile(Usurf, 'UDEM.dat')    


