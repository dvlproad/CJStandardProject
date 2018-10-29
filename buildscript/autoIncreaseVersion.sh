# [利用脚本实现build号自动加一](https://www.cnblogs.com/Crazy-ZY/p/7797784.html)
# ${SRCROOT}代表的时项目根目录下；${PROJECT_DIR}代表的是整个项目。PS：往项目添加文件时，例如.a等，要先show in finder ，复制到项目中，然后再拖到xcode项目中。而有时，我们的.a不在工程目录中，比如在工程的父目录上，可以写成：$(SRCROOT)/../YSKit/libWeChatSDK。其中/../ 就是指向父目录。

if ([ $CONFIGURATION == Debug ]); then
echo "Bumping build number..."
plist=${PROJECT_DIR}/${INFOPLIST_FILE}

#increment the build number (ie 115 to 116)
buildnum=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${plist}")
if [[ "${buildnum}" == "" ]]; then
echo "No build number in $plist"
exit 2
fi

buildnum=$(expr $buildnum + 1)
/usr/libexec/Plistbuddy -c "Set CFBundleVersion $buildnum" "${plist}"
echo "Bumped build number to $buildnum"

else
echo $CONFIGURATION " build - Not bumping build number."

fi
