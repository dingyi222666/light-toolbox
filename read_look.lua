require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "res.strings"
import "android.graphics.drawable.GradientDrawable"
import "android.graphics.Color"
--import "com.lua.TbsWebView"


activity.setContentView(loadlayout("layout/read_look"))

--布局初始化.....
--有点乱，，，

barisshow=0;

-----------函数区,封装常用函数


--------------重点!浏览器屏蔽元素----------
--依旧一个函数走起
--屏蔽函数见mods.func
function 浏览器通用配置(id)
  id.setWebViewClient({
    shouldOverrideUrlLoading=function(view,url)
    pcall(function()
      urltwo=url:match("/wu(.-).htm")--第一次匹配
      urltwo=urltwo:match("/(.+)")--第二次...
      urltwo=urltwo:match("%d+")--第三次...(匹配数字，返回nil或true)
      if urltwo~=nil then --(if判断)
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);        
        toolbarParent.setVisibility(8);
        btn0.setVisibility(8);
        fltBtn2.setVisibility(0);
        barisshow = 1;
      end
    end)
    end,
    onPageFinished=function(view,url)
      local txtroute="/data/data/"..activity.getPackageName().."/yejian.xml"
      import "java.io.File"
      File(txtroute).createNewFile()
      yejian=io.open(txtroute):read("*a")
      if yejian=="开启"then
        夜间模式(true)
      end
      屏蔽元素(view,{"header","nav","module_user unlogin","footer"})
    end,
    onLoadResource=function(view,url)
      local txtroute="/data/data/"..activity.getPackageName().."/yejian.xml"
      import "java.io.File"
      File(txtroute).createNewFile()
      yejian=io.open(txtroute):read("*a")
      if yejian=="开启"then
        夜间模式(true)
      end
      屏蔽元素(view,{"header","nav","module_user unlogin","footer"})
    end,

    onReceivedError=function(var1,var2,var3,var4)

      提示("网页加载失败")

    end}
  )

end

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


function 夜间模式(mode)
  local 白天色=returntheme()
  local 夜间色="#ff212121"
  if mode==true then
    toolbarParent.setBackgroundColor(Color.parseColor(夜间色));
    fltBtn.setBackgroundColor(Color.parseColor(夜间色));
    btn1.setBackgroundColor(Color.parseColor(夜间色));
    btn2.setBackgroundColor(Color.parseColor(夜间色));
    btn3.setBackgroundColor(Color.parseColor(夜间色));
    searchbar.setBackgroundColor(Color.parseColor(夜间色));
    加载js(read_one,读取文件(夜间JS文件路径))
    加载js(read_two,读取文件(夜间JS文件路径))
    加载js(read_three,读取文件(夜间JS文件路径))
    通知栏颜色(0xff212121)
    activity.setTheme(android.R.style.Theme_Material)
   else
    toolbarParent.setBackgroundColor(白天色);
    searchbar.setBackgroundColor(白天色);
    fltBtn.setBackgroundColor(白天色);
    btn1.setBackgroundColor(白天色);
    btn2.setBackgroundColor(白天色);
    btn3.setBackgroundColor(白天色);
    read_three.reload()
    read_one.reload()
    read_two.reload()
    activity.setTheme(android.R.style.Theme_Material_Light_DarkActionBar)
    通知栏颜色(returntheme())
  end

end

function 当前打开的页面()
  if 当前页面==1 then
    return read_one
   elseif 当前页面==2
    return read_two
   elseif 当前页面==3
    return read_three
  end
end

当前页面=1

local txtroute="/data/data/"..activity.getPackageName().."/yejian.xml"
import "java.io.File"
File(txtroute).createNewFile()
yejian=io.open(txtroute):read("*a")
if yejian=="开启"then
  夜间模式(true)
 else
  夜间模式(false)
end


-----------------

--设置滑动条&字体颜色
appp=activity.getWidth()
local kuan=appp/3
huadong.setOnPageChangeListener(PageView.OnPageChangeListener{
  onPageScrolled=function(a,b,c)
    huat.setX(kuan*(b+a))
    if c==0 then
      if a==0 then
        chuankou1.setTextColor(0xffffffff)
        chuankou2.setTextColor(0x9fffffff)
        chuankou3.setTextColor(0x9fffffff)
        当前页面=1
       elseif a==1 then
        chuankou1.setTextColor(0x9fffffff)
        chuankou2.setTextColor(0xffffffff)
        chuankou3.setTextColor(0x9fffffff)
        当前页面=2
       elseif a==2 then
        chuankou1.setTextColor(0x9fffffff)
        chuankou2.setTextColor(0x9fffffff)
        chuankou3.setTextColor(0xffffffff)
        当前页面=3
      end
    end
  end})



