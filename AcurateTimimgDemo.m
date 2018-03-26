%%
% 

%%
% 清空现有窗口和变量
sca;
close all;
clearvars;

% 使用默认配置 2，这种配置下PTB要求的颜色值变为0～1的浮点数
PsychDefaultSetup(2)

% 跳过同步性检测
Screen('Preference', 'SkipSyncTest', 1);

% 选择屏幕
screenNumber = max(screens);

% 获得白色和黑色的颜色值，可以默认它们分别为0与255
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% 计算灰色的颜色值
grey = white / 2;

% 打开一个窗口，将背景设置为灰色，返回窗口句柄和窗口大小
[window, windowRect] = Screen('OpenWindow', screenNumber, grey);

% 计算刷新间隔
ifi = Screen('GetFlipInterval', window);

%%
% 获取代表最高权限的数值，这个数值在后面的代码中被用来调用最高级别的计算能力，
topPriorityLevel = MaxPriority(window);

% 绘制图像的持续时间与图像显示的持续帧数
numSecs = 1;
numFrames = round(numSecs / ifi);

% 绘制下一张图像需要等待的帧数，在这个例子中，每一帧都要绘制一张图像
% Note：设置这个值令代码可修改，比如令waitframes = 2;例子中的图像就会间隔一帧再刷新，查看PTB的文档以获得详细的帮助信息
waitframes = 1;

%--------------------------------------------------------------------------
% 接下来的代码会每一帧中绘制呈现的刺激。在实际的实验中完全没有必要使用这种方式来呈现一个静止的刺激物，但是为了简洁的呈现代码，并保持与未来Demo的一致性（原文就是这个意思），我们还是采用了这种方式呈现了一个静止的刺激物。
% 
% 特别的：
% 
% 当 waitframes = 1时，vbl + (waitframes - 0.5) * ifi 与 vbl + 0.5 * ifi完全相同。
% 
%--------------------------------------------------------------------------

% ???-
% 例子1
% ???-

% 首先我们将展示一种较差的控制刺激呈现时间的方式，这种呈现刺激的方式将导致刺激出现时间不准确，有些实验需要精确控制时间到毫秒级别，这种方式不推荐使用
for frame = 1:numFrames

    % 使用灰色填充窗口
    Screen('FillRect', window, [0.5 0.5 0.5]);

    % 翻转窗口
    Screen('Flip', window);

end


