# FEARE: Fuzzy Entropy-Driven Adaptive Region Energy for Medical Image Segmentation

This repository contains the MATLAB implementation of **FEARE (Fuzzy Entropy-Driven Adaptive Region Energy)**, a novel model for robust medical image segmentation, particularly designed for left ventricle segmentation in cardiac MRI images.

## 📌 Overview

FEARE is an advanced active contour model that:
- Integrates **fuzzy logic** for uncertainty modeling.
- Uses **entropy-based energy** to adapt to local image variations.
- Employs **region fitting terms** for accurate boundary evolution.
- Incorporates **shape regularization** for anatomical consistency.

This model outperforms several state-of-the-art methods on benchmark cardiac MRI datasets.

## 🏗️ Repository Structure

FEARE/
├── Code/
│   ├── FEARE_Main.m
│   ├── HelperFunctions/
│   │   ├── computeEntropy.m
│   │   ├── fuzzyMembership.m
│   │   └── ...
│   ├── EvaluationMetrics/
│   │   ├── computeDSC.m
│   │   ├── computeAPD.m
│   │   └── ...
│
├── Dataset/
│   ├── SampleDICOMs/
│   ├── GroundTruth/
│   └── ...
│
├── Figures/
│   ├── Results/
│   └── AblationStudy/
│
└── Documentation/
    ├── FEARE_Methodology.pdf
    ├── HowToRun.txt
    └── Citation_Info.txt



## 🚀 How to Run the Code

1. Install **MATLAB** (2020b or later recommended).
2. Clone the repository:


3. Navigate to the `Code/` folder.
4. Run `FEARE_Main.m`.
5. Provide the path to the DICOM images and corresponding ground truth.
6. Evaluate results using metrics like **Dice Similarity Coefficient (DSC)**, **Average Perpendicular Distance (APD)**, etc.

## 📊 Results and Evaluation

The model has been tested on:
- **Sunnybrook Cardiac MRI Dataset**
- Evaluation metrics include DSC, IoU, APD, and more.

Figures and ablation studies are available in the `Figures/` folder.

## 📂 Dataset

Sample DICOM images and ground truth annotations are provided under the `Dataset/` folder.  
For full datasets, please refer to:
- [Sunnybrook Cardiac Data](https://www.cardiacatlas.org/sunnybrook-cardiac-data/)

## 📜 Citation

If you use this code in your research, please cite:
Sivakumar K, Bhoopathy Bagan K, et al. FEARE: Fuzzy Entropy-Driven Adaptive Region Energy for Medical Image Segmentation. (Submitted to The Visual Computer, 2025).

