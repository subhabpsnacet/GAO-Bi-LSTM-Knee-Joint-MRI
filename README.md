**1.** **Project Overview**

    This repository contains the implementation of **Gaussian Aquila Optimizer-Enhanced Bidirectional LSTM (GAO-Bi-LSTM)** for accurate osteoarthritis (OA) grading in knee MRI images. The proposed model enhances     deep learning-based knee joint analysis by combining:

    Gaussian Aquila Optimizer (GAO) for efficient weight optimization and improved convergence.
    Bidirectional Long Short-Term Memory (Bi-LSTM) for temporal-spatial analysis of MRI sequences.
    
Using a dataset of **16,526 knee MRI images** (sourced from Zenodo and clinical scans), the GAO-Bi-LSTM model achieves:

  Segmentation Accuracy: 98.11%
  Classification Accuracy: 99.69%
  Sensitivity: 99.47%
  Specificity: 99.35%
The dataset and source code are publicly available for replication and validation.

**2**.**Installation Instructions**

   **Step 1: Clone the Repository**
  
      git clone https://github.com/subhabpsnacet/GAO-Bi-LSTM-Knee-Joint-MRI.git
      cd GAO-Bi-LSTM-Knee-Joint-MRI
  
  **Step 2: Set Up a Virtual Environment (Recommended)**
  
      python -m venv gao_env
      source gao_env/bin/activate  # On Windows: gao_env\Scripts\activate
  
  **Step 3: Install Dependencies**
  
      pip install -r requirements.txt
      Dependencies include:
      TensorFlow/Keras
      NumPy, Pandas, Matplotlib
      OpenCV (for image preprocessing)
      Scikit-learn (for evaluation metrics)

**3**.**Usage Guide****

  **Running the Preprocessing Pipeline**
  
    python preprocess.py --input data/knee_mri --output processed_data
    
    This applies adaptive local histogram equalization and segmentation.
    
***Training the GAO-Bi-LSTM Model**

      python train.py --epochs 30 --batch_size 24
      
  
      This trains the GAO-Bi-LSTM model using the optimized dataset.
  
**Testing and Evaluating the Model**

      python test.py --model checkpoint/GAO_Bi_LSTM.h5 --data processed_data/test
      
  
      This generates accuracy, sensitivity, and specificity reports.

**4.**Dataset Information****

    *****Source:Zenodo ACL-Knee Joint MRI Dataset
    **Additional Dataset:** Available at GitHub**

    **Description:**

        16,526 MRI images
        Training Set: 13,220 images (Grades I-IV)
        Testing Set: 3,306 images
        Preprocessed using adaptive histogram equalization and connected component labeling segmentation.
        If the dataset is too large to upload directly, provide Python scripts in data/ to download and preprocess it.

**5. Results and Performance**
   
![image](https://github.com/user-attachments/assets/1d1194d1-d068-45a9-9fce-a6e3cfff1381)

Visual Results
Segmentation Example:

Before: Raw Knee MRI Image
After: Processed Image with ACL Region Highlighted
Classification Output:

Predicted Grades: I, II, III, IV
Example Confusion Matrix & ROC Curve
6. Citation
If you use this repository, please cite:

bibtex
Copy
Edit
@article{Subha2024,
  title={Gaussian Aquila Optimizer-Enhanced Bi-LSTM for Osteoarthritis Grading in Knee MRI},
  author={Subha B and Vijay Jeyakumar},
  journal={The Visual Computer},
  year={2024}
}
7. Future Enhancements
Expanding dataset diversity for clinical validation.
Extending the GAO-Bi-LSTM model to multi-modal imaging (Ultrasound, X-ray).
Enhancing interpretability via attention-based deep learning mechanisms.
Action Items for Your GitHub Repo
Upload all .py source files separately (avoid ZIP).
Add a structured README.md using the above format.
Ensure requirements.txt includes all dependencies.
Provide sample dataset access (data/ folder or download script).
Improve code documentation (function comments, explanations).

# GAO-Bi-LSTM-Knee-Joint-MRI
This study introduces a Gaussian Aquila Optimizer (GAO)-enhanced Bidirectional Long Short-Term Memory (Bi-LSTM) network to identify and categorize OA in anterior cruciate ligament (ACL) images from knee MRI.  

Downlaod datasets using the below link and put them into the "data folder":

https://drive.google.com/drive/folders/1PHosWF-ale2zztag9mlxm2Y1Wryk3pHQ?usp=drive_link
Here, I have provided detailed usage guidelines to ensure that interested readers can replicate the experimental results and evaluate the metrics smoothly:

Dataset Guidelines

•	Dataset Access:
Datas are collected from  Zenodo dataset for ACL-Knee joint MRI dataset (DOI: https://zenodo.org/records/7977297). The source code and additional dataset used in this study are publicly available on GitHub: https://github.com/subhabpsnacet/GAO-Bi-LSTM-Knee-Joint-MRI. It consists of 16,526 MRI images organized into two folders: 'Training' (13,220 images) and 'Testing' (3,306 images)."

•	Data Structure:
"Each image is labeled with its corresponding OA grade (e.g., Grade 0, 1, 2, 3, or 4). Images are stored in .jpg format with the associated labels provided in a labels.csv file."

Preprocessing Guidelines
•	Preprocessing Steps:
"Before feeding the images into the model, they were resized to 256x256 pixels, normalized to have values between 0 and 1, and augmented with rotations and flips to improve generalization."

Model Training Guidelines
•	Model Training Settings:
"The GAO-Bi-LSTM was trained with the following parameters:
o	Learning Rate: 0.001
o	Batch Size: 32
o	Epochs: 50
o	Optimizer: Gaussian Aquila Optimizer (GAO)

A 70:30 train-test split was used, and validation accuracy was monitored for early stopping."

Metrics Calculation Guidelines
•	Evaluation Metrics:
"The following metrics were calculated:
o	Sensitivity and Specificity: True positive and true negative rates using a 0.5 threshold.
o	Accuracy: Ratio of correctly predicted samples to total samples.
o	Segmentation Dice Coefficient: Overlap measure between predicted and ground truth segmentations.
