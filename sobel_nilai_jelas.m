clc; clear; close all;

% 1. Baca gambar
img = imread('testImage.png'); % Gantilah dengan nama file gambar
imshow(img), title('Gambar Asli');

% 2. Tampilkan nilai RGB asli (untuk pixel pertama 5x5 saja sebagai contoh)
rgb_values = img(1:3, 1:3, :); % Ambil sebagian kecil untuk ditampilkan
disp('Nilai RGB (3x3 pertama):');
disp(rgb_values);

% 3. Ubah ke grayscale
img_gray = rgb2gray(img);

% 4. Resize gambar menjadi 32x32
img_resized = imresize(img_gray, [32 32]);

% 5. Tampilkan nilai grayscale dari 5x5 pertama
disp('Nilai Grayscale (3x3 pertama):');
disp(img_resized(1:3, 1:3));

% 6. Terapkan filter Sobel
sobel_x = fspecial('sobel'); % Kernel Sobel untuk arah horizontal
sobel_y = sobel_x';          % Kernel Sobel untuk arah vertikal

% 7. Konvolusi gambar dengan filter Sobel
grad_x = imfilter(double(img_resized), sobel_x);
grad_y = imfilter(double(img_resized), sobel_y);

% 8. Hitung magnitudo gradien
grad_magnitude = sqrt(grad_x.^2 + grad_y.^2);

% 9. Tampilkan nilai M (Magnitudo) dari 5x5 pertama
disp('Nilai M (Magnitudo Gradien - 3x3 pertama):');
disp(grad_magnitude(1:5, 1:5));

% 10. Thresholding: Jika M >= 0 maka nilai = 1, jika tidak = 0
thresholded_image = grad_magnitude >= 1; % Semua nilai M selalu >= 0

% 11. Tampilkan nilai thresholding (5x5 pertama)
disp('Hasil Thresholding (1/0 - 3x3 pertama):');
disp(thresholded_image(1:3, 1:3));

% 12. Tampilkan hasil
figure;
subplot(2, 3, 1), imshow(img), title('Gambar Asli');
subplot(2, 3, 2), imshow(img_resized), title('Gambar 32x32 (Grayscale)');
subplot(2, 3, 3), imshow(grad_x, []), title('Sobel Horizontal');
subplot(2, 3, 4), imshow(grad_y, []), title('Sobel Vertikal');
subplot(2, 3, 5), imshow(grad_magnitude, []), title('Magnitudo Gradien');
subplot(2, 3, 6), imshow(thresholded_image), title('Thresholding (1/0)');
