%%
% 清空现有窗口和变量
sca;
close all;
clearvars;

% 跳过同步性检测
Screen('Preference', 'SkipSyncTests', 1);

% 检测当前连在电脑的屏幕，返回一个数组，这个数组记录了当前屏幕的编号，如果只有一个屏幕，则默认编号为0
screens = Screen('Screens');

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

% 获取窗口大小
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

%%
% 设置默认的字体和文字大小
Screen('TextFont', window, 'Arial');    % 官方Demos出错的'Arial'拼成了'Ariel'
Screen('TextSize', window, 50); 

% 获取窗口中心坐标
[xCenter, yCenter] = RectCenter(windowRect);

% 随机设置鼠标的初始位置
SetMouse(round(rand * screenXpixels), round(rand * screenYpixels), window);

% 鼠标设置在窗口的左上角
SetMouse(0, 0, window);

% 循环直到某个按键被按下
while ~KbCheck
    % 获取鼠标的当前坐标与按下的按键
    % button为三维向量
    [x, y, buttons] = GetMouse(window);
    
    % 这一步是为了防止运行程序电脑有多块显示屏，把x，y禁锢在窗口内
    x = min(x, screenXpixels);
    y = min(y, screenYpixels);
    
    % 构建屏幕中显示的文字，显示当前鼠标的坐标
    textString = ['Mouse at X pixel ' num2str(round(x))...
        ' and Y pixel ' num2str(round(y))];
    
    % 将文字绘制在屏幕上（避免使用Screen('DrawText')，这个函数偏底层）
    DrawFormattedText(window, textString, 'center', 'center', white);
    
    % 在你的鼠标位置绘制一个白色圆点
    % 倒数第二个参数为[x,y]原点坐标，如果没有使用默认值，这个点将绘制在以倒数第二个参数
    % 所指定的位置为坐标系的[x,y]位置，没有传入参数则使用默认的窗口坐标系的[x,y]作为
    % 绘图位置。
    % 倒数第一个参数指定绘制圆的类型，可以是0～4的任意值，2使得这个圆抗锯齿，看起来更圆润。
    Screen('DrawDots', window, [x y], 10, white, [], 2);
    
    % Flip to the screen
    Screen('Flip', window);
end

% 关闭所有窗口
sca;