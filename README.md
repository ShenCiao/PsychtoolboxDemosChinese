

# PsychtoolboxDemosChinese

代码源自[PsychtoolboxDemos](http://peterscarfe.com/ptbtutorials.html)，不定期更新～

这些demos给初学者介绍如何使用Psychtoolbox(PTB)进行刺激材料的制作与演示，强烈建议初学者按照顺序阅读代码文件，这些demos从简单到复杂，循序渐进的演示了PTB的使用方法。

即使你已经了解了PTB的部分特性，也建议先阅读section(1)，section(2)，再阅读后面的部分。这些代码展示了某些至关重要的，增加程序开发速度的方法（译者注：不阅读前面的部分还会出现无法理解变量名，甚至无法理解刺激演示的整体逻辑等情况，别问我怎么知道的:sob:），如果你没有了解这些方法，阅读后面的代码可能会很困难。

译者在翻译的基础上添加或修改了部分注释与代码，使得它更适合初学者阅读。

- The Basic
  1. [Toally Minimal Demo](https://github.com/IQAQ/PsychtoolboxDemosChinese/blob/master/(1)TheBasics/TotallyMinimalDemo.m)
  2. [Toally Minimal Demo #2](https://github.com/IQAQ/PsychtoolboxDemosChinese/blob/master/(1)TheBasics/TotallyMinimalDemo2.m)
  3. [Accurate Timing Demo](https://github.com/IQAQ/PsychtoolboxDemosChinese/blob/master/(1)TheBasics/AcurateTimimgDemo.m)
  4. [Wait Frames Demo](https://github.com/IQAQ/PsychtoolboxDemosChinese/blob/master/(1)TheBasics/WaitFramesDemo.m)
  5. [Screen Coordinates Demo](https://github.com/IQAQ/PsychtoolboxDemosChinese/blob/master/(1)TheBasics/ScreenCoordinatesDemo.m)

- Drawing Basic Shapes And Dots

  这部分的Demo将演示如何绘制最基本的静止形状，线条和点。这部分包含了非常多PTB的核心功能，为理解以后的资料打下坚实的基础。

  1. [SingleDotDemo](https://github.com/IQAQ/PsychtoolboxDemosChinese/blob/master/(2)DrawingBasicShapesAndDots/SingleDotDemo.m)	这是个非常简单的Demo，程序在屏幕中的随机位置绘制单个点
  2. [DotGridDemo](https://github.com/IQAQ/PsychtoolboxDemosChinese/blob/master/(2)DrawingBasicShapesAndDots/DotGridDemo.m)       这个Demo教会你如何同时绘制多个，具有不同大小和颜色的点

- Sound

  这些材料将向你展示最基本的，使用PTB播放产生声音的方法。第一个demo不展示视觉刺激，第二个demo展示视觉刺激与声音的同步方法。这些演示都要使用PsychPortAudio播放，这是一种可靠稳健的播放声音的方法。

  这些demos需要产生声音，作者在自己电脑上将声音的音量调整为合适的大小，但这并不适用于所有的电脑。在播放声音之前，请确保在你自己的电脑音量大小合适，可以先从一个较低的音量进行测试，如果音量不足再调整。

  1. [Simple Beep Demo](https://github.com/IQAQ/PsychtoolboxDemosChinese/blob/master/(7)Sound/SimpleBeepDemo.m)	这个演示中我们播放一个beep一秒钟，暂停一秒，再播放一秒的beep。这个演示将会向你介绍如何初始化PsychPortAudio并播放声音。

