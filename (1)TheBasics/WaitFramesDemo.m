%%
% KbCheck这个函数用于检测"当前时刻"是否有按键按下，也就是说，在该例子的循环里面，每一秒
% 才会检测一次是否有按键按下，如果你在前一次与后一次检测的中间按下了某个按键，程序也就
% 就会认为你并没有按键，也就不会退出（可以一直按住某个按键退出程序）。
%%
% 清空现有窗口和变量
sca;
close all;
clearvars;

% 跳过同步性检测
Screen('Preference', 'SkipSyncTests', 1);

% 检测当前连在电脑的屏幕，返回一个数组，这个数组记录了当前屏幕的编号，如果只有一个屏幕，则编号为0
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

% 获取并设置最高优先级
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

%% 
% 我们设置waitframes等待帧使得窗口的刷新率不等于显示器（屏幕）的刷新率，在这个例子中
% 以每秒一次的频率刷新窗口
flipSecs = 1;
waitframes = round(flipSecs / ifi);

% 翻转窗口获得初始时间戳
vbl = Screen('Flip', window);

% 变换窗口颜色直到摁下任意按键
% KbCheck用于检测当前时刻是否有按键被按下，如果有则返回1，没有则返回0
while ~KbCheck

    % Color the screen a random color
    Screen('FillRect', window, rand(1, 3)*white                  );

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

end

% 关闭所有窗口
sca;