require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"

activity.setContentView(loadlayout("layout/cartoon"))

--设置波纹

波纹(menu,0x5FFFFFFF)
波纹(ck1,0x5FFFFFFF)
波纹(ck2,0x5FFFFFFF)
波纹(ck3,0x5FFFFFFF)
波纹(ck4,0x5FFFFFFF)

--设置滑动条&字体颜色
appp=activity.getWidth()
local kuan=appp/4
huadong.setOnPageChangeListener(PageView.OnPageChangeListener{
  onPageScrolled=function(a,b,c)
    huat.setX(kuan*(b+a))
    if c==0 then
      if a==0 then
        chuankou1.setTextColor(0xffffffff)
        chuankou2.setTextColor(0x9fffffff)
        chuankou3.setTextColor(0x9fffffff)
        chuankou4.setTextColor(0x9fffffff)
        this=1
       elseif a==1 then
        chuankou1.setTextColor(0x9fffffff)
        chuankou2.setTextColor(0xffffffff)
        chuankou3.setTextColor(0x9fffffff)
        chuankou4.setTextColor(0x9fffffff)
        this=2
       elseif a==2 then
        chuankou1.setTextColor(0x9fffffff)
        chuankou2.setTextColor(0x9fffffff)
        chuankou3.setTextColor(0xffffffff)
        chuankou4.setTextColor(0x9fffffff)
        this=3
       elseif a==3 then
        chuankou1.setTextColor(0x9fffffff)
        chuankou2.setTextColor(0x9fffffff)
        chuankou3.setTextColor(0x9fffffff)
        chuankou4.setTextColor(0xffffffff)
        this=4
      end
    end
  end})



--设置点击事件



menu.onClick=function()
  pop=PopupMenu(activity,menu2)
  menu=pop.Menu
  menu.add("全屏").onMenuItemClick=function(a)
    取消全屏()
  end
  menu.add("刷新").onMenuItemClick=function(a)
    当前打开的页面().reload()
  end
  menu.add("前进").onMenuItemClick=function(a)
    if 当前打开的页面().canGoForward() then
      当前打开的页面().goForward()
     else
      提示("不能再前进啦")
    end
  end

  menu.add("后退").onMenuItemClick=function(a)
    if 当前打开的页面().canGoBack() then
      当前打开的页面().goBack()
     else
      提示("不能再后退啦")
    end
  end
  menu.add("退出").onMenuItemClick=function(a)
    activity.finish();
  end
  pop.show()
end


ck1.onClick=function()
  huadong.showPage(0)
end


ck2.onClick=function()
  if cartoon_two.getUrl()==nil then
    cartoon_two.loadUrl("http://m.wuqimh.com/latest/")
  end
  huadong.showPage(1)
end


ck3.onClick=function()
  huadong.showPage(2)
  if cartoon_three.getUrl()==nil then
    cartoon_three.loadUrl("http://m.wuqimh.com/rank/")
  end
end


ck4.onClick=function()
  if cartoon_four.getUrl()==nil then
    cartoon_four.loadUrl("http://m.wuqimh.com/list/")
  end
  huadong.showPage(3)
end

function 当前打开的页面()
  if this==1 then
    return cartoon_one
   elseif this==2
    return cartoon_two
   elseif this==3
    return cartoon_three
   elseif this==4
    return cartoon_four
  end
end

this=1


function 取消全屏()

  import "android.view.WindowManager"
  --需程序启动赋予barisshow初始值0

  if barisshow == 0 then
    --状态栏
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
    --顶栏
    toolbarParent.setVisibility(8);
    btn0.setVisibility(8);
    fltBtn2.setVisibility(0);
    barisshow = 1;
   else
    activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
    toolbarParent.setVisibility(0);
    btn0.setVisibility(0);
    fltBtn2.setVisibility(8);
    barisshow = 0;
  end
  --悬浮按钮点击时执行的事件

end


barisshow=0;


function 浏览器设置(id)
  webview=id.getSettings();
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

  webview.setUserAgentString("Mozilla/5.0 (Symbian/3; Series60/5.2 NokiaN8-00/012.002; Profile/MIDP-2.1 Configuration/CLDC-1.1 ) AppleWebKit/533.4 (KHTML, like Gecko) NokiaBrowser/7.3.0 Mobile Safari/533.4 3gpp-gba")
end


function 浏览器通用配置(id)
  id.setWebViewClient({
    shouldOverrideUrlLoading=function(view,url)
      pcall(function()
        if url:find(".html") then --(if判断)
          activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
          toolbarParent.setVisibility(8);
          btn0.setVisibility(8);
          fltBtn2.setVisibility(0);
          barisshow = 1;
        end
      end)
    end,
    onPageFinished=function(view,url)
      屏蔽元素(view,{"a__qekak","main-nav","@ID<toPC>","@ID<pageNo>"})
      加载js(view,"var d=document;var s=d.createElement('script');s.setAttribute('src', 'https://greasyfork.org/scripts/7410-jskillad/code/jsKillAD.user.js');d.head.appendChild(s);")
      加载js(view,"document.body.style.marginTop='-45px'")
    end,
    onLoadResource=function(view,url)
      屏蔽元素(view,{"a__qekak","main-nav","@ID<toPC>","@ID<pageNo>"})
      加载js(view,"var d=document;var s=d.createElement('script');s.setAttribute('src', 'https://greasyfork.org/scripts/7410-jskillad/code/jsKillAD.user.js');d.head.appendChild(s);")
      加载js(view,"document.body.style.marginTop='-45px'")
    end,

    onReceivedError=function(var1,var2,var3,var4)

      提示("网页加载失败")

    end}
  )

end
import "mods.onclick"
cartoon_one.loadUrl("http://m.wuqimh.com/")
浏览器设置(cartoon_one)
浏览器通用配置(cartoon_one)
图片点击(cartoon_one)
浏览器设置(cartoon_two)
浏览器通用配置(cartoon_two)
图片点击(cartoon_two)
浏览器设置(cartoon_three)
浏览器通用配置(cartoon_three)
图片点击(cartoon_three)
浏览器设置(cartoon_four)
浏览器通用配置(cartoon_four)
图片点击(cartoon_four)
通知栏颜色(returntheme())

