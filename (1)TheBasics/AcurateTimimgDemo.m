%%
% 初学者可以把窗口理解为一个"双面画板"，程序在背面绘图，屏幕显示正面的图像，
% 背面的图像暂时不会被现实在屏幕上。一旦程序在背面完成绘制并调用Screen('Flip')，
% 那么这个双面画板就会被翻转过来，原来背面的图像显示在屏幕上，原来正面的图像被擦除，等待
% 接下里的绘图命令。
% 
% Screen('Flip')与屏幕的竖直刷新同步，也就是说程序运行到了Screen('Flip')的时刻，如果屏幕的本次刷新没有结束
% Flip会暂停程序，等待下次刷新屏幕开始，再绘制缓存中的图像。
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

% -----
% 例子1
% -----

% 首先我们将展示一种较差的精确控制刺激呈现时间的方式，这种方式可以在有硬件缺陷的电脑上使用，
% 但这种方式给刺激的呈现造成了太多的随机性，这种方式不推荐使用

for frame = 1:numFrames

    % 使用灰色的全屏矩形填充窗口（没有指定rect，默认为全屏）
    Screen('FillRect', window, [0.5 0.5 0.5]*white);

    % 翻转窗口
    Screen('Flip', window);

end

% -----
% 例子2
% -----

% 现在我们指定一个时间戳，利用这个时间戳指定PTB在屏幕上绘制图像的时间点，在例子中使用了
% 一半的屏幕刷新间隔。这种方式可以让我们精准的得知PTB是否绘制了刺激。
% vbl为时间戳，在PTB中用于精准控制刺激呈现的时间，它以秒为单位记录了本次Flip窗口开始的时间，
% 在MATLAB里它是一个双精度浮点数（double）
% 

vbl = Screen('Flip', window);
for frame = 1:numFrames

    % 把屏幕填充为红色
    Screen('FillRect', window, [0.5 0 0]*white);

    % Screen('Flip')的第三个参数可以传入一个时间戳，指定开始刷新的时间点，到了这个时间点
    % PTB会先等待下次屏幕刷新开始，再与屏幕刷新同步地绘制缓存中的图像，因此尽管例子中
    % 减去了0.5，我们实际上还是在以一帧一绘制的速度在绘制图像
    % 需要注意，返回的时间戳代表的时间点，是开始绘图的时候，也就是下次屏幕刷新的时间点。
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

end

% -----
% 例子3
% -----

% 这个例子中和例子2完全相同，但是将PTB的优先级设置为最高，这说明PTB相比于其它程序会占用最高的系统资源，
% 在现代的计算机中，PTB几乎不可能超载系统资源，所以建议你在打开窗口后便设置最高优先级

Priority(topPriorityLevel);
vbl = Screen('Flip', window);
for frame = 1:numFrames

    % Color the screen purple
    Screen('FillRect', window, [0.5 0 0.5]*255);

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

end
Priority(0);

% -----
% 例子4
% -----

% 最后和例子3相同，但是我们在绘图指令和filp之间添加一行代码，告知PTB这期间不再有绘图命令
% 如果你需要在这期间让MATLAB做一些其它的计算操作（例如计算刺激下一帧的位置），这样做可以节省
% 电脑资源。如果你不需要额外的计算，使用例子3即可。

Priority(topPriorityLevel);
vbl = Screen('Flip', window);
for frame = 1:numFrames

    % Color the screen blue
    Screen('FillRect', window, [0 0 0.5]*white);

    % 告诉MATLAB filp前不再有绘制命令
    Screen('DrawingFinished', window);

    % 额外的计算(如果有的话)

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

end
Priority(0);

% 关闭所有窗口
sca;