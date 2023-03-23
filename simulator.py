from frispy.disc import Disc
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.tri import Triangulation

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
    ax.plot3D(result1["x"], result1["y"], result1["z"], "gray")
    
    edge_T = get_disc(clay, result1, 50)
    ax.plot_trisurf(edge_T[:, 0] + result1["x"][0], edge_T[:, 1] + result1["y"][0], edge_T[:, 2] + result1["z"][0])
    
    ax.axis('equal')
    ax.set_xlabel("x")
    ax.set_ylabel("y")
    ax.set_zlabel("z")
    
    plt.show()


if __name__ == "__main__":
    main()