%%
% ������д��ںͱ���
sca;
close all;
clearvars;

% �����������
rand('seed', sum(100 * clock));

% ��⵱ǰ���ڵ��Ե���Ļ������һ�����飬��������¼�˵�ǰ��Ļ�ı�ţ����ֻ��һ����Ļ������Ϊ0
screens = Screen('Screens');
screenNumber = max(screens);

% ��ð�ɫ�ͺ�ɫ����ɫֵ������Ĭ�����Ƿֱ�Ϊ0��255
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% �����ɫ����ɫֵ
grey = white / 2;

% ��һ�����ڣ�����������Ϊ��ɫ�����ش��ھ���ʹ��ڴ�С
[window, windowRect] = Screen('OpenWindow', screenNumber, black);

% ��ȡ���ڴ�С
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% ��ȡ������������
[xCenter, yCenter] = RectCenter(windowRect);

% ����alphaͨ���������
% �������Screen BlendFunction? ��鿴������OpenGL���ָ��
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

%% 
% ʹ�ú���meshgrid���ɵ�������ꡣmeshgrid��������һ���Ⱦ������������ĵ�Ϊ(0, 0)
% help meshgrid��ȡ����
% �ڻ�ͼ�Ĺ����У����Ǿ�����Ҫ����һ������ϵ���󣬾����ÿ��Ԫ�ض���(x,y)����ʾ�����磺
%   |
% ------------------------------------------> x
%   | (0, 0)  (1, 0)  (2, 0) ... (n_x, 0) 
%   | (0, 1)  (1, 1)  (2, 1) ... (n_x, 1) 
%   | ................................. 
% y | (0,n_y) (1,n_y) (2,n_y)... (n_x, n_y) 
%   V
% meshgrid��������������¼���ֻ�������صķֱ���X�����Y����ľ���
dim = 10;
[x, y] = meshgrid(-dim:1:dim, -dim:1:dim);

% ���������ǵ�������Ĵ�Сʹ�����ʺ���Ļ
% .*����Ϊ��ӦԪ�����
pixelScale = screenYpixels / (dim * 2 + 2);
x = x .* pixelScale;
y = y .* pixelScale;

% ������������
numDots = numel(x);

% Screen('DrawDots')����ʹ����һ�λ��ƶ����
% ����������λ�õ�2*numDots����ÿһ�ж�����һ��������꣬��һ�д��������꣬�ڶ��д���
% ������
dotPositionMatrix = [reshape(x, 1, numDots); reshape(y, 1, numDots)];

% ���������е㣬�����н���Ļ������Ϊ������е�
dotCenter = [xCenter yCenter];

% ����3*numDots����ɫ���󣬽������ɫ����Ϊ���
dotColors = rand(3, numDots) .* white;

% ����1*numDots�����������������Ĵ�С
dotSizes = rand(1, numDots) .* 20 + 10;

% һ�б����������������Ҫ�ĵ�
Screen('DrawDots', window, dotPositionMatrix,...
    dotSizes, dotColors, dotCenter, 2);
dotSizes = rand(1, numDots) .* 20 + 10;

% ��ת��Ļ��
Screen('Flip', window);

% �������������ִ�г���
KbStrokeWait;

% �ر����д���
sca;