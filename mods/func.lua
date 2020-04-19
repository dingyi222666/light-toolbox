require "import"
import "http"
import "cjson"
import "Pretend"
import "android.net.Uri"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.*"
import "android.animation.*"
import "android.content.res.ColorStateList"
import "res.strings"
import "android.animation.Animator$AnimatorListener"
import "mods.onclick"
import "android.animation.AnimatorSet"
import "mods.dzdd"
import "com.google.android.material.snackbar.Snackbar"
if activity.getThemeResId()~=R.style.Theme_Design_Light then
  activity.setTheme(R.style.Theme_Design_Light)
end
function 圆角显示(t)
  local function 控件圆角(控件,背景色,上角度,下角度)
    import "android.graphics.drawable.GradientDrawable"
    if not 上角度 then
      上角度=25
    end
    if not 下角度 then
      下角度=上角度
    end
    控件.setBackgroundDrawable(GradientDrawable()
    .setShape(GradientDrawable.RECTANGLE)
    .setColor(背景色)
    .setCornerRadii({上角度,上角度,上角度,上角度,下角度,下角度,下角度,下角度}))
  end
  local z=t.show()
  控件圆角(z.getWindow(),0xffffffff)
  return z
end
function checkRoot()
  import "java.lang.Runtime"
  if pcall(Runtime.getRuntime().exec,"su") then
    -- 没有错误
    return true
   else
    -- 一些错误
    return false
  end
end


function print(text)
  AlertDialog.Builder(this)
  .setTitle("出现错误!")
  .setMessage(text)
  .setPositiveButton("发送反馈",{onClick=function(v) 反馈(text,"bug") end})
  .setNeutralButton("取消",nil)
  .show()
end


function print (text)
  local dl=AlertDialog.Builder(this)
  .setTitle("出现错误!")
  .setMessage(text)
  .setPositiveButton("发送反馈",{onClick=function(v) 反馈(text,"bug") end})
  .setNeutralButton("取消",nil)
  圆角显示(dl)

end




function 反馈(text,b)
  if text~=nil
    local m=text
    local y=b
    local time=os.date("%Y-%m-%d %H:%M:%S")
    local api="https://sc.ftqq.com/SCU46047Tbf6baed0c2d8e1dc42913cf8af7b0dd55c8368e71ce82.send?text=轻工具箱——Bug反馈"
    local g="反馈内容："
    local l="联系方式："
    local s="时间："
    local k="&desp="
    local wx=api..k.."\n"..s.."\n"..time.."\n"..g..m.."\n"..l..y
    local sj=math.random(1000,9999)
    local wxs =api..sj..m
    Http.get(wx,nil,"utf8",nil,function(code,content,cookie,header)
      if(code==200 and content)then
        提示("谢谢您宝贵的反馈")
       else
        提示("与后台通信异常…尝试第二套方案"..code)
        Http.get(wxs,nil,"utf8",nil,function(code,content,cookie,header)
          if(code==200 and content)then
            提示("谢谢您宝贵的反馈")
          end
        end)
      end
    end)

  end

end


function 编辑框光标颜色(id,color)
  return
end


function 加载js(id,js)
  if js==nil then
   else
    id.evaluateJavascript(js,nil)--("javascript:".."(function() {"..js.."})()")
  end
end




function 缩放动画(view,startscale,endscale,time)
  local animatorSetsuofang = AnimatorSet()
  local scaleX=ObjectAnimator.ofFloat(view,"scaleX",{startscale,endscale})
  local scaleY=ObjectAnimator.ofFloat(view,"scaleY",{startscale,endscale})
  animatorSetsuofang.setDuration(time)
  animatorSetsuofang.setInterpolator(DecelerateInterpolator())
  animatorSetsuofang.play(scaleX).with(scaleY);
  animatorSetsuofang.start()
end


点击监听={
  onTouch=function (v,e)
    if e.action==0 then
      缩放动画(v,1,0.95,250)
     else
      缩放动画(v,0.90,1,250)
    end
end}

function 转波纹色(颜色)
  ripple = activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
  ripples = activity.obtainStyledAttributes({android.R.attr.selectableItemBackground}).getResourceId(0,0)
  return (activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{颜色})))
end

function 波纹(id,text)
  --设置id,波纹颜色
  if id then
    id.BackgroundDrawable=转波纹色(text);
  end
