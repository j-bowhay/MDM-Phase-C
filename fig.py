from frispy.disc import Disc
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.animation import FuncAnimation

import scienceplots

plt.style.use(['science','ieee'])


def get_edge(radii, n=20):
    alpha = np.linspace(0, 2*np.pi, n)
    r = radii * np.ones(n)
    x = r * np.cos(alpha)
    y = r * np.sin(alpha)
    z = np.zeros(n)
    return np.array([x, y, z]).T

def get_disc(clay,result, i):
    phi = result["phi"][i]
    theta = result["theta"][i]
    r = clay.eom_class.rotation_matrix_from_phi_theta(phi, theta)
    edge = get_edge(0.5)
    edge_T = edge @ r
    return edge_T

def main():
    clay = Disc(vz=2, vx=20, z=0.1, phi=0.174533)
    result1 = clay.compute_trajectory(flight_time=10)[0]
    
    fig, ax = plt.subplots(ncols=1, nrows=4, sharex=True, figsize=(5,4))

    ax[0].plot(result1["x"], result1["z"], "r")
    ax[1].plot(result1["x"], result1["phi"], "g")
    ax[2].plot(result1["x"], result1["theta"], "b")
    ax[3].plot(result1["x"], result1["gamma"], "k")

    ax[0].set_ylabel(r"Height $z$ [m]")
    ax[1].set_ylabel(r"Pitch angle $\theta$ [rad]")
    ax[2].set_ylabel(r"Roll angle $\phi$ [rad]")
    ax[3].set_ylabel(r"Yaw angle $\psi$ [rad]")
    ax[3].set_xlabel("Time [s]")
    plt.setp(ax, xlim=[0,30])
    plt.tight_layout()
    fig.align_labels()
    
    plt.savefig("t.png")


if __name__ == "__main__":
    main()