波纹(menu,0x5FFFFFFF)
原波纹(ck2,0x5FFFFFFF)
原波纹(ck1,0x5FFFFFFF)
原波纹(ck3,0x5FFFFFFF)

-------------点击事件-------------

menu.onClick=function()
  pop=PopupMenu(activity,menu2)
  menu=pop.Menu
  menu.add("夜间模式").onMenuItemClick=function(a)
    local txtroute="/data/data/"..activity.getPackageName().."/yejian.xml"
    import "java.io.File"
    File(txtroute).createNewFile()
    local b=io.open(txtroute):read("*a")
    if b=="开启"then
      io.open(txtroute,"w+"):write("1"):close()
      夜间模式(false)
      提示("夜间模式:关闭")
     else
      File(txtroute).createNewFile()
      io.open(txtroute,"w+"):write("开启"):close()
      夜间模式(true)
      提示("夜间模式:开启")
    end--作者:eoow
  end
  menu.add("全屏浏览").onMenuItemClick=function(a)
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
  huadong.showPage(1)
   if read_two.getUrl()==nil then
  read_two.loadUrl("https://m.ymoxuan.com/shuku.htm")
 end
end

ck3.onClick=function()
  huadong.showPage(2)
 if read_three.getUrl()==nil then
  read_three.loadUrl("https://m.ymoxuan.com/read/")
 end
end


-------先封装一个浏览器设置------
function 浏览器设置(id)
  webview=id.getSettings();
  webview.setDisplayZoomControls(false); --隐藏自带的右下角缩放控件
  webview.setSupportZoom(true); --支持网页缩放
  webview.setDomStorageEnabled(true); --dom储存数据
  webview.setDatabaseEnabled(true); --数据库
  webview.setAppCacheEnabled(true); --启用缓存
  webview.setUseWideViewPort(true);
  webview.setAllowFileAccess(true);--允许访问文件
  webview.setBuiltInZoomControls(true); --支持缩放
  webview.setLoadWithOverviewMode(true);
  webview.setLoadsImagesAutomatically(true);--图片自动加载
  webview.setSaveFormData(true); --保存表单数据，就是输入框的内容，但并不是全部输入框都会储存
  webview.setAllowContentAccess(true); --允许访问内容
  webview.setJavaScriptEnabled(true); --支持js脚本
  webview.supportMultipleWindows() --设置多窗口
  webview.setUseWideViewPort(true) --图片自适应
  webview.setPluginsEnabled(true)--支持插件
  webview.setCacheMode(webview.LOAD_CACHE_ELSE_NETWORK);--设置缓存加载方式
  webview.setLayoutAlgorithm(webview.LayoutAlgorithm.SINGLE_COLUMN)--支持重新布局
  webview.setGeolocationEnabled(true);--启用地理定位
  webview.setUseWideViewPort(false)--调整图片自适应
end


-------浏览器默认配置-------------
read_one.loadUrl("https://m.ymoxuan.com")
read_one.setProgressBarEnabled(false) -- 隐藏自带的进度条
read_one.getSettings().setJavaScriptEnabled(true);
浏览器设置(read_one)
浏览器通用配置(read_one)
图片点击(read_one)
--
read_two.setProgressBarEnabled(false) -- 隐藏自带的进度条
read_two.getSettings().setJavaScriptEnabled(true);
浏览器设置(read_two)
浏览器通用配置(read_two)
图片点击(read_two)
--
read_three.setProgressBarEnabled(false) -- 隐藏自带的进度条
read_three.getSettings().setJavaScriptEnabled(true);
浏览器设置(read_three)
浏览器通用配置(read_three)
图片点击(read_three)

--无用。



local w=this.getWidth()
local h=this.getHeight()

--获取状态栏高度
local function getStatusBarHeight(JDPUK)
  if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end
  local resid=activity.getResources().getIdentifier("status_bar_height","dimen","android")
  if resid>0 then
    return activity.getResources().getDimensionPixelSize(resid)
  end
end
jdpuk=32552732

