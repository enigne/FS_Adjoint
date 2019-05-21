
# coding: utf-8

# In[1]:


import pandas as pd
import sys

# In[2]:


X0 = #X0#
w = #W#
dbeta = #DBETA#


# In[3]:


# set pertubation function
x0 = X0 * 1e4
width = w* 1e4
dbetaRel = dbeta * 1e-2


# In[4]:


# Read in the original beta 
betaFile = '../../Data/beta.dat'
outputFileName = '../../Data/beta_' + 'x' + str(X0).rjust(3, '0') +                                 '_w' + str(w).rjust(3, '0') +                                 '_d' + str(dbeta).rjust(3, '0') + '.dat'
data = pd.read_csv( betaFile, delim_whitespace=True, names=['x','beta']) 


# In[5]:


# perturb beta
pInd = abs(data['x'] - x0)< width*0.5
pBeta = data['beta']*(dbetaRel*pInd + 1.0)

# add to dataframe
data['perturb beta'] = pBeta


# In[6]:


# save to file
text = data[['x','perturb beta']].to_csv( sep=' ', float_format='%.8e', index=False, header=False)

with open(outputFileName, 'w') as f:
    f.write(text)
    f.close()
