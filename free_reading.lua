require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"



activity.setContentView(loadlayout("layout/free_reading"))




activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);


--网页中的视频，上屏幕的时候，可能出现闪烁的情况，需要如下设置
activity.getWindow().setFormat(PixelFormat.TRANSLUCENT);


webview.loadUrl("http://m.ting56.com/")
js_table="var d=document;var s=d.createElement('script');s.setAttribute('src', 'https://greasyfork.org/scripts/7410-jskillad/code/jsKillAD.user.js');d.head.appendChild(s);"

edit={"footer","copyright","qian-3","dh","qian2"}


webview.getSettings().setJavaScriptEnabled(true);



--无广告百度UA
webview.getSettings().setDisplayZoomControls(false); --隐藏自带的右下角缩放控件
webview.getSettings().setSupportZoom(true); --支持网页缩放
webview.getSettings().setDomStorageEnabled(false); --dom储存数据
webview.getSettings().setDatabaseEnabled(false); --数据库
webview.getSettings().setAppCacheEnabled(false); --启用缓存
webview.getSettings().setUseWideViewPort(true);
webview.getSettings().setAllowFileAccess(true);--允许访问文件
webview.getSettings().setBuiltInZoomControls(true); --支持缩放
webview.getSettings().setLoadWithOverviewMode(true);
webview.getSettings().setLoadsImagesAutomatically(true);--图片自动加载
webview.getSettings().setSaveFormData(true); --保存表单数据，就是输入框的内容，但并不是全部输入框都会储存
webview.getSettings().setAllowContentAccess(true); --允许访问内容
webview.getSettings().setJavaScriptEnabled(true); --支持js脚本
webview.getSettings().supportMultipleWindows() --设置多窗口
webview.getSettings().setUseWideViewPort(true) --图片自适应
webview.setLayerType(View.LAYER_TYPE_HARDWARE,nil);--硬件加速
webview.getSettings().setPluginsEnabled(true)--支持插件
webview.getSettings().setCacheMode(webview.getSettings().LOAD_NO_CACHE);--设置缓存加载方式
webview.getSettings().setLayoutAlgorithm(webview.getSettings().LayoutAlgorithm.SINGLE_COLUMN)--支持重新布局
webview.getSettings().setGeolocationEnabled(true);--启用地理定位
webview.getSettings().setUseWideViewPort(true)--调整图片自适应


--自定义UA

function onDestroy()
    webview.stopLoading()
    webview.loadDataWithBaseURL(nil, "", "text/html", "utf-8", nil);
    webview.clearHistory()
    webview.onPause();
    webview.removeAllViews();    
    webview.destroy()
    webview.gc()
    System.gc()
     collectgarbage("collect")    
    _G=nil--销毁WebView(G表里面删除)
end
webview.getSettings().setUserAgentString([[Mozilla/5.0 (Symbian/3; Series60/5.2 NokiaN8-00/012.002; Profile/MIDP-2.1 Configuration/CLDC-1.1 ) AppleWebKit/533.4 (KHTML, like Gecko) NokiaBrowser/7.3.0 Mobile Safari/533.4 3gpp-gba]])

--x5内核设置字体大小:100表示正常,120表示文字放大1.2倍
webview.getSettings().setTextZoom(100)



webview.setWebViewClient({
  shouldOverrideUrlLoading=function(view,url)
  标题.Text=view.getTitle()
  webview.getSettings().setUserAgentString([[Mozilla/5.0 (Symbian/3; Series60/5.2 NokiaN8-00/012.002; Profile/MIDP-2.1 Configuration/CLDC-1.1 ) AppleWebKit/533.4 (KHTML, like Gecko) NokiaBrowser/7.3.0 Mobile Safari/533.4 3gpp-gba]])
  end,
  onPageStarted=function(view,url,favicon)
   标题.Text=view.getTitle()
   webview.getSettings().setUserAgentString([[Mozilla/5.0 (Symbian/3; Series60/5.2 NokiaN8-00/012.002; Profile/MIDP-2.1 Configuration/CLDC-1.1 ) AppleWebKit/533.4 (KHTML, like Gecko) NokiaBrowser/7.3.0 Mobile Safari/533.4 3gpp-gba]])
  end,
  onPageFinished=function(view,url)
    屏蔽元素(webview,edit)
    加载js(webview,js_table)
    标题.Text=view.getTitle()
  end,
  onLoadResource=function(view,url)
    屏蔽元素(webview,edit)
    加载js(webview,js_table)
  end,

  onReceivedError=function(var1,var2,var3,var4)
    提示("网页加载失败")
  end}
)






--网页与返回键之间的交互

function onKeyDown(keyCode,event)
  if (keyCode == KeyEvent.KEYCODE_BACK && webview.canGoBack())then
    webview.goBack()
    return true
  end
  return false
end


--导入类
通知栏颜色(returntheme())

import "android.webkit.*"
import "android.content.Intent"
import "android.app.Activity"
import "android.text.format.Formatter"


function Too_young()
  webview.setDownloadListener{onDownloadStart=function(url,userAgent,contentDisposition,mimetype,contentLength)
      文件名=URLUtil.guessFileName(url, contentDisposition, mimeType);
      下载链接=url
      文件类型=mimetype
      文件大小=Formatter.formatFileSize(this, contentLength)
      if 文件名=="" or nil then
        文件名=os.date("%Y%m%d%H%M%S")
      end
      下载()
      function adm(url)
        if pcall(function ()activity.getPackageManager().getPackageInfo("com.dv.adm.pay",0) end ) then
          this.startActivity(Intent().setAction("android.intent.action.SEND").setType("text/*").putExtra("android.intent.extra.TEXT", url).setClassName("com.dv.adm.pay", "com.dv.adm.pay.AEditor"))
         else
          提示("没有安装ADM")
        end
      end
    end}
end
Too_young()
function 下载()--以下代码可自由编辑，每当监听到下载任务时会运行以下代码。可用的值：url,userAgent,contentDisposition,mimetype,contentLength,文件名,文件类型,文件大小,下载链接
  AlertDialog.Builder(this)
  .setTitle("新建下载任务")
  .setMessage("文件名："..文件名.."\n文件类型："..文件类型.."\n文件大小："..文件大小.."\n下载链接："..下载链接.."")
  .setPositiveButton("下载",{onClick=function(v)
      系统下载(下载链接,"sdcard/轻工具箱/downloads",文件名)
    end})
  .setNegativeButton("取消",nil)
  .setNeutralButton("ADM下载",{onClick=function(v)
      adm(下载链接)
    end})
  .show()
end


import "mods.onClick"
图片点击(webview)