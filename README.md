# Hippocampal Volume Quantification in Alzheimer's Progression
## 3D Medical Image Segmentation - Udacity AI for Healthcare Course

Alzheimer's disease (AD) is a progressive neurodegenerative disorder that results in impaired neuronal (brain cell) function and eventually, cell death. AD is the most common cause of dementia. Clinically, it is characterized by memory loss, inability to learn new material, loss of language function, and other manifestations.

For patients exhibiting early symptoms, quantifying disease progression over time can help direct therapy and disease management.

A radiological study via MRI exam is currently one of the most advanced methods to quantify the disease. In particular, the measurement of hippocampal volume has proven useful to diagnose and track progression in several brain disorders, most notably in AD. Studies have shown a reduced volume of the hippocampus in patients with AD.
<img src="https://user-images.githubusercontent.com/54595314/147877539-f607e912-7758-40b2-8a8a-9437a2413fa8.png" width="600px" height="auto">

In this project, I built an end-to-end AI system which features a machine learning algorithm that integrates into a clinical-grade viewer and automatically measures hippocampal volumes of new patients, as their studies are committed to the clinical imaging archive.

I used the dataset that contains the segmentations of the right hippocampus and I used the U-Net architecture to build the segmentation model.

After that, in the 3rd section of the project, I integrated the model into a working clinical PACS such that it runs on every incoming study and produces a report with volume measurements. I worked with three software products for emulating the clinical network. You would need to install and configure:

- **Orthanc server** for PACS emulation
- **OHIF zero-footprint web viewer** for viewing images
- **DCMTK tools** for testing and emulating a modality.

## Dataset

I used the "Hippocampus" dataset from the [Medical Decathlon competition](http://medicaldecathlon.com/).

This dataset is stored as a collection of NIFTI files, with one file per volume, and one file per corresponding segmentation mask. The original images here are T2 MRI scans of the full brain. As noted, in this dataset I used cropped volumes where only the region around the hippocampus has been cut out. This makes the size of our dataset quite a bit smaller, our machine learning problem a bit simpler and allows us to have reasonable training times. You should not think of it as "toy" problem, though. Algorithms that crop rectangular regions of interest are quite common in medical imaging. Segmentation is still hard.

## Libraries Used
```
import os
import glob
import shutil
import json
import pydicom
import sys
import datetime
import time
import subprocess
import numpy as np
import nibabel as nib
import matplotlib.pyplot as plt
from experiments.UNetExperiment import UNetExperiment
from data_prep.HippocampusDatasetLoader import LoadHippocampusData
from sklearn.model_selection import train_test_split
from mpl_toolkits.axes_grid1 import ImageGrid
from PIL import Image, ImageFont, ImageDraw
from inference.UNetInferenceAgent import UNetInferenceAgent
```

## Files in the Repository
**section1**: Inspect the dataset, understand the clinical side of the problem a bit better, and get it ready for consumption by algorithm in Section 2
- **images.tar.gz, labels.tar.gz**: Curated datasets with labels, as collection of NIFTI files
- **Final Project EDA.ipynb**: A Python Notebook with the results of Exploratory Data Analysis (EDA).

**section2**: Train the segmentation & classification model
- **run_ml_pipeline.py**: Train model with PyTorch
- **tensorboard loss.png**: Visualization of the loss with Tensorboard
- **results.json**: Results of model

**section3**: AI model integration into a clinical network and provide the auto-computed information on the hippocampal volume and validation plan

<img src="https://video.udacity-data.com/topher/2020/March/5e813bfd_network-setup/network-setup.png" width="500px" height="auto">

- **inference_dcm.py**: Contains code that will analyze the directory of the AI server that contains the routed studies, find the right series to run algorithm on, will generate report, and push it back to our PACS
- **/deploy_scripts/start_listener.sh**: Brings up a DCMTK's storescp and configures it to just copy everything it receives into a directory, organizing studies as one folder per study
- **/deploy_scripts/send_volume.sh**: Processes of the listener output and executing the model
- **/deploy_scripts/send_result.sh**: Sends the result
- **report_study1.dcm, report_study2.dcm, report_study3.dcm**: Sample reports
- **study*.PNG**: Screenshots of report shown in the OHIF viewer
- **Validation Plan - Hippocampal Volume.pdf**: FDA validation plan of algorithm

<img src="https://github.com/sahikabetul/Hippocampal-Volume-Quantification-in-Alzheimer-s-Progression/blob/main/section3/out/study1-chrisjen%20avasarala.PNG" width="800px" height="auto">
