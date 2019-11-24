import matplotlib.pyplot as plt
import numpy as np
import math

fig = plt.figure()
x = np.linspace(1.0, 2.0, 1000)
y = np.sin(x) - (0.5*x)**2
plt.plot(x, y, 'C0', label='sin(x)-(1/2x)^2')
plt.legend()
plt.axhline(y=0, color='k')
fig.show()
fig.savefig('zad4_plot.png', dpi=300)

