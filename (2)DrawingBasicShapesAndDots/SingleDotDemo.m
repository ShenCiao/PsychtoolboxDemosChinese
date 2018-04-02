%%
% 清空现有窗口和变量
sca;
close all;
clearvars;

% 设置随机种子
rand('seed', sum(100 * clock));

% 检测当前连在电脑的屏幕，返回一个数组，这个数组记录了当前屏幕的编号，如果只有一个屏幕，则编号为0
screens = Screen('Screens');
screenNumber = max(screens);

% 获得白色和黑色的颜色值，可以默认它们分别为0与255
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% 计算灰色的颜色值
grey = white / 2;

% 打开一个窗口，将背景设置为黑色，返回窗口句柄和窗口大小
[window, windowRect] = Screen('OpenWindow', screenNumber, black);

% 获取窗口大小
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% 获取窗口中心坐标
[xCenter, yCenter] = RectCenter(windowRect);

%%
% 开启alpha通道来抗锯齿（原文就是这么说的...）
% 详情请见Screen BlendFunction? 或查看第六章OpenGL编程指导
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

% 将点的颜色设置为红色。计算机的颜色都是由三原色混合而成。因此我们使用三个元素的数组分别表示
% 红绿蓝三种颜色。在使用浮点数来表示颜色时，颜色值为0～1之间的任意值，在使用8位整数表示颜色
% 时，使用八位的二进制数字表示颜色，把它转化为十进制正整数便有2^8 = 256正整数，因此使用八位
% 整数时要求颜色值是位于0～255之间的整数值。PTB中默认使用0～255的颜色值。
dotColor = [1 0 0] * white;

% 随机生成点的坐标值（如果一不小心点被绘制在了屏幕的边缘，它会缺失一部分）
dotXpos = rand * screenXpixels;
dotYpos = rand * screenYpixels;

% 点的大小
dotSizePix = 20;

% 在屏幕中绘制点，关于参数的信息请查询Screen DrawDots?
% 这里最后一个参数用于平滑绘制点的边缘
Screen('DrawDots', window, [dotXpos dotYpos], dotSizePix, dotColor, [], 2);

% 翻转屏幕。
Screen('Flip', window);

% 按下任意键继续执行程序
KbStrokeWait;

% 关闭所有窗口
sca;