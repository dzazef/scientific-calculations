import matplotlib.pyplot as plt
import csv


def make_plot(name, label):
    x = []
    y = []
    with open(name + '.csv', 'r') as csvfile:
        points = csv.reader(csvfile, delimiter=';')
        for row in points:
            x.append(float(row[0]))
            y.append(float(row[1]))
    plt.plot(x, y)
    plt.title(label)
    plt.savefig(name + '.png')
    plt.clf()


plots = [
    ['1', 'c=-2, x0=1'],
    ['2', 'c=-2, x0=2'],
    ['3', 'c=-2, x0=1.99999999999999'],
    ['4', 'c=-1, x0=1'],
    ['5', 'c=-1, x0=-1'],
    ['6', 'c=-1, x0=0.75'],
    ['7', 'c=-1, x0=0.25']
]
for plot in plots:
    make_plot(plot[0], plot[1])
