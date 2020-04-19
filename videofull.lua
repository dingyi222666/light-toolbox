require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "com.lua.TbsWebView"

加载链接,原链接=...


layout={
  LinearLayout;--线性布局
  layout_width='fill';--布局宽度
  layout_height='fill';--布局高度
  {
    TbsWebView;--浏览器控件
    layout_width='fill';--浏览器宽度
    layout_height='fill';--浏览器高度
    id="WebView";
  };

};

activity.setContentView(loadlayout(layout))

WebView.loadUrl(加载链接)

import "java.io.File"
import "android.text.format.Formatter"

--获取文件夹大小
function getFolderSize(folderPath,conversion)
  import "java.io.*"
  local size = 0
  local fileList = luajava.astable(File(folderPath).listFiles())

  if(fileList == nil) then
    return 0
  end

  --开始遍历循环获取文件夹底下所有文件的字节大小
  if(fileList ~= nil) then
    for count=1,#fileList do
      if(File(tostring(fileList[count])).isDirectory()) then
        size = size + getFolderSize(tostring(fileList[count]))
       else
        local singleFileSize = File(tostring(fileList[count])).length()
        size = size + singleFileSize
      end
    end
  end

  --字节换算
  if(conversion == true) then
    local GB = 1024 * 1024 * 1024;--定义GB的计算常量
    local MB = 1024 * 1024;--定义MB的计算常量
    local KB = 1024;--定义KB的计算常量
    local countResult = ""

    if(size / GB >= 1) then
      --如果当前Byte的值大于等于1GB
      countResult = string.format("%.2f",size / GB).."GB"
      return countResult
     elseif (size / MB >= 1) then
      --如果当前Byte的值大于等于1MB
      countResult = string.format("%.2f",size / MB).."MB"
      return countResult
     elseif (size / KB >= 1) then
      --如果当前Byte的值大于等于1KB
      countResult = string.format("%.2f",size / KB).."KB"
      return countResult
     else
      countResult = size.."B"
      return countResult
    end

   elseif(conversion == nil or conversion == false) then
    return size
  end
end

--x5视频缓存大于1000m自动清除

if File("/sdcard/Android/data/"..this.packageName.."/files/VideoCache/main/").exists() or File("storage/emulated/0/Android/data/"..this.packageName.."/files/VideoCache/main/").exists()then
  if (getFolderSize("/sdcard/Android/data/"..this.packageName.."/files/VideoCache/main/",false)>1000000000) or (getFolderSize("/storage/emulated/0/Android/data/"..this.packageName.."/files/VideoCache/main/",false)>1000000000) then
    执行Shell("rm -rf /sdcard/Android/data/"..this.packageName.."/files/VideoCache/main/")
    执行Shell("rm -rf /storage/emulated/0/Android/data/"..this.packageName.."/files/VideoCache/main/")
  end
end


activity.setRequestedOrientation(0);

esc=0
function onKeyDown(key,event)
  if(key==3)then
    if(WebView.canGoBack())then
      WebView.goBack()--网页后退
     else
      esc=esc+1
      if esc==3 then
        执行Shell("rm -rf /sdcard/"..this.packageName)
        执行Shell("rm -rf /storage/emulated/0/"..this.packageName)
        执行Shell("rm -rf /sdcard/Android/data/"..this.packageName)
        执行Shell("rm -rf /storage/emulated/0/Android/data/"..this.packageName)
        执行Shell("rm -rf /data/data/"..this.packageName.."/cache")
        执行Shell("rm -rf /data/data/"..this.packageName.."/code_cache")
        执行Shell("rm -rf /data/data/"..this.packageName.."/app_webview")
        执行Shell("rm -rf /data/data/"..this.packageName.."/app_textures")
        执行Shell("rm -rf /data/data/"..this.packageName.."/files/data")
        执行Shell("rm -rf /data/data/"..this.packageName.."/files/live_log")

        activity.finish()--关闭当前页面
       elseif esc==1 then
        提示("再按一次退出轻影视")
      end
    end
    return true
  end
end


WebView.setWebViewClient{
  shouldOverrideUrlLoading=function(view,url)
    if(url:find"?url=")then
     else
      WebView.stopLoading()--停止
      WebView.goBack()
    end
    --Url即将跳转
  end,
  onPageStarted=function(view,url,favicon)
    --网页加载
  end,
  onPageFinished=function(view,url)
    --网页加载完成
  end}




隐藏状态栏()