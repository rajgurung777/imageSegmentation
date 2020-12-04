# imageSegmentation

#Image Segmentation using Multi-Threshold technique
by Histogram Sampling

##Abstract

The segmentation of digital images is one of the essential steps in image processing or a computer vision system. It helps in separating the pixels into different regions according to their intensity level. A large number of segmentation techniques have been proposed, and a few of them use complex computational operations. Among all, the most straightforward procedure that can be easily implemented is thresholding. In this paper, we present a unique heuristic approach for image segmentation that automatically determines multilevel thresholds by sampling the histogram of a digital image. Our approach emphasis on selecting a valley as optimal threshold values. We demonstrated that our approach outperforms the popular Otsu's method in terms of CPU computational time.  We demonstrated that our approach outperforms the popular Otsu's method in terms of CPU computational time. We observed a maximum speed-up of $35.58\times$ and a minimum speed-up of **10.21x** on popular image processing benchmarks. To demonstrate the correctness of our approach in determining threshold values, we compute PSNR, SSIM, and FSIM values to compare with the values obtained by Otsu's method. This evaluation shows that our approach is comparable and better in many cases as compared to well known Otsu's method.
