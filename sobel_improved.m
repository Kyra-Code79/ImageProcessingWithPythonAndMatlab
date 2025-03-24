clc;
clear;
close all;

% Path ke gambar
base_dir = fileparts(mfilename('fullpath')); % Direktori skrip saat ini
image_path = fullfile(base_dir, 'cewe.png'); % Path ke gambar

% Baca gambar
img = imread(image_path);

% Tampilkan gambar asli
figure;
subplot(2,3,1);
imshow(img);
title('Gambar Asli');

% Ubah ke grayscale jika gambar berwarna
if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

% 2. Tampilkan sebagian kecil nilai RGB (hanya untuk referensi)
disp('Nilai RGB (10x10 pertama):');
disp(img(1:10, 1:10, :));

% 4. Resize gambar ke ukuran yang lebih kecil jika terlalu besar
max_size = 512;
[height, width] = size(img_gray);
if max(height, width) > max_size
    scale = max_size / max(height, width);
    img_resized = imresize(img_gray, scale);
else
    img_resized = img_gray;
end

% 5. Tampilkan nilai grayscale dari sebagian kecil area
disp('Nilai Grayscale (10x10 pertama):');
disp(img_resized(1:10, 1:10));

% 6. Terapkan filter Sobel
sobel_x = imfilter(double(img_resized), fspecial('sobel')', 'replicate');
sobel_y = imfilter(double(img_resized), fspecial('sobel'), 'replicate');

% 7. Hitung magnitudo gradien
grad_magnitude = sqrt(sobel_x.^2 + sobel_y.^2);

% 8. Tampilkan nilai M (10x10 pertama)
disp('Nilai M (Magnitudo Gradien - 10x10 pertama):');
disp(grad_magnitude(1:10, 1:10));

% 9. Thresholding
threshold = mean(grad_magnitude(:));
thresholded_image = grad_magnitude >= threshold;

% 10. Tampilkan hasil
subplot(2,3,2);
imshow(img_resized);
title('Gambar Grayscale (Resized)');

subplot(2,3,3);
imshow(sobel_x, []);
title('Sobel Horizontal');

subplot(2,3,4);
imshow(sobel_y, []);
title('Sobel Vertikal');

subplot(2,3,5);
imshow(grad_magnitude, []);
title('Magnitudo Gradien');

subplot(2,3,6);
imshow(thresholded_image);
title('Thresholding (1/0)');

