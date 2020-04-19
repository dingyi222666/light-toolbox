require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "res.strings"
import "mods.onclick"
载入页面("layout/light_film")




preferences=activity.getSharedPreferences("help",0);
数据=preferences.getString("数据","nil");
if 数据=="nil" then
  gt=
  {
    LinearLayout,
    orientation='vertical',
    layout_width='fill',--布局宽度
    layout_height='fill',--布局高度
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout,
      orientation='vertical',--重力属性
      layout_width='fill',--布局宽度
      layout_height='wrap',--布局高度
      gravity='center',--默认居中
      backgroundColor='#00FFFFFF',--背景色
      {
        TextView,--文本控件
        layout_margin='15dp',--卡片边距
        layout_width='fill',--文本宽度
        layout_height='fill',--文本高度
        text="问:如何使用本软件?\n答:搜索你想看的影片即可，当然点击右上角还可以自助解析\n问:自助解析是啥\n答:就好像是吃自助餐一样你输入随便一个平台的视频就可以解析了。\n问:这个功能会收费吗\n答:不会";
        textSize='16sp',--文字大小
        id='xiaoxi',
        TextColor="#ff000000";
      },
    },
    {
      LinearLayout,
      orientation='vertical',--布局方向
      layout_width='fill',--布局宽度
      layout_height='fill',--布局高度
      {
        CheckBox,--复选框
        layout_marginLeft='3%w',--布局左距
        id='sy',
        text="不再提醒";
      },
    },
  }
  local dialog=AlertDialog.Builder(this)
  .setTitle("使用帮助")--标题
  .setView(loadlayout(gt))
  .setPositiveButton("好的",{onClick=function()
      if 状态==true then
        import "android.content.Context"
        preferences=this.getSharedPreferences("help",0);
        editor=preferences.edit();
        数据="1";
        editor.putString("数据",数据);
        editor.commit();
      end
    end})
  .setNeutralButton("取消",nil)
  .show()
  sy.setOnCheckedChangeListener{
    onCheckedChanged=function(g,c)
      if c then
        状态=c
       else
        状态=c
      end
    end}

end

webView.getSettings().setUserAgentString("Mozilla/5.0 (Symbian/3; Series60/5.2 NokiaN8-00/012.002; Profile/MIDP-2.1 Configuration/CLDC-1.1 ) AppleWebKit/533.4 (KHTML,like Gecko) NokiaBrowser/7.3.0 Mobile Safari/533.4 3gpp-gba")


webView.getSettings().setJavaScriptCanOpenWindowsAutomatically(true);
webView.getSettings().setDisplayZoomControls(true);
webView.getSettings().setSupportZoom(true);
webView.getSettings().setDomStorageEnabled(true);
webView.getSettings().setDatabaseEnabled(true);
webView.getSettings().setAppCacheEnabled(true);
webView.getSettings().setUseWideViewPort(false);
webView.getSettings().setAllowFileAccess(true);
webView.getSettings().setBuiltInZoomControls(true);
webView.getSettings().setDisplayZoomControls(true);
webView.getSettings().setLoadWithOverviewMode(true);
webView.getSettings().setLoadsImagesAutomatically(true);
webView.getSettings().setSaveFormData(true);
webView.getSettings().setDefaultTextEncodingName("UTF-8");
webView.getSettings().setAllowContentAccess(true);
webView.getSettings().setBlockNetworkImage(false);
webView.getSettings().setAllowFileAccessFromFileURLs(true);
webView.getSettings().setAllowUniversalAccessFromFileURLs(true);
webView.getSettings().setAllowContentAccess(true);
webView.getSettings().setJavaScriptEnabled(true);


webView.setWebViewClient({
  shouldOverrideUrlLoading=function(view,url)
    网页链接=url
    原链接=url
    if(网页链接:find".apk")then
      webView.stopLoading()--
     elseif(网页链接:find"?url=")then
     elseif(网页链接:find"sogou.com/")then
     else
      if(网页链接:find"qq.com") or
        (网页链接:find"iqiyi") or
        (网页链接:find"wasu") or
        (网页链接:find"youku") or
        (网页链接:find"sohu") or
        (网页链接:find"kankan") or
        (网页链接:find"mgtv") or
        (网页链接:find"tudou") or
        (网页链接:find"le.com") or
        (网页链接:find"pptv") or
        (网页链接:find"pps") or
        (网页链接:find"bestv") or
        (网页链接:find"baofeng") or
        (网页链接:find"fun.tv") or
        (网页链接:find"hanju.cc") or
        (网页链接:find"1905.com") then
        webView.stopLoading()
        local date1={}
        local date2={}
        for c in io.lines(接口文件路径) do
          table.insert(date1,c)
        end
        for i=1,#date1 do
          if i>74 then
            table.insert(date2,"添加的解析接口"..tostring(i-74))
           else
            table.insert(date2,"解析接口"..tostring(i))
          end
        end
        AlertDialog.Builder(this)
        .setTitle("选择解析接口")
        .setItems(date2,{onClick=function(l,v)
            activity.newActivity("videofull",{date1[v+1]..网页链接,原链接})
          end})
        .show()
       else
      end
    end
  end,
  onPageStarted=function(view,url,favicon)
  end,
  onPageFinished=function(view,url)
    屏蔽元素(view,{"header cf","fr opera","footer"})
  end,
  onLoadResource=function(view,url)

    屏蔽元素(view,{"header cf","fr opera","footer"})
  end,

  onReceivedError=function(var1,var2,var3,var4)

    提示("网页加载失败")

  end}
)


ti=Ticker()
ti.Period=500
ti.onTick=function()
  import "Pretend"
  j=获取剪贴版()
  if j=="" then
   else
    写入剪贴板("")
  end
end
ti.start()


通知栏颜色(returntheme())


webView.loadUrl("http://m.kan.sogou.com")

图片点击(webView)

esc=0
function onKeyDown(key,event)
  if(key==4)then
    if(webView.canGoBack())then
      webView.goBack()--网页后退
     else
      esc=esc+1
      if esc==2 then
        activity.finish()--关闭当前页面
       elseif esc==1 then
        提示("再按一次退出轻影视")
      end
    end
    return true
  end
end