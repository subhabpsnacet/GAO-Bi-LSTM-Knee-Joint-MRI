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
