#!/usr/bin/env python
# coding: utf-8

# In[6]:


import plotly.graph_objects as go
import numpy as np
np.random.seed(1)

N = 100
x = np.random.rand(N)
y = np.random.rand(N)
colors = np.random.rand(N)
sz = np.random.rand(N) * 30

fig = go.Figure()
fig.add_trace(go.Scatter(
    x=x,
    y=y,
    mode="markers",
    marker=go.scatter.Marker(
        size=sz,
        color=colors,
        opacity=0.6,
        colorscale="Viridis"
    )
))

fig.show()
0
0.2
0.4
0.6
0.8
1
0
0.2
0.4
0.6
0.8
1
fig.write_image("fig1.png")


# In[ ]:




