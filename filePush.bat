@Echo on
TITLE 资源导入脚本
:start
CLS
COLOR 2f
mode con cols=80 lines=20

:mian
echo 连接手机
adb remount
@echo ===================================
@echo 导入类型
@echo           1：图片
@echo           2: 视频
@echo           3：录音文件
@echo           4：文档
@echo           5："Q" 退出
@echo off  导入其他文件后续可增加
@echo ===================================
set /p selection=请选择导入类型(1,2,3,4)，按回车继续:
echo %selection%

if "%selection%"=="1" (goto copyImage)
if "%selection%"=="2" (goto copyCamera)
if "%selection%"=="3" (goto copyAuido)
if "%selection%"=="4" (goto copyText)
if "%selection%"=="Q" (goto exit)

:exit
exit
goto :eof

:copyImage
echo 拷贝图片
adb shell rm -rf /storage/emulated/0/Camera/*.*
adb push ./sh/photo.jpg /storage/emulated/0/Camera
adb push ./sh/filecopy.sh /storage/emulated/0/Camera
adb shell dos2unix /storage/emulated/0/Camera/filecopy.sh
adb shell chmod 777 /storage/emulated/0/Camera/filecopy.sh
set importPath="/storage/emulated/0/Camera"
set /p importNum=请输入导入文件的个数，按回车继续(例如1000):
adb shell sh %importPath%/filecopy.sh %importNum% photo jpg %importPath%
adb shell rm -rf /storage/emulated/0/Camera/filecopy.sh
adb shell rm -rf /storage/emulated/0/Camera/photo.jpg
adb reboot
pause
goto exit

:copyCamera
echo 拷贝视频
adb shell rm -rf /storage/emulated/0/Camera/*.*
adb push ./sh/vedio.mp4 /storage/emulated/0/Camera
adb push ./sh/filecopy.sh /storage/emulated/0/Camera
adb shell dos2unix /storage/emulated/0/Camera/filecopy.sh
adb shell chmod 777 /storage/emulated/0/Camera/filecopy.sh
set importPath="/storage/emulated/0/Camera"
set /p importNum=请输入导入文件的个数(例如100):
adb shell sh %importPath%/filecopy.sh %importNum% vedio mp4 %importPath%
adb shell rm -rf /storage/emulated/0/Camera/filecopy.sh
adb shell rm -rf /storage/emulated/0/Camera/vedio.mp4
adb reboot
pause
goto exit

:copyAuido
echo 拷贝录音
adb shell rm -rf /storage/emulated/0/Sounds/*.*
adb push ./sh/record.aac /storage/emulated/0/Sounds
adb push ./sh/filecopy.sh /storage/emulated/0/Sounds
adb shell dos2unix /storage/emulated/0/Sounds/filecopy.sh
adb shell chmod 777 /storage/emulated/0/Sounds/filecopy.sh
set importPath="/storage/emulated/0/Sounds"
set /p importNum=请输入导入文件的个数(例如100):
adb shell sh %importPath%/filecopy.sh %importNum% record aac %importPath%
adb shell rm -rf /storage/emulated/0/Camera/filecopy.sh
adb shell rm -rf /storage/emulated/0/Camera/record.aac
adb reboot
pause
goto exit

:copyText
echo 拷贝文档
adb shell rm -rf /storage/emulated/0/*.txt
adb push ./sh/test.txt /storage/emulated/0
adb push ./sh/filecopy.sh /storage/emulated/0
adb shell dos2unix /storage/emulated/0/filecopy.sh
adb shell chmod 777 /storage/emulated/0/filecopy.sh
set importPath="/storage/emulated/0"
set /p importNum=请输入导入文件的个数(例如100):
adb shell sh %importPath%/filecopy.sh %importNum% test txt %importPath%
adb shell rm -rf /storage/emulated/0/filecopy.sh
adb shell rm -rf /storage/emulated/0/test.txt
adb reboot
pause
goto exit
