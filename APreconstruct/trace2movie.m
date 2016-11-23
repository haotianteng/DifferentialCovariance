function [Movie,Map] = trace2movie(traces)

ColumnNum = 10;
ImageWidth = 500;
blockWidth = ImageWidth/ColumnNum;
NeuronNum = size(traces,1);
Time = size(traces,2);
RawNum = ceil(NeuronNum/ColumnNum);
ImageHeight = RawNum * (ImageWidth/ColumnNum);
traces = (traces-min(min(traces)))/(max(max(traces))-min(min(traces)))*256;
Movie = zeros(ImageHeight,ImageWidth,1,Time,'uint8');
Map = gray(256);

for timeIndex = 1:Time
    for NeuronIndex = 1:NeuronNum
        rawIndex = ceil(NeuronIndex/ColumnNum);
        columnIndex = NeuronIndex - (rawIndex-1)*ColumnNum;
        Movie((rawIndex-1)*blockWidth+1:rawIndex*blockWidth,(columnIndex-1)*blockWidth+1:columnIndex*blockWidth,1,timeIndex) = uint8(traces(NeuronIndex,timeIndex));

    end
end


end