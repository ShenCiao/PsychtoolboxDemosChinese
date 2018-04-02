%%
% 该教程所有代码都可以直接运行
% 
% Screen并非单独的一个函数，初学者可以把它理解为一个函数家族，传入它的第一个参数决定了
% 它的功能，可以在命令行窗口直接输入Screen获取可用的函数
%%
% 清空现有屏幕和变量
sca;
close all;
clearvars;

% 在官方demo中，使用了默认配置 PsychDefaultSetup(2)，我们暂时不使用这种默认配置;
% PsychDefaultSetup(2)

% 大多数人都会在笔记本电脑上完成工作，大多数的笔记本电脑不会通过PTB的检测，因此要跳过这些检测
Screen('Preference', 'SkipSyncTests', 1);

% 由于一台主机上可以安装多个屏幕，所以要检测当前有哪些屏幕连在电脑上
% 函数返回一个数组，这个数组记录了当前屏幕的编号，如果你只有一个屏幕，则默认编号为0
% 比如我的笔记本连接了额外的一个显示屏，这个函数将返回数组[0,1]，第一个值指代我的笔记本上自带的屏幕，第二个值指代额外连接的屏幕。具有主机的电脑可以查看你的屏幕偏好设置查看哪个屏幕为主屏幕。
screens = Screen('Screens');

% 如果有多个屏幕的话，选择其中一个
% 如果我有两个屏幕，选择最大的将程序显示在外接屏幕上，选择最小的将程序显示在主屏幕上
screenNumber = max(screens);

% 获得白色和黑色的颜色值，可以默认它们分别为0与255
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% 计算灰色的颜色值
grey = white / 2;

% 官方demo中使用PsychImaging打开窗口，PsychImaging在PTB中是更底层的代码，使用Screen即可
% 打开一个窗口，将背景设置为灰色，返回的第一个值为窗口的句柄（实际上它是一个double，可以说是窗口的编号），第二个值为1*4的向量，前两个值为屏幕左上角的X（水平）、Y（竖直）坐标，为0,0，后两个值为屏幕右下角的坐标值，为窗口的大小。
% 所谓"句柄"，是"把手"（门把手）文邹邹的叫法，门提供了一个把手让人能够方便的开关它，类似的
% 'OpenWindow'提供了一个窗口句柄让使用者可以操作这个窗口，在下面的函数中，我们都要传入这个句柄来指定窗口。
[window, windowRect] = Screen('OpenWindow', screenNumber, grey);

% 与KbStrokeWait类似的还有KbWait，KbWait立即检测当前是否有按键被按下，如果有，
% 则继续执行程序；KbStrokeWait则会等待当前所有的按键全部释放，再检测是否有新的按键被按下，如果有，则继续执行程序。
% 按下任意键继续执行程序
KbStrokeWait;

% 关闭所有窗口
sca;