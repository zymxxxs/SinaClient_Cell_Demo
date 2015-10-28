# SinaClient\_Cell\_Demo
一个关于新浪微博cell的demo。

之前一直忙项目，这两天空了下来。想起了之前这个Demo还存在两个问题。
1、约束冲突问题
2、采用NSTextAttachement来做图文混排的时候，表情向上偏移。

同时对有些代码进行了重构。

### screenshot<br>
[![显示效果图1][image-1]][1]
[![显示效果图2][image-2]][2]
</br>

我在github找到了很多可以识别@，话题和url的优秀开源库，但自己的主要目的时学习，所以这次主要使用使用了textkit来做，用NSTextAttachment来做了表情。

* 感谢[VVebo][3]微博客户端，我从中提取出来来147个微博表情和对应的plist表。
* textkit参考自[KILabelDemo][4]。


## Requirements

* Xcode 7
* iOS 7
* ARC

## 备注
使用前你需要在TTIClientConfig.h中替换SINA\_APP\_KEY、SINA\_APP\_SECRET和SINA\_REDIRECT\_URL三个参数(当然也可能不需要了)。



[1]:	images/screenshot_001.jpg
[2]:	images/screenshot_002.png
[3]:	https://appsto.re/cn/TNu_N.i
[4]:	https://github.com/Krelborn/KILabel

[image-1]:	images/screenshot_001.png
[image-2]:	images/screenshot_002.png