end


function 运行脚本(path)
  dofile(path)
end

function 提示(内容,z)
  --[[  shamrock={
    LinearLayout;
    id="toastb";
    layout_width="100%w";
    {
      TextView;
      padding="8dp";
      BackgroundColor=returntheme();
      textSize="15sp";
      TextColor="#ffffffff";
      layout_width="100%w";
      layout_height="40dp";
      gravity="center";
      text="提示出错";
      id="text_ts";
      ellipsize='end';
    };
  };
  local toast=Toast.makeText(activity,"内容",Toast.LENGTH_SHORT).setView(loadlayout(shamrock))
  --LENGTH_SHORT     2s
  --LENGTH_LONG      3.5s
  toast.setGravity(Gravity.BOTTOM,0, 0)
  --Gravity.BOTTOM   底部
  --Gravity.CENTER   中部
  --Gravity.TOP      顶部
  text_ts.Text=tostring(内容)
  toast.show()
  ]]
  if (activity.getThemeResId()~=R.style.Theme_Design_Light) then
    activity.setTheme(R.style.Theme_Design_Light)
  end
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION)
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION)--//隐藏虚拟按键栏
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_IMMERSIVE)-- //防止点击屏幕时,隐藏虚拟按键栏又弹了出来
  local snackbar=Snackbar.make(activity.getWindow().getDecorView(),内容, 3300).show();
  local view=snackbar.getView();--/
  if(view~=null)then
    view.setBackgroundColor(returntheme());
  end
  task(3000,function()
    activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_VISIBLE);
  end)
end
function createShortcut(m)
  import "android.view.animation.Animation$AnimationListener"
  import "android.graphics.BitmapFactory"
  import "android.content.Context"
  import "android.content.Intent"
  import "android.app.NotificationManager"
  import "android.widget.LinearLayout"
  import "android.content.IntentFilter"
  import "android.net.Uri"
  import "android.content.ComponentName"
  import "android.content.IntentSender"
  import "android.content.ServiceConnection"
  import "android.content.pm.ShortcutInfo"
  import "android.content.pm.ShortcutManager"
  import "android.graphics.drawable.Icon"
  import "android.content.ComponentName"
  local intent = Intent("android.intent.action.MAIN");
  intent.addCategory("android.intent.category.DEFAULT");
  intent.setComponent(ComponentName(activity.getPackageName(),"com.androlua.Main"));
  intent.setData(Uri.parse("快捷方式"..tostring(m)))
  if (Build.VERSION.SDK_INT >= 22) then
    intent.addFlags(524288);
    intent.addFlags(0x08000000);
  end
  if (Build.VERSION.SDK_INT >= 26) then
    xpcall(function()
      activity.getSystemService("shortcut").requestPinShortcut(ShortcutInfo.Builder(activity, m).setIcon(Icon.createWithResource(activity,R.drawable.icon)).setShortLabel(m).setIntent(intent).build(),nil);
      end,function(e)
      提示( "添加快捷方式出错")
    end)
   else
    local intent2 = Intent("com.android.launcher.action.INSTALL_SHORTCUT");
    local fromContext = Intent.ShortcutIconResource.fromContext(activity, 0x7f010000);
    intent2.putExtra("android.intent.extra.shortcut.NAME", m);
    intent2.putExtra("android.intent.extra.shortcut.INTENT", intent);
    intent2.putExtra("duplicate", 0);
    intent2.putExtra("android.intent.extra.shortcut.ICON_RESOURCE", fromContext);
    intent2.putExtra("android.intent.extra.shortcut.ICON", BitmapFactory.decodeResource(activity.getApplicationContext().getResources(),R.drawable.icon));
    activity.sendBroadcast(intent2);
    提示("已添加快捷方式")
  end
end






function 是否存在文件(path)
  if File(path).exists() then
    return true
   else
    return false
  end
end


function 是否存在文件夹(path)
  if File(path).isDirectory()then
    return true
   else
    return false
  end
end


function 创建文件(path)
  io.open(path,'w')
end

function 不更新写入文件 (path,text)
  io.open(path,"a+"):write(text):close()
end

function 追加写入文件 (path,text)
  io.open(path,"w+"):write(text):close()
end

