import matplotlib.pyplot as plt
import numpy as np
import math

fig = plt.figure()
x = np.linspace(-1.0, 10, 1000)
y = math.e ** (1 - x) - 1
plt.plot(x, y, 'C0', label='e^(1-x)-1')
plt.legend()
y = x * math.e ** (-x)
plt.plot(x, y, 'C1', label="x*e^(-x)")
plt.legend()
plt.axhline(y=0, color='k')
fig.show()
fig.savefig('zad6_plot.png', dpi=300)
