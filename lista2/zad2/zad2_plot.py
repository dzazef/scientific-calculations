from matplotlib import pyplot as plt
import numpy as np

x = np.linspace(25, 40)
y = (np.e ** x) * (np.log(1 + (np.e**(x * (-1)))))

plt.plot(x, y)
plt.savefig('zad2_plot_py.png', dpi=700)
