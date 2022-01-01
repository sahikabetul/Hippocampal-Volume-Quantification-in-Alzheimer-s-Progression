# Hippocampal Volume Quantification in Alzheimer's Progression
## 3D Medical Image Segmentation - Udacity AI for Healthcare Course

Alzheimer's disease (AD) is a progressive neurodegenerative disorder that results in impaired neuronal (brain cell) function and eventually, cell death. AD is the most common cause of dementia. Clinically, it is characterized by memory loss, inability to learn new material, loss of language function, and other manifestations.

For patients exhibiting early symptoms, quantifying disease progression over time can help direct therapy and disease management.

A radiological study via MRI exam is currently one of the most advanced methods to quantify the disease. In particular, the measurement of hippocampal volume has proven useful to diagnose and track progression in several brain disorders, most notably in AD. Studies have shown a reduced volume of the hippocampus in patients with AD.
<img src="https://www.researchgate.net/profile/Placido-Pinheiro/publication/241683930/figure/fig1/AS:298616825630725@1448207207889/Differences-between-a-normal-and-an-AD-brain.png" width="800px" height="auto">

In this project, I built an end-to-end AI system which features a machine learning algorithm that integrates into a clinical-grade viewer and automatically measures hippocampal volumes of new patients, as their studies are committed to the clinical imaging archive.

I used the dataset that contains the segmentations of the right hippocampus and I used the U-Net architecture to build the segmentation model.

After that, I integrated the model into a working clinical PACS such that it runs on every incoming study and produces a report with volume measurements.

## Dataset

We are using the "Hippocampus" dataset from the Medical Decathlon competition. This dataset is stored as a collection of NIFTI files, with one file per volume, and one file per corresponding segmentation mask. The original images here are T2 MRI scans of the full brain. As noted, in this dataset we are using cropped volumes where only the region around the hippocampus has been cut out. This makes the size of our dataset quite a bit smaller, our machine learning problem a bit simpler and allows us to have reasonable training times. You should not think of it as "toy" problem, though. Algorithms that crop rectangular regions of interest are quite common in medical imaging. Segmentation is still hard.