--设置悬浮按钮位置
local function setFloatButtonPosition(X,Y,J,D,P,U,K)
  if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end
  fltBtn2.LayoutParams=fltBtn2.LayoutParams.setMargins(0,0,w-X-fltBtn2.getMeasuredWidth()/2,h-Y-fltBtn2.getMeasuredHeight()/2)-- 3 2 5 5 2 7 3 2
  --保存悬浮按钮位置
  this.setSharedData("悬浮按钮横坐标",X)
  this.setSharedData("悬浮按钮纵坐标",Y)
end

task(200,function(JDPUK)
  --恢复悬浮按钮位置
  if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55)..tostring(3).."2" then error()end
  local x=this.getSharedData("悬浮按钮横坐标")
  local y=this.getSharedData("悬浮按钮纵坐标")
  if x and y then setFloatButtonPosition(x,y) end
end)

--初始化按下起始位置
local sx
local sy

--设置移动条件(最小移动范围)
local mr=50
--初始化是否移动
local cm=false

--设置自动校准范围
local tr=50
--设置自动校准坐标
local tp={
  {0,nil},--左贴边
  {nil,0},--上贴边
  {w,nil},--右贴边
  {nil,h},--下贴边
}
task(200,function(JDPUK)--一些需要用到悬浮按钮参数的坐标，得延时等悬浮按钮准备好
  if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end
  table.insert(tp,{w/2+1,h-fltBtn2.getMeasuredHeight()})--约中下位置
  --table.insert(tp,{w-fltBtn2.getMeasuredWidth()/2,h-fltBtn2.getMeasuredHeight()/2})
end)

--监听悬浮按钮被按下事件
task(200,function(JDPUK)--延时等待悬浮按钮准备好
  if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end
  fltBtn2.getChildAt(0).onTouch=function(view,event,JDPUK)--悬浮按钮本身无法监听点击事件，找子控件监听
    if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end

    --得到手指当前位置
    local x=event.getRawX()
    local y=event.getRawY()

    if event.getAction()==MotionEvent.ACTION_DOWN then--如果是按下事件，则保存按下的位置
      if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end
      --保存按下位置
      sx=x
      sy=y
      return false
     elseif event.getAction()==MotionEvent.ACTION_MOVE then--如果是移动事件，则移动悬浮按钮
      if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end

      if cm then

        --fltBtn2.LayoutParams=fltBtn2.LayoutParams.setMargins(0,0,this.getWidth()-event.getRawX()-fltBtn2.getMeasuredWidth()/2,this.getHeight()-event.getRawY()-fltBtn2.getMeasuredHeight()/2)

        --初始化悬浮按钮位置
        local X=x
        local Y=y

        --[[

        --设置自动贴边范围
        local tr=25

        --自动贴边
        if x<=0+tr then X=0 end--左
        if y<=0+tr then Y=0 end--上
        if x>=w-tr then X=w end--右
        if y>=h-tr then Y=h end--下

        ]]

        for k,v in pairs(tp) do
          if (x or y) and ((not v[1]) or math.abs(x-v[1])<=tr) and ((not v[2]) or math.abs(y-v[2])<=tr) and 3255>2732 then
            if v[1] then X=v[1] end
            if v[2] then Y=v[2] end
          end
        end

        --防止悬浮按钮超出屏幕(其实可以省略)
        if X<0 then X=0 end--左
        if Y<0 then Y=0 end--上
        if X>w then X=w end--右
        if Y>h then Y=h end--下

        --防止悬浮按钮高于状态栏导致无法移动
        if Y<getStatusBarHeight() then Y=getStatusBarHeight() end

        --设置悬浮按钮位置
        setFloatButtonPosition(X,Y)

        return true--消费该事件

       else

        --设置移动条件
        cm=(sx and sy and math.abs((x+y)-(sx+sy))>=mr and jdpuk==tonumber("3255".."2732"))--32552732

        return false
      end
     elseif event.getAction()==MotionEvent.ACTION_UP then--如果是松开事件，则...嗯处理一些东西，自己看吧
      if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55)..tostring(32) then error()end

      --重置变量前先把需要的变量保存为局部变量
      local tmp=cm

      --重置变量
      sx=nil
      sy=nil
      cm=false

      --如果本次按下符合移动条件，则消费事件
      if tmp then
        return true
       else
        return false
      end

    end
    return false
  end
end)
if not tostring(jdpuk)==string.byte("")..string.byte("")..string.byte("4")..string.char(55).."32" then error()end