# Satellite Simulation Project
This project was developed for a MATLAB-based mechanical engineering programming course.

## Overview
Developed and visualized a large-scale orbital simulation modeling the trajectories of thousands of satellites using Newton’s Second Law and the Euler-Cromer numerical integration method.

## Physics Model 
The simulation models satellite motion under gravitational forces, with optional atmospheric drag, using Newton’s Second Law. Each satellite is treated as a point mass orbiting Earth.

The governing equation of motion is:

[
\vec{a} = -\frac{GM}{r^3}\vec{r} - \frac{C_d \rho A}{2m} \vec{v} |\vec{v}|
]

where:

* ( G ) is the gravitational constant
* ( M ) is the mass of Earth
* ( \vec{r} ) is the position vector
* ( \vec{v} ) is the velocity vector
* ( C_d ) is the drag coefficient
* ( \rho ) is atmospheric density
* ( A ) is the projected area of the satellite

The equations of motion are numerically integrated using the Euler-Cromer method:

[
\vec{v}_{n+1} = \vec{v}_n + \vec{a}_n \Delta t
]

[
\vec{r}_{n+1} = \vec{r}*n + \vec{v}*{n+1} \Delta t
]

This method improves numerical stability compared to standard Euler integration, making it well-suited for simulating orbital motion over extended time periods.

The model assumes a simplified two-body system and neglects higher-order perturbations such as gravitational influences from other bodies and atmospheric variation with altitude.

## Key Features
- Simulates large-scale multi-body orbital motion
- Efficient numerical integration using Euler-Cromer method
- 3D visualization of satellite trajectories
- Automated extraction of orbital characteristics

## Results / Visualization

### Single Satellite Orbit
<p align="center">
  <img src="images/orbit_single.png" alt="3D visualization of a single satellite orbit around Earth" width="500">
</p>

Visualization of an individual satellite orbiting Earth, demonstrating the simulated trajectory generated from the Euler-Cromer integration method.

### Multi-Satellite Orbital Evolution
<p align="center">
  <img src="images/orbit_all.png" alt="3D visualization of all satellites at two different times" width="800">
</p>

Comparison of satellite positions at the start of the simulation and after 6000 seconds, showing the evolution of the orbital system over time.

### Altitude and Speed vs. Time
<p align="center">
  <img src="images/altitude_speed.png" alt="Altitude and speed plots for the first six satellites over time" width="800">
</p>

Time-history plots of altitude and speed for the first six satellites, illustrating periodic orbital behavior and variation in satellite motion.


## Tools Used
- MATLAB

## Technical Contributions
- Implemented a numerical solver to compute the time evolution of satellite position and velocity
- Applied Newton’s Second Law using the Euler-Cromer integration scheme
- Developed modular functions for simulation, data input, and trajectory computation
- Generated 3D visualizations for both individual and multi-satellite systems
- Produced time-series plots to analyze orbital behavior
- Computed orbital period and total distance traveled for each satellite

## How to Run
1. Download all project files:
   - `MAE_8_Project.m`
   - `earth_topo.m`
   - `read_input.m`
   - `satellite.m`
   - `satellite_data.txt`
2. Open `MAE_8_Project.m` in MATLAB
3. Run the script
