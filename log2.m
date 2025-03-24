%LAPLACE
clc; clear; close all;
img = imread('testImage.png'); % Gantilah dengan nama file gambar
imshow(img), title('Gambar Asli');

gray_img = rgb2gray(img);   % Konversi ke grayscale jika gambar berwarna
imshow(gray_img), title('Gambar Grayscale');
h = fspecial('log', [5 5], 0.5); % Kernel LoG 5x5 dengan sigma 0.5

log_result = imfilter(double(gray_img), h, 'same', 'replicate');
imshow(log_result, []), title('Hasil Laplacian of Gaussian');
threshold = 10; % Ubah sesuai kebutuhan
edge_img = log_result >= threshold;
imshow(edge_img), title('Hasil Thresholding LoG 5x5');
