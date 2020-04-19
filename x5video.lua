require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "com.lua.*"
this.setContentView(loadlayout ({
  LinearLayout;
  orientation="vertical";
  layout_height="fill";
  layout_width="fill";
  {
    LinearLayout;--整个动画栏--
    layout_height="-2";
    layout_width="-1";
    id="toolbar";
    elevation="2dp";
    BackgroundColor=returntheme();
    orientation="vertical";
    {
      LinearLayout;--顶栏--
      layout_height="56dp";
      layout_width="-1";
      gravity="left|center";
      {
        ImageView;
        layout_height="56dp";
        layout_width="56dp";
        padding="16dp";
        ColorFilter="#ffffffff";
        id="back";
        foreground=转波纹色(0x5FFFFFFF);
        src="image/twotone_arrow_back_black_24dp.png";
        onClick=function() activity.finish() end,
      };
      {
        TextView;
        layout_height="-2";
        layout_width="-1";
        layout_weight="1";
        paddingLeft="16dp";
        textColor="#ffffffff";
        textSize="20sp";
        id="标题";
      };
      {
        ImageView;
        src="image/ic_dots_vertical.png";
        layout_height="56dp";
        layout_width="56dp";
        padding="16dp";
        foreground=转波纹色(0x5FFFFFFF);
        onClick=function(l,v)
          pop=PopupMenu(activity,l)
          menu=pop.Menu
          menu.add("刷新").onMenuItemClick=function(a)
            webview.reload()
          end
          menu.add("分享链接").onMenuItemClick=function(a)
            分享文字(webview.getUrl())
          end
          menu.add("横竖屏切换").onMenuItemClick=function(a)
            if SetHSP==nil then
              --横屏
              activity.setRequestedOrientation(0);
              SetHSP="H"
             else
              --竖屏
              activity.setRequestedOrientation(1);
              SetHSP=nil
            end
            --复制粘贴到各种点击事件里
          end
          menu.add("浏览器打开").onMenuItemClick=function(a)
            import "android.content.Intent"
            import "android.net.Uri"
            viewIntent = Intent("android.intent.action.VIEW",Uri.parse(webview.getUrl()))
            activity.startActivity(viewIntent)
          end
          pop.show()--显示;
        end;
        ColorFilter="#ffffffff";--图片着色
        id="ssss";
      };
    };

  };

  {
    TbsWebView;
    layout_height="fill";
    layout_width="fill";
    id="webview";

  };
}
))

website,title,js_table,edit,mode=...


activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);


--网页中的视频，上屏幕的时候，可能出现闪烁的情况，需要如下设置
activity.getWindow().setFormat(PixelFormat.TRANSLUCENT);


webview.loadUrl(website)

标题.Text=title


webview.getSettings().setJavaScriptEnabled(true)
webview.getSettings().setDisplayZoomControls(false); --隐藏自带的右下角缩放控件
webview.getSettings().setSupportZoom(true); --支持网页缩放
webview.getSettings().setDomStorageEnabled(true); --dom储存数据
webview.getSettings().setDatabaseEnabled(true); --数据库
webview.getSettings().setAppCacheEnabled(true); --启用缓存
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
webview.getSettings().setCacheMode(webview.getSettings().LOAD_CACHE_ELSE_NETWORK);--设置缓存加载方式
webview.getSettings().setLayoutAlgorithm(webview.getSettings().LayoutAlgorithm.SINGLE_COLUMN)--支持重新布局
webview.getSettings().setGeolocationEnabled(true);--启用地理定位
webview.getSettings().setUseWideViewPort(false)--调整图片自适应

--自定义UA


webview.getSettings().setUserAgentString(APP_NAME_UA);



--x5内核设置字体大小:100表示正常,120表示文字放大1.2倍
webview.getSettings().setTextZoom(100)



webview.setWebViewClient({
  shouldOverrideUrlLoading=function(view,url)
    webview.getSettings().setUserAgentString([[Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Mobile Safari/537.36]]);
    if url:find("http") or url:find("https") or url:find("www") then
     else
    view.stopLoading() 
AlertDialog.Builder(this)
.setTitle("提示")
.setMessage("是否打开第三方软件？")
.setPositiveButton("打开",{onClick=function()
    intent=Intent("android.intent.action.VIEW")
      intent.setData(Uri.parse(url))
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_SINGLE_TOP)
      this.startActivity(intent)
      end})
.show()
      
    end
  end,
  onPageStarted=function(view,url,favicon)
    webview.getSettings().setUserAgentString([[Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Mobile Safari/537.36]]);
  end,
  onPageFinished=function(view,url)
    webview.getSettings().setUserAgentString([[Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Mobile Safari/537.36]]);
    屏蔽元素(webview,edit)
    加载js(webview,js_table)
  end,
  onLoadResource=function(view,url)
    webview.getSettings().setUserAgentString([[Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Mobile Safari/537.36]]);
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



图片点击(webview)