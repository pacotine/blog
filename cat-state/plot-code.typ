```python
from matplotlib import transforms
import matplotlib.pyplot as plt
import numpy as np
from qutip import coherent, wigner, plot_wigner

def plot_wigner_2d_3d(psi):
    fig = plt.figure(figsize=(20, 8))
    
    ax = fig.add_subplot(1, 2, 1)
    plot_wigner(psi, fig=fig, ax=ax)

    ax = fig.add_subplot(1, 2, 2, projection='3d')
    plot_wigner(psi, fig=fig, ax=ax, projection='3d', colorbar=True)
     
def plot_wigner_3d(psi, alpha_max):
    fig = plt.figure(figsize=(9,9))

    widths = [6,3]
    heights = [6,3]
    spec = fig.add_gridspec(ncols=2, nrows=2, width_ratios=widths, height_ratios=heights)

    x = np.linspace(-alpha_max,alpha_max,200)
    wig = wigner(psi, x, x)
    psi_x = np.sum(wig, axis=0)
    psi_p = np.sum(wig, axis=1)

    ax = fig.add_subplot(spec[0,0], projection='3d')
    plot_wigner(psi, fig=fig, ax=ax, projection='3d')
    
    ax = fig.add_subplot(spec[0,1])
    base = plt.gca().transData
    rot = transforms.Affine2D().rotate_deg(90)
    ax.plot(x,-psi_p, transform = rot+base)
    ax.set_xticks([])
    ax.set_ylim(-alpha_max,alpha_max)
    
    ax = fig.add_subplot(spec[1,0])
    ax.plot(x, psi_x)
    ax.set_yticks([])
    ax.set_xlim(-alpha_max, alpha_max)
    
N = 30
alpha = coherent(N, 2.0)
plot_wigner_3d(alpha, alpha_max=7)
m_alpha = coherent(N, -2.0)
plot_wigner_3d(m_alpha, alpha_max=7)
cat_plus = (alpha + m_alpha)/(np.sqrt(2*(1+np.exp(-2*2.0*2.0))))
plot_wigner_2d_3d(cat_plus)

plt.show()
```