function 读取文件(path)
  return io.open(path):read("*a")
end

function 删除文件(path)
  import "java.io.File"--导入File类
  File(path).delete()
end

function 清空文件(path)
  删除文件(path)
  创建文件(path)
end

function 获取随手记内容()
  return 读取文件(随手记文件路径)
end

function 保存随手记内容()
  追加写入文件(随手记文件路径,Chronicle.Text)
end

function 运行代码(text)
  if text~=nil then
    loadstring(text)()
   else
    提示("点击了错误的项目")
  end
end


function 收藏项目(text)
  不更新写入文件(收藏文件路径,text.."\n")
end

function 清空收藏()
  清空文件(收藏文件路径)
end


function 文件行数(path)
  local mytab={}
  for c in io.lines(path) do
    mytab[#mytab+1]=c
  end
  return #mytab
end

function 屏蔽元素(id,tab)
  if tab==nil then
   else
    for i=1,#tab do
      if tab[i]:find("@ID") then
        jsclass=tab[i]:match("ID<(.+)>")
        加载js(id,[[document.getElementById(']]..jsclass..[[').style.display='none';]])
       else
        加载js(id,[[document.getElementsByClassName(']]..tab[i]..[[')[0].style.display='none';]])
      end
    end
  end
end

function 打开网页(website,mode,title,js,edit_table)
  if mode=="视频" then
    activity.newActivity("x5video",{website,title,js,edit_table,mode})--跳转页面
   else
    activity.newActivity("WebView",{website,title,js,edit_table,mode})--跳转页面
  end
end



function xdc(url,path)
  require "import"
  import "java.net.URL"
  local ur =URL(url)
  import "java.io.File"
  file =File(path);
  con = ur.openConnection();
  co = con.getContentLength();
  is = con.getInputStream();
  bs = byte[99999]
  local len,read=0,0
  import "java.io.FileOutputStream"
  wj= FileOutputStream(path);
  len = is.read(bs)
  while len~=-1 do
    wj.write(bs, 0, len);
    read=read+len
    
    len = is.read(bs)
  end
  wj.close();
  is.close();
  pcall(call,"dstop",co)
end
function download(url,path)
  thread(xdc,url,path)
end




function 上滑动画(id)
  import "android.view.animation.LayoutAnimationController"
  import "android.view.animation.Animation"
  import "android.view.animation.AlphaAnimation"
  import "android.view.animation.TranslateAnimation"
  import "android.view.animation.AnimationSet"
  --定义动画变量,使用AnimationSet类，使该动画可加载多种动画
  animationSet = AnimationSet(true)
  --设置布局动画，布局动画的意思是布局里面的控件执行动画，而非单个控件动画，参数:动画名，延迟
  layoutAnimationController=LayoutAnimationController(animationSet,0.2);
  --设置动画类型，顺序   反序   随机
  layoutAnimationController.setOrder(LayoutAnimationController.ORDER_NORMAL); --   ORDER_     NORMAL     REVERSE     RANDOM
  --id控件加载动画
  id.setLayoutAnimation(layoutAnimationController);

  ganbei_dh2=TranslateAnimation(0,0,activity.height/(5/3),0)
  ganbei_dh2.setDuration(800);
  ganbei_dh2.setStartOffset(0)
  --动画执行次数，-1   Animation.INFINITE  表示不停止
  ganbei_dh2.setRepeatCount(0.5)
  --动画执行完后是否停留在执行完的状态
  -- yuxuan_dh2.setFillAfter(true)
  --添加动画
  animationSet.addAnimation(ganbei_dh2);
end

function 下滑动画(id)
  ganbei_dh3=TranslateAnimation(0,0,0,activity.height/(5/3))
  ganbei_dh3.setDuration(800);
  ganbei_dh3.setStartOffset(0)
  --动画执行次数，-1   Animation.INFINITE  表示不停止
  ganbei_dh3.setRepeatCount(0.5)
  --动画执行完后是否停留在执行完的状态
  ganbei_dh3.setFillAfter(true)
  id.startAnimation(ganbei_dh3)--设置
  import "android.view.animation.Animation$AnimationListener"
  ganbei_dh3.setAnimationListener(AnimationListener{
    onAnimationEnd=function()
      dialog1.dismiss()
    end,
  })
end


function CircleButton(view,InsideColor,radiu)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,0,0,0,0});
  view.setBackgroundDrawable(drawable)
