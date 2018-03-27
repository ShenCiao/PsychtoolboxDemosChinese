%%
% 阅读时请注意区分窗口Window和屏幕Screen
%%
% 清空现有屏幕和变量
sca;
close all;
clearvars;

% 在官方demo中，使用了默认配置 PsychDefaultSetup(2)，我们暂时不使用这种默认配置;
% PsychDefaultSetup(2)

% 大多数人都会在笔记本电脑上完成工作，大多数的笔记本电脑不会通过PTB的检测，因此要跳过这些检测
Screen('Preference', 'SkipSyncTests', 1);

% 检测当前连在电脑的屏幕，返回一个数组，这个数组记录了当前屏幕的编号，如果只有一个屏幕，则默认编号为0
screens = Screen('Screens');

% 选择屏幕
screenNumber = max(screens);

% 获得最亮和最暗的颜色值，可以默认它们分别为0与255
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% 计算灰色的颜色值
grey = white / 2;
%% 
% 打开一个窗口，将背景设置为灰色，rect指定了打开的窗口在屏幕中的位置，前两个值为左上角的X（水平）、Y（竖直）坐标，后两个值为右下角的坐标
% 在这个例子中，windowRect = [0,0,800,400]
rect = [200,200,1000,600];
[window, windowRect] = Screen('OpenWindow', screenNumber, grey, rect);

% 打开了窗口，我们可以查询它的属性：

% 这个函数返回的rect和windowRect的值相同
rect = Screen('Rect', window);

% 获取屏幕窗口的像素数目，这两个值是WindowRect与Rect的后两个值
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% 获取屏幕中心的坐标
% xCenter = screenXpixels / 2;
% yCenter = screenYpixels / 2;
[xCenter, yCenter] = RectCenter(windowRect);

% 获取屏幕内部刷新间隔（inter-frame-interval）它代表在屏幕绘制图像的最小间隔时间
ifi = Screen('GetFlipInterval', window);

% 也可以确定屏幕刷新率，与刷新间隔的关系为 ifi = 1 / hertz
hertz = FrameRate(window);

% pixel size并不是像素的物理大小而是颜色深度，这是计算机图形学的概念，我们一般不需要它
pixelSize = Screen('PixelSize', window);

% 获取屏幕物理大小，这个值由操作系统报告，如果操作系统没能获得屏幕的物理大小，这个函数则返回0
[width, height] = Screen('DisplaySize', screenNumber);

% 获取最大亮度值（应该为255）
% 在官方demo中使用了PsychDefaultSetup(2)，这里面调用了一个函数Screen('ColorRange', window, 1,
% [], 1)，使得最大亮度值变成了1，因此官方demo中表示应该为1
maxLum = Screen('ColorRange', window);