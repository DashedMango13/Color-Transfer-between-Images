close all;
clear;

src = imread("harbor.tif"); %Input Image
tgt = imread("palm.tif");       %Desired Color

% if size(tgt(:,:)
% tgtBW2C(:,:, 1) = tgt;
% tgtBW2C(:,:, 2) = tgt;
% tgtBW2C(:,:, 3) = tgt;
% 
% tgt = tgtBW2C;


mitu = [0.4306, 0.3415, 0.1784;
        0.2220, 0.7067, 0.0713;
        0.0202, 0.1295, 0.9394];
mituNorm = [0.5141, 0.3239, 0.1604;
            0.2651, 0.6702, 0.0641;
            0.0241, 0.1228, 0.8444];
xyz2lms = [0.3897 0.6890 -0.0787;
           -0.2298 1.1834 0.0464;
           0.0000 0.0000 1.0000];
pca = diag([1/sqrt(3), 1/sqrt(6), 1/sqrt(2)]) * [1, 1, 1; 1, 1, -2; 1, -1, 0];
pcaInv = [1, 1, 1; 1, 1, -1; 1, -2, 0] * diag([sqrt(3)/3, sqrt(6)/6, sqrt(2)/2]);

lms2rgb = [4.4679 -3.5873 0.1193
          -1.2186 2.3809 -0.1624
           0.0497 -0.2439 1.2045];

xyzSrc = double(src);
lmsSrc = double(src);
logSrc = double(src);
labSrc = double(src);

xyztgt = double(tgt);
lmstgt = double(tgt);
logtgt = double(tgt);
labtgt = double(tgt);

for c = 1:size(src, 2)
    for r = 1:size(src, 1)
        pixel = reshape(src(r, c, :), [3, 1]);
        xyzSrc(r, c, :) = mituNorm * double(pixel);
        pixel = reshape(xyzSrc(r, c, :), [3, 1]);
        lmsSrc(r, c, :) = xyz2lms * double(pixel);
        pixel = reshape(lmsSrc(r, c, :), [3, 1]);
        for i = 1:3
            if pixel(i) ~= 0
                pixel(i) = log10(double(pixel(i)));
            end
        end
        logSrc(r, c, :) = double(pixel);
        pixel = reshape(logSrc(r, c, :), [3, 1]);
        labSrc(r, c, :) = pca * double(pixel);
    end
end

for c = 1:size(tgt, 2)
    for r = 1:size(tgt, 1)
        pixel = reshape(tgt(r, c, :), [3, 1]);
        xyztgt(r, c, :) = mituNorm * double(pixel);
        pixel = reshape(xyztgt(r, c, :), [3, 1]);
        lmstgt(r, c, :) = xyz2lms * double(pixel);
        pixel = reshape(lmstgt(r, c, :), [3, 1]);
        for i = 1:3
            if pixel(i) ~= 0
                pixel(i) = log10(double(pixel(i)));
            end
        end
        logtgt(r, c, :) = double(pixel);
        pixel = reshape(logtgt(r, c, :), [3, 1]);
        labtgt(r, c, :) = pca * double(pixel);
    end
end

srcStdl = std(labSrc(:,:,1), 0, "all");
srcStda = std(labSrc(:,:,2), 0, "all");
srcStdb = std(labSrc(:,:,3), 0, "all");

labSrc(:,:,1) = labSrc(:,:,1) - mean(labSrc(:,:,1), "all");
labSrc(:,:,2) = labSrc(:,:,2) - mean(labSrc(:,:,2), "all");
labSrc(:,:,3) = labSrc(:,:,3) - mean(labSrc(:,:,3), "all");


tgtStdl = std(labtgt(:,:,1), 0, "all");
tgtStda = std(labtgt(:,:,2), 0, "all");
tgtStdb = std(labtgt(:,:,3), 0, "all");

labSrc(:,:,1) = labSrc(:,:,1) * (tgtStdl/srcStdl) + mean(labtgt(:,:,1), "all");
labSrc(:,:,2) = labSrc(:,:,2) * (tgtStda/srcStda) + mean(labtgt(:,:,2), "all");
labSrc(:,:,3) = labSrc(:,:,3) * (tgtStdb/srcStdb) + mean(labtgt(:,:,3), "all");

dst = src;
for c = 1:size(src, 2)
    for r = 1:size(src, 1)
        pixel = reshape(labSrc(r, c, :), [3, 1]);
        logSrc(r, c, :) = pcaInv * double(pixel);
        lmsSrc(r,c,:) = 10.^logSrc(r,c,:);
        pixel = reshape(lmsSrc(r, c, :), [3, 1]);
        dst(r, c, :) = lms2rgb * double(pixel);
    end
end

fig1 = figure;
imshow(src);
title("Original");

fig2 = figure;
imshow(dst);
title("Output");
imwrite(dst, "out.tif");

fig3 = figure;
imshow(tgt);
title("Target");