end

function DialogButtonFilter(dialog,button,WidgetColor)
  if Build.VERSION.SDK_INT >= 21 then
    import "android.graphics.PorterDuffColorFilter"
    import "android.graphics.PorterDuff"
    if button==1 then
      dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(WidgetColor)
     elseif button==2 then
      dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(WidgetColor)
     elseif button==3 then
      dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(WidgetColor)
     elseif button==0 then
      dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(WidgetColor)
      dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(WidgetColor)
      dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(WidgetColor)
    end
  end
end


function 下载文件(url,path,mode)

  download(url,path)
  function ding(a,b)--已下载，总长度(byte)
    if mode=="普通" then
      提示("正在下载……"..(a/b*100).."%")
    end
  end

  function dstop(c)--总长度
    MD提示("下载完成，保存在"..path,"#FF12B8F6","#ffffffff","0","15")
  end
end
function 创建文件夹(path)
  File(path).mkdir()
end



function QQ强制聊天(h)
  url="mqqwpa://im/chat?chat_type=wpa&uin="..h
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function 圆形扩散(v,sx,ex,sy,ey,time)
  ViewAnimationUtils.createCircularReveal(v,sx,ex,sy,ey)
  .setDuration(time)
  .start()
end



function 浏览器打开网页(url)

  import "android.content.Intent"
  import "android.net.Uri"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end

function 原波纹(id,colour)
  import 'android.content.res.ColorStateList'
  id.setBackground(activity.Resources.getDrawable(activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless})
  .getResourceId(0,0)).setColor(ColorStateList(int[0].class{int{}},int{colour}))
  .setColor(ColorStateList(int[0].class{int{}},int{colour})))
end

ztl=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)


function 转波纹色啊(colour)
  import 'android.content.res.ColorStateList'
  return (activity.Resources.getDrawable(activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless})
  .getResourceId(0,0)).setColor(ColorStateList(int[0].class{int{}},int{colour}))
  .setColor(ColorStateList(int[0].class{int{}},int{colour})))
end

function 拖动条颜色(id,颜色)
  id.ProgressDrawable.setColorFilter(PorterDuffColorFilter(颜色,PorterDuff.Mode.SRC_ATOP))
  --修改SeekBar滑块颜色
  id.Thumb.setColorFilter(PorterDuffColorFilter(颜色,PorterDuff.Mode.SRC_ATOP))
end


function 判断代码执行(代码)
  import "java.lang.Runtime"
  if pcall(Runtime.getRuntime().exec,代码) then
    提示("执行成功")
    return true
   else
    提示("执行失败")
    return false
  end
end

function dp2px(dpValue)
  local scale = this.getResources().getDisplayMetrics().density
  return (dpValue * scale)
end

function 执行Shell(text)
  os.execute(text)
end


function tobase64(text)
  local base64Text=Base64.encodeToString(String(text).getBytes(),Base64.DEFAULT)
  return base64Text
end
function qqShare(分享ID,跳转链接,预览图链接,图片链接,标题,描述)
  local shareId=分享ID
  local jumpUrl=tobase64(跳转链接)
  local previewImgUrl=tobase64(预览图链接)
  local imgUrl=tobase64(图片链接)
  local title=tobase64(标题)
  local description=tobase64(描述)
  local mqqapi="mqqapi://share/to_fri?file_type=news&src_type=web&version=1&share_id="..shareId.."&url="..jumpUrl.."&previewimageUrl="..previewImgUrl.."&image_url="..imgUrl.."&title="..title.."&description="..description.."&callback_type=scheme&thirdAppDsplayName=UVE&app_name=UVE&cflag=0&shareType=0"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(mqqapi)))
end


function 透明动画(id,时间,开始透明度,结束透明度)
  id.startAnimation(AlphaAnimation(开始透明度,结束透明度).setDuration(时间))
end

function 弹出输入法()
  collectgarbage("collect")
end


