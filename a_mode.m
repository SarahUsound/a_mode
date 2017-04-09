
data_directory = 'VGAtest/';
dat = dir(data_directory);
filename = dat(4).name;
x = strcat(data_directory, filename);
h5_path = '/Waveforms/Channel 2/Channel 2 Data';
data = h5read(x, h5_path);

env = abs(data);
env = abs(hilbert(env));
floor = mean(env)*(1 + 0.1);
bind = env > floor;

[V, istart, imax, iend] = splitPeaks(env, 0.02);

rem = find(imax == -2);
V(rem) = [];
imax(rem) = [];
istart(rem) = [];
iend(rem) = [];

subplot(4,1,1);
plot(data)

subplot(4,1,2);
plot(data)
hold on
plot(imax,V,'o');
% plot(istart,0,'o');
plot(iend,0,'*');

subplot(4,1,3);
plot(env);

subplot(4,1,4);
plot(bind);





