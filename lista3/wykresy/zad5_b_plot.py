import matplotlib.pyplot as plt
import numpy as np
import math

fig = plt.figure()
x = np.linspace(-0.5, 2.0, 1000)
y = 3*x-math.e**x
plt.plot(x, y, 'C0', label='3x-e^x')
plt.legend()
plt.axhline(y=0, color='k')
fig.show()
fig.savefig('zad5_b_plot.png', dpi=300)