function MUKPopu(t)
  local tab={}

  pop=PopupWindow(activity)
  --PopupWindow加载布局
  pop.setContentView(loadlayout({
    LinearLayout;
    {
      CardView;
      CardElevation="6dp";
      CardBackgroundColor=0xffffffff;
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_margin="8dp";
      {
       ListView;
        layout_height="-1";
        layout_width="-1";
        dividerHeight="0",
        id="poplist";
        OnItemClickListener={
          onItemClick=function(i,v,p,l)
            t.list[l].onClick(v.Tag.popadp_text.Text)
            pop.dismiss()
          end,
        },
        adapter=LuaAdapter(activity,{
          LinearLayout;
          layout_width="-1";
          layout_height="48dp";
          id="popadp_textp",
          {
            TextView;
            id="popadp_text";
            textColor=textc;
            layout_width="-1";
            layout_height="-1";
            textSize="14sp";
            gravity="left|center";
            paddingLeft="16dp";
            
          };
        }),
      };
    };
  },tab))
  pop.setWidth(dp2px(192))
  pop.setHeight(-2)

  pop.setOutsideTouchable(true)
  pop.setBackgroundDrawable(nil)

  pop.onDismiss=function()
    if t.消失事件 then
      t.消失事件()
    end
   
  end
  tab.pop=pop
  for k,v in ipairs(t.list) do
    tab.poplist.adapter.add{popadp_text=v.text}
  end

  return tab
end

function 后台下载并安装(name,url)
  import "dzdd"
  下载管理=dzdd(url)
  下载管理:创建下载("Download",name,function(id)
    下载id=id
  end)
  下载管理:下载信息(下载id,function(已下载,总大小,状态,函数)
    函数状态=函数

    if 状态==8 then
      activity.installApk("/sdcard/Download/"..name)
      if 函数状态 and 函数状态.isRun() then
        函数状态.stop()
      end
    end
  end)
end

function updatedown(url,cqode,codeq)
  local dl=AlertDialog.Builder(this)
  .setTitle("有新版本!")
  .setMessage("\n"..cqode)
  .setPositiveButton("马上下载安装",{onClick=function(v)
      downname="轻工具箱"..tostring(codeq)..".apk"
      if 文件是否存在("/sdcard/Download/"..downname)
        安装app("/sdcard/Download/"..downname)
       else
        后台下载并安装(downname,url)
      end
  end})

  .setNeutralButton("暂不更新",{onClick=function()
      提示("更新才能有更好的体验呢")
  end})
  圆角显示(dl)
end

function checkupdate()
  Http.get("http://djt6666.host3v.vip/",function(code,content)
    if code==200 then
      版本=content:match("【版本】(.-)【版本】")--(内部版本哦)
      文本=content:match("【内容】(.-)【内容】")
      直链=content:match("【蓝奏云】(.-)【蓝奏云】")
      版本号=content:match("【版本号】(.-)【版本号】")
      if tonumber(版本) > tonumber(this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9).versionCode) then
        updatedown(直链,文本,版本号)
       elseif tonumber(版本) < tonumber(this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9).versionCode) then
        提示("欢迎使用测试版")
      end
     else

    end

  end)

end
function addNote(p1,p2)
  Note.setVisibility(0)
  Note.onClick=p2
  note_text.setText(p1)
end
function checkupNote()
  Http.get("http://djt6666.host3v.vip/noteice.html",function(code,content)
    if code==200 then
      Notetable={}
      Notetable=load("return "..content:match("【内容】(.-)【内容】"))()
      if Notetable.开启公告==true then
        text=Notetable.text

        addNote(text,function ()
          load(tostring(Notetable.onclick))()
        end )
      end

    end

  end)

end


function 获得版本信息()

  Http.get("http://djt6666.host3v.vip/",function(code,content)
    if code==200 then
      版本=content:match("【版本】(.-)【版本】")--(内部版本哦)
      文本=content:match("【内容】(.-)【内容】")
      直链=content:match("【蓝奏云】(.-)【蓝奏云】")
      版本号=content:match("【版本号】(.-)【版本号】")
      if tonumber(版本) > tonumber(this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9).versionCode) then
        version_note.Text="有新版本可用!"
       elseif tonumber(版本) == tonumber(this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9).versionCode) then
        version_note.Text="已是最新版本"
       elseif tonumber(版本) < tonumber(this.getPackageManager().getPackageInfo(this.getPackageName(),((32552732/2/2-8183)/10000-6-231)/9).versionCode) then
        version_note.Text="正在使用不为人知的测试版"
      end
     else
      version_note.Text="更新出错 "..code
    end
  end)
