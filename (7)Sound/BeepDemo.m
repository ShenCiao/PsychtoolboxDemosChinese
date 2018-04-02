?% 清理工作区
clearvars;
close all;
sca;

% 初始化声音驱动程序
InitializePsychSound(1);

% 声音通道和采样率
% 在官方Demo把声音频率(Frequency of the sound)和采样率(sample rate)搞混了，我们
% 这里将其纠正。
nrchannels = 2;
sampleRate = 48000;    % 官方Demo把这个变量命名为freq是不对的
freq = 500;

% 我们希望播放几次声音
repetitions = 1;

% 声音持续时长
beepLengthSecs = 1;

% 播放声音之间的间隔
beepPauseTime = 1;

% 立即开始播放声音与否（0 = 立即开始）
startCue = 0;

% 是否等待设备真正开始（1 = 是）
% 详情查看 help PsychPortAudio
waitForDeviceStart = 1;

% 打开 Psych-Audio 端口，使用以下参数
% (1) [] = 使用默认设备播放声音
% (2) 1 = 仅播放声音. 还可以被设置为2 = 记录声音，3 = 播放并记录声音（不稳定会导致MATLAB崩溃）
% (3) 1 = 尽可能的减少声音播放延迟，还可以被设置为0 = 忽略声音延迟，2 = 完全接管声音装置，
%       尽可能获得最小延迟，即使因此干扰了其它声音的播放也在所不惜，以及还有3、4等
% (4) 设置播放时每秒播放采样点的数量，也就是播放器"认定的"声音的采样率
% (5) 2 = 双通道立体声
pahandle = PsychPortAudio('Open', [], 1, 1, sampleRate, nrchannels);

% 设置音量
PsychPortAudio('Volume', pahandle, 0.5);

% 制造声音数据
myBeep = MakeBeep(500, beepLengthSecs, sampleRate);

% 将声音数据输入缓冲器，因为是双声道，要接受2行数据
PsychPortAudio('FillBuffer', pahandle, [myBeep; myBeep]);

% 开始播放声音
PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);

% 等待声音结束。这里我们使用一种更精确的调控时间的方法，详情请见：
% https://groups.yahoo.com/neo/groups/psychtoolbox/conversations/messages/20863
[actualStartTime, ~, ~, estStopTime] = PsychPortAudio('Stop', pahandle, 1, 1);

% 计算另外一次声音播放的时间
startCue = estStopTime + beepPauseTime;

% 播放声音
PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);

PsychPortAudio('Stop', pahandle, 1, 1);

% 关闭声音设备
PsychPortAudio('Close', pahandle);