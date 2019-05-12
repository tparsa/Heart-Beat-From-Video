% Part one:
rate = zeros(1, 212);
vid = VideoReader('A.mp4');
idx = 1;
while hasFrame(vid)
    vidFrame = readFrame(vid);
    redMean = sum(vidFrame(:,:,1));
    redMean = sum(redMean);
    redMean = redMean / (1280.0 * 720);
    rate(idx) = redMean;
    idx = idx + 1;
end
figure;
plot(rate);
title('Plot of average red in each frame');
xlabel('Frame index');
ylabel('Average red for all pixels in a frame');

%Part two and three:
Fs = vid.FrameRate;
f = Fs / (idx - 1) * (0 : (idx - 1) / 2);
fidx = find(f >= (50.0 / 60) & f <= (220.0 / 60));
Y = fft(rate);
Y2 = abs(Y(fidx));
f2 = f(fidx) * 60;

figure;
plot(f2, Y2);
[val, ind] = max(Y2);
str = {'\leftarrow Your BMP is: ', num2str(int8(f2(ind)))};
str = strjoin(str, ' ');
text(f2(ind), val, str);
title('Beat Per Minute Plot');
xlabel('BPM');
ylabel('Magnitude');

%part four
f = Fs / (idx - 1) * (0 : (idx - 1) / 2);
fNeg = Fs / (idx - 1) * (-(idx - 1) / 2 + 1: -1);
f = [f fNeg];
Yidx = find(abs(f) < 50.0 / 60 | abs(f) > 220.0 / 60);
Y(Yidx) = 0;
Y = ifft(Y);
figure;
plot(Y);
title('Noise free PPG');
xlabel('Frame index');
ylabel('Average red for all pixels in a frame without noise');

%bonus part