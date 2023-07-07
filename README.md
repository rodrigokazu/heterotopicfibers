# Axonal Guidance project of the Neuronal Pathways group

The corpus callosum (CC) is the largest forebrain commissure and mediates the connection between both brain hemispheres. Recent finds published by Szczupak et al. (2022) point to ~75% of interhemispheric callosal connections being heterotopic. This study used mice, marmosets, and humans with data from the Allen Mouse Brain Connectivity Atlas and high-resolution diffusion-weighted imaging. Still, the way the axons orient themselves during cortical development remains elusive. 

In the project, we aim to generate a 3D model of a cortical region with defined rules for axonal guidance. It will be developed using agent-based modelling, in Python. The model would comprise axons that grow at a similar speed and chemotaxis using signals such as netrin, Sonic hedgehog (SHH) and other guidance cues, secreted by the midline with an anteroposterior temporal gradient. If the axons do not reach the midline they are removed. When they do reach the midline, they attach to others to follow a non-predefined path to the cortex. 

The model would then be used to test with the current signals found in the literature are sufficient to reproduce Szczupak's results from brain development and if so, which of the variables are the key components to generate the proportion of heterotopic axons found. 