end


function 获得更新日志()
  Http.get("http://djt6666.host3v.vip/",function(code,content)
    if code==200 then
      版本=content:match("【版本】(.-)【版本】")--(内部版本哦)
      文本=content:match("【内容】(.-)【内容】")
      直链=content:match("【蓝奏云】(.-)【蓝奏云】")
      版本号=content:match("【版本号】(.-)【版本号】")
      dialog1.setMessage(文本)
     else
      dialog1.setMessage( "更新出错 "..code)
    end
  end)
end

function 酷安打开app(packname)
  if pcall(function() activity.getPackageManager().getPackageInfo("com.coolapk.market",0) end) then
    提示("正在跳转到酷安")
    intent=Intent("android.intent.action.VIEW")
    intent.setPackage("com.coolapk.market")
    intent.setData(Uri.parse("market://details?id="..packname))
    intent.addFlags(intent.FLAG_ACTIVITY_NEW_TASK)
    this.startActivity(intent)
   else
    提示("请下载酷安APP")
  end
end

function 系统下载(url,em)
  --导入包
  import "android.content.Context"
  import "android.net.Uri"

  downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
  url=Uri.parse(url);
  request=DownloadManager.Request(url);
  request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
  request.setDestinationInExternalPublicDir("Download",em);
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
  downloadManager.enqueue(request);
end
function 卡片细节(边框厚度,边框颜色,背景颜色,圆角大小)
  import "android.graphics.drawable.GradientDrawable"
  drawable=GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setStroke(边框厚度,tonumber(边框颜色))--边框厚度和背景颜色
  drawable.setColor(tonumber(背景颜色))--背景颜色
  drawable.setCornerRadius(圆角大小)--圆角
  return drawable
end


function 写入数据(tab1,tab2)
  preferences=this.getSharedPreferences("数据啊",0);
  editor=preferences.edit();
  editor.putString(tab1,tab2);
  editor.commit();
end

function 读取数据(tab1)
  preferences=activity.getSharedPreferences("数据啊",0);
  return preferences.getString(tab1,"nil");
end

function returntheme()
  th_content=读取数据("主题")
  if th_content==theme_list[1] then
    return theme_main[1]
   elseif th_content==theme_list[2] then
    return theme_main[2]
   elseif th_content==theme_list[3] then
    return theme_main[3]
   elseif th_content==theme_list[4] then
    return theme_main[4]
   elseif th_content==theme_list[5] then
    return theme_main[5]
   elseif th_content==theme_list[6] then
    return theme_main[6]
  end

end


function checkTheme()
  th_content=读取数据("主题")
  if th_content==theme_list[1] then
    主题色=theme_main[1]
   elseif th_content==theme_list[2] then
    主题色=theme_main[2]
   elseif th_content==theme_list[3] then
    主题色=theme_main[3]
   elseif th_content==theme_list[4] then
    主题色=theme_main[4]
   elseif th_content==theme_list[5] then
    主题色=theme_main[5]
   elseif th_content==theme_list[6] then
    主题色=theme_main[6]
  end
  按钮文字色=主题色
end

