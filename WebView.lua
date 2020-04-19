require "import"
require "Pretend"
import "mods.func"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "res.strings"
import "android.content.res.ColorStateList"
import "android.app.*"
import "java.util.HashMap"

导航栏颜色(returntheme())



website,title,js_table,edit,mode=...

if mode=="普通" then
  载入页面("layout/X5Webview_ordinary")
  if title=="磁力搜索" then
    APP_NAME_UA=[[Mozilla/5.0 (Symbian/3; Series60/5.2 NokiaN8-00/012.002; Profile/MIDP-2.1 Configuration/CLDC-1.1 ) AppleWebKit/533.4 (KHTML, like Gecko) NokiaBrowser/7.3.0 Mobile Safari/533.4 3gpp-gba]]
    标题.Text=title
   else
    if title=="跟随网页" then
      标题.Text="Title"
      title="跟随网页"
     else
      标题.Text=title
    end
  end
 elseif mode=="全屏_横"
  载入页面("layout/X5WebView_fullscreen")
  --横屏
  activity.setRequestedOrientation(0);
  隐藏状态栏()
 elseif mode=="全屏_竖"
  载入页面("layout/X5WebView_fullscreen")
  if website=="https://wx.qq.com/" then
    APP_NAME_UA=[[Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36]]
    webview.getSettings().setUserAgentString(APP_NAME_UA);
  end
  --竖屏
  隐藏状态栏()
  activity.setRequestedOrientation(1);
end



activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);


--网页中的视频，上屏幕的时候，可能出现闪烁的情况，需要如下设置
activity.getWindow().setFormat(PixelFormat.TRANSLUCENT);


webview.loadUrl(website)






--初始化,加载网页

--

--支持JS(建议无论如何加上)
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


webview.getSettings().setUserAgentString(APP_NAME_UA);



--x5内核设置字体大小:100表示正常,120表示文字放大1.2倍
webview.getSettings().setTextZoom(100)



webview.setWebViewClient({
  shouldOverrideUrlLoading=function(view,url)
    if title=="磁力链接" then
      APP_NAME_UA=[[Mozilla/5.0 (Symbian/3; Series60/5.2 NokiaN8-00/012.002; Profile/MIDP-2.1 Configuration/CLDC-1.1 ) AppleWebKit/533.4 (KHTML, like Gecko) NokiaBrowser/7.3.0 Mobile Safari/533.4 3gpp-gba]]
      view.getSettings().setUserAgentString(APP_NAME_UA);
     elseif title=="跟随网页" then
      标题.Text=view.getTitle()
    end
    if url:find("http") or url:find("https") or url:find("www") then
     else
      view.stopLoading()
      local a=AlertDialog.Builder(this)
      .setTitle("提示")
      .setMessage("是否打开第三方软件？")
      .setPositiveButton("打开",{onClick=function()
          intent=Intent("android.intent.action.VIEW")
          intent.setData(Uri.parse(url))
          intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_SINGLE_TOP)
          this.startActivity(intent)
        end})
      圆角显示(a)
    end
    view.getChildAt(0).setVisibility(0)
  end,
  onPageStarted=function(view,url,favicon)
    if title=="跟随网页" then
      标题.Text=view.getTitle()
    end
  end,
  onPageFinished=function(view,url)
    屏蔽元素(webview,edit)
    加载js(webview,js_table)
    if title=="跟随网页" then
      标题.Text=view.getTitle()
    end
    view.getChildAt(0).setVisibility(8)
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
      系统下载(下载链接,文件名)
    end})
  .setNegativeButton("取消",nil)
  .setNeutralButton("ADM下载",{onClick=function(v)
      adm(下载链接)
    end})
  .show()
end

import "mods.onclick"

图片点击(webview)


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
    _G=nil
end

uploadMessageAboveL=0
onActivityResult=function(req,res,intent)
  if (res == Activity.RESULT_CANCELED) then
    if(uploadMessageAboveL~=nil )then
      uploadMessageAboveL.onReceiveValue(nil);
    end
  end
  local results
  if (res == Activity.RESULT_OK)then
    if(uploadMessageAboveL==nil or type(uploadMessageAboveL)=="number")then
      return;
    end
    if (intent ~= nil) then
      local dataString = intent.getDataString();
      local clipData = intent.getClipData();
      if (clipData ~= nil) then
        results = Uri[clipData.getItemCount()];
        for i = 0,clipData.getItemCount()-1 do
          local item = clipData.getItemAt(i);
          results[i] = item.getUri();
        end
      end
      if (dataString ~= nil) then
        results = Uri[1];
        results[0]=Uri.parse(dataString)
      end
    end
  end
  if(results~=nil)then
    uploadMessageAboveL.onReceiveValue(results);
    uploadMessageAboveL = nil;
  end
end


import "com.lua.LuaWebChrome"
webview.setWebChromeClient(LuaWebChrome(LuaWebChrome.IWebChrine{

  onShowFileChooser=function(view, callback, a)
    uploadMessageAboveL=fic
    local intet = Intent(Intent.ACTION_GET_CONTENT);
    intet.addCategory(Intent.CATEGORY_OPENABLE);
    intet.setType("*/*");
    activity.startActivityForResult(Intent.createChooser(intet, "File Chooser"), 1);
    return true;

  end}))