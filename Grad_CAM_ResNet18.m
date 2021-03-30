function Grad_CAM_ResNet18(net, img, size, path_img)
%%
inputSize = [size size];
[classfn,score] = classify(net,img);
lgraph = layerGraph(net);
lgraph = removeLayers(lgraph, lgraph.Layers(end).Name);
dlnet = dlnetwork(lgraph);
softmaxName = 'prob';
convLayerName = 'res5b';
dlImg = dlarray(single(img),'SSC');
[convMap, dScoresdMap] = dlfeval(@gradcam, dlnet, dlImg, softmaxName, convLayerName, classfn);
gradcamMap = relu(sum(convMap .* sum(dScoresdMap, [1 2]), 3));
gradcamMap = extractdata(gradcamMap);
gradcamMap = rescale(gradcamMap);
gradcamMap = imresize(gradcamMap, inputSize, 'Method', 'bicubic');
imshow(img);
hold on;
img_gradCAM = imagesc(gradcamMap, 'AlphaData', 0.5); %0-1
colormap jet
hold off;
img_gradCAM = getframe(gca);
img_gradCAM = imresize(img_gradCAM.cdata, inputSize, 'Method', 'nearest');
imwrite(img_gradCAM, path_img); %save as jpg
% save(path_data, 'gradcamMap');
end