function 下拉对话框(t)
  import "mods.MyEditText"
  import "android.content.res.ColorStateList"
  import "android.graphics.drawable.GradientDrawable"
  import "com.google.android.material.bottomsheet.BottomSheetDialog"
  import "com.google.android.material.bottomsheet.BottomSheetBehavior"

  local function CircleButton(view,InsideColor,radiu)
    import "android.graphics.drawable.GradientDrawable"
    drawable = GradientDrawable()
    drawable.setShape(GradientDrawable.RECTANGLE)
    drawable.setColor(InsideColor)
    drawable.setCornerRadii({radiu,radiu,radiu,radiu,0,0,0,0});
    view.setBackgroundDrawable(drawable)
  end
  if ll then
    ll.parent.parent.removeView(ll.parent)
  end
  --导入自定义布局

  local dialog_view=loadlayout({
    LinearLayout,
    layout_width="fill",
    layout_height="40%h",--Dialog最终展开高度
    orientation="vertical",
    background="#FFFFFFFF",
    id="ll",
    {
      LinearLayout,--线性布局
      orientation="vertical",--布局方向
      layout_width="fill",--布局宽度
      layout_height="fill",--布局高度
      background="#FFFFFFFF",
      layout_margin="10dp",--布局边距
      {
        CardView,--卡片框控件
        layout_width="70dp",--布局宽度
        layout_height="8dp",--布局高度
        layout_margin="8dp",--布局边距
        cardElevation="0dp",--卡片提升
        cardBackgroundColor="#25000000",--卡片背景色
        radius="8dp",--圆角半径
        layout_gravity="top|center",--重力居顶｜置中
      },--卡片框控件 结束
      {
        TextView,--文本框控件
        text=t.标题 or "",--文本内容
        layout_marginLeft="16dp",
        layout_marginTop="5dp",--布局顶距
        layout_margin="15dp",--布局边距
        layout_gravity="left|center",--重力居左｜置中
        textSize="18sp",--文本大小
        textColor="#ff000000",--文本颜色
      },
      {
        MyEditText
        {
          id=t.输入框id or nil;
          Hint=t.输入框hint or "",
          radius=10;
          textSize="15dp";
          HintTextColor=returntheme();
        },
        layout_margin="8dp",--布局边距
        layout_marginTop="20dp",--布局顶距
        layout_width="fill",--布局宽度
        layout_height="60dp",--布局高度
        layout_width="fill";
      },

      {
        LinearLayout,--线性布局
        orientation="horizontal",--水平方向
        layout_width="fill",--布局宽度
        layout_height="-2",--布局高度
        layout_marginTop="15dp",--布局顶距
        {
          CardView,--卡片框控件
          layout_marginTop="2dp",
          layout_marginBottom="2dp",
          layout_width="-2",--布局宽度
          layout_height="-2",--布局高度
          layout_margin="16dp",--布局边距
          Visibility=t.按钮1显示 or 0,
          cardBackgroundColor=returntheme(),--卡片背景色
          radius="6dp",--圆角半径
          {
            TextView,--文本框控件
            text=t.按钮1文字 or "",--文本内容
            layout_width="-2",--布局宽度
            layout_height="-2",--布局高度
            onClick=function()
              if t.按钮1点击事件 then
                t.按钮1点击事件()
              end
            end,
            padding="7dp",
            paddingLeft="24dp",
            paddingRight="24dp",
            paddingTop="8dp",
            paddingBottom="8dp",
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0xffffffff}));
            gravity="center",
            textSize="15sp",--文本大小
            textColor="#ffffffff",--文本颜色
          },
        },--卡片框控件 结束
        {
          View,
          layout_width="-2",
          layout_weight="1",--重力分配
        },
        {
          CardView,--卡片框控件
          layout_width="-2",--布局宽度
          layout_height="-2",--布局高度
          layout_margin="16dp",--布局边距
          layout_marginTop="2dp",
          layout_marginBottom="2dp",
          Visibility=t.按钮2显示 or 0,
          cardBackgroundColor=returntheme(),--卡片背景色
          radius="6dp",--圆角半径
          {
            TextView,--文本框控件
            text=t.按钮2文字 or "",--文本内容
            onClick=function()
              if t.按钮2点击事件 then
                t.按钮2点击事件()
              end
            end,
            padding="7dp",
            paddingLeft="24dp",
            paddingRight="24dp",
            paddingTop="8dp",
            paddingBottom="8dp",
            layout_width="-2",--布局宽度
            layout_height="-2",--布局高度
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0xffffffff}));
            gravity="center",
            textSize="15sp",--文本大小
            textColor="#ffffffff",--文本颜色
          },
        },--卡片框控件 结束
      },--线性布局 结束
    },--线性布局 结束
  })

  local mBottomSheetDialog = BottomSheetDialog(activity);
  mBottomSheetDialog.setContentView(dialog_view).getWindow().setDimAmount(0.5);

  --设置点击返回键与外边阴影部分与下滑Dialog不消失
  --mBottomSheetDialog.setCancelable(false);

  --设置点击Dialog外部阴影部分不消失
  --  mBottomSheetDialog.setCanceledOnTouchOutside(false);

  --获得父窗体,并设置为透明
  local parent = dialog_view.getParent();
  parent.setBackgroundResource(android.R.color.transparent);

  --创建BottomSheetBehavior对象
  local mBehavior = BottomSheetBehavior.from(parent);
  --设置Dialog默认弹出高度为屏幕的0.5倍
  mBehavior.setPeekHeight(0.4 * activity.getHeight());

  --设置禁止拖拽下滑
  --mBehavior.setHideable(false)

  --解决弹出Dialog后状态栏会变黑
  if Build.VERSION.SDK_INT >= 21 then
    mBottomSheetDialog.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
  end

  --显示Dialog
  mBottomSheetDialog.show();

  --设置用户拖拽Dialog时状态
  CircleButton(ll,0xFFFFFFFF,20)


  --The View with the BottomSheetBehavior
  mBehavior.setBottomSheetCallback(BottomSheetBehavior.BottomSheetCallback{
    onSlide=function(view,newState)
      --状态的改变回调

    end;
    onStateChanged=function(view,slideOffset)
      --拖拽中的回调
      if (slideOffset== BottomSheetBehavior.STATE_HIDDEN) then
        mBottomSheetDialog.dismiss();
        mBehavior.setState(BottomSheetBehavior.STATE_COLLAPSED);
      end
    end;
  });

    _G[t.对话框id]=mBottomSheetDialog
