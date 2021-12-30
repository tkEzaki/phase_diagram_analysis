# What is this repository?
We provide key functions to perform the phase diagram analysis on muli-variate time-series data,
which was proposed in Ezaki *et al.* *Communications Biology* **3**: 52 (2020).

# How to use
Since it is difficult to create a pipeline that performs phase diagram analysis automatically for arbitrary data, we provide the key functions and the code for a sample analysis using them.

- **sample_01_EstimatePMEM.m**
This sample demonstrates how to estimate *h* and *J* in the pairwise maximum entropy model (PMEM)
from binarized multivariate time-series data (see Eqs. (1) and (2) in Ezaki et al. (2020)). This sample also checks if the means and correlations of variables are similar between the empirical data and estimated PMEM.

- **sample_02_PhaseDiagram.m**
This sample demonstrates how to sample data from an Ising model (which was created by affine-transformation of $J$ estimated from the input data; Eq. (3) in Ezaki et al. (2020)) and compute physical quantities to draw phase diagrams (see Figs. 1 a-d in Ezaki et al. (2020)).

- **sample_03_EstimateParticipantMuSigma.m** This sample demonstrates how to estimate the mu and sigma values for each participant using the phase diagrams (see Fig. 2 in Ezaki et al. (2020)).

# Acknowledgement
We acknowledge Michio Inoue for his valuable instructions on procedures used in **sample_03_EstimateParticipantMuSigma.m**. 
We also thank Douglas M. Schwarz for providing an open source function ("intersection.m", Copyright (c) 2017, Douglas M. Schwarz) used and redistributed in this repository in accordance with its LICENCE TERMS.