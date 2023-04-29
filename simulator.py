from frispy.disc import Disc
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.animation import FuncAnimation


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
    clay = Disc(vz=5)
    result1 = clay.compute_trajectory(flight_time=10)[0]
    
    fig = plt.figure()
    ax = fig.add_subplot(projection="3d")
    
    def update(frame):
        ax.clear()
        ax.set_xlim((0,25))
        ax.set_ylim((-5,5))
        ax.set_zlim((-5,10))
        ax.axis('equal')
        edge_T = get_disc(clay, result1, frame)
        disc = ax.plot_trisurf(edge_T[:, 0] + result1["x"][frame], edge_T[:, 1] + result1["y"][frame], edge_T[:, 2] + result1["z"][frame])
        ax.plot3D(result1["x"], result1["y"], result1["z"], "gray")
        return disc,
    
    ani = FuncAnimation(fig, update, frames=range(len(result1["x"])), interval=1)
    
    plt.show()


if __name__ == "__main__":
    main()