end

function 通知()
  Http.get("http://djt6666.host3v.vip/ad.html",function(code,content)
    if code==200 then
      import "android.content.Context"
      import "android.content.Intent"
      import "android.app.PendingIntent"
      import "android.app.Notification"
      import "android.graphics.drawable.Drawable"
      import "android.net.Uri"
      url=content:match("【链接】(.-)【链接】")
      bigtext=content:match("【大通知】(.-)【大通知】")
      smalltext=content:match("【小通知】(.-)【小通知】")
      mBuilder = Notification.Builder(this);
      mIntent = Intent(Intent.ACTION_VIEW, Uri.parse(url));
      pendingIntent = PendingIntent.getActivity(activity.getApplicationContext(), 0, mIntent, 0);
      mBuilder.setContentIntent(pendingIntent);
      mBuilder.setSmallIcon(R.drawable.icon);
      mBuilder.setLargeIcon(BitmapFactory.decodeResource(activity.getApplicationContext().getResources(),R.drawable.icon));
      mBuilder.setAutoCancel(true);
      mBuilder.setContentTitle(bigtext);
      mBuilder.setContentText(smalltext)--小标
      --//设置点击跳转
      hangIntent = Intent();
      hangIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      -- hangIntent.setClass(Context, activity.getApplicationContext());
      --//如果描述的PendingIntent已经存在，则在产生新的Intent之前会先取消掉当前的
      hangPendingIntent = PendingIntent.getActivity(activity.getApplicationContext(), 0, hangIntent, PendingIntent.FLAG_CANCEL_CURRENT);
      mBuilder.setFullScreenIntent(hangPendingIntent, true);

      -- 创建NotificationManager的对象
      --NotificationManager =activity.getSystemService(Context.NOTIFICATION_SERVICE)
      NotificationManager = activity.getSystemService(Context.NOTIFICATION_SERVICE);

      -- NotificationManager = (NotificationManager) Context.getSystemService(context.NOTIFICATION_SERVICE);
      NotificationManager.notify(3, mBuilder.build());

    end
  end)


end

function 检测是否安装软件(package)
  if pcall(function() activity.getPackageManager().getPackageInfo(package,0) end) then
    return true
   else
    return false
  end
end
function 读取主题()
  if 读取文件(主题文件路径) then
    return tonumber(读取文件(主题文件路径))
   else
    return 0xFF12B8F6
  end
end
function 打开腾讯QQ()
  local tabpackage={
    "com.tencent.mobileqq",
    "com.tencent.tim",
    "com.tencent.minihd.qq",
    "com.tencent.mobileqqi",
    "com.tencent.qqlite",
    "com.qzone",
  }

  local iftab={}
  for k,v in pairs(tabpackage)
    if 检测是否安装软件(tostring(v)) then
      打开app(tostring(v))
      Toast.makeText(this,"已经复制了代码，快到QQ空间里去装逼吧",2)
      table.insert(iftab,"t")
      break
    end
  end

  if iftab[1]~="t" then
    Toast.makeText(this,"您没有安装QQ系列",2)
    table.insert(iftab,"t")
  end
  iftab=nil
  name2to=nil
  tabpackage=nil
  collectgarbage("collect")
end