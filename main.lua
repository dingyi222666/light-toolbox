require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "res.strings"
import "mods.func"
import "mods.io"
import "com.中文辅助类.*"
import "mods.tabfunc"
import "mods.VIP"
import "com.dingyi.*"
import "bmob"
activity.setTheme(R.style.Theme_Design_Light)
--layout文件夹用于存放视图
--mods文件夹用于存放主操作
--image文件夹用于存放图片
--libs文件夹用于存放dex库文件
--主目录的lua文件为界面操作
--res文件夹为资源文件夹
--reslist为功能聚合文件夹
if 读取数据("主题")=="nil" then
  写入数据("主题","默认")
end

if 读取数据("更新")=="nil" then
  写入数据("更新","true")
  checkupdate()
 elseif 读取数据("更新")=="true" then
  checkupdate()
end



if 读取数据("通知")=="nil" then
  写入数据("通知","true")
  通知()
 elseif 读取数据("通知")=="true" then
  通知()
end

载入页面("layout.home")
import "mods.SomeOperation"
import "mods.collection"

使用协议()

pcall(function () activity.ActionBar.hide() end)


导航栏颜色(returntheme())
通知栏颜色(returntheme())

function onStop()--程序离开事件
  保存随手记内容()
end
function onDestroy()--程序退出事件
  保存随手记内容()
end
function onPause()--活动暂停事件，如锁屏
  保存随手记内容()
end

--主页收藏适配器

function onActivityResult(req, res, intent)
  if res == 10000 then
    刷新收藏()
    return
   elseif res== 10001 then
    检查vip()
    return
   elseif res== 10002 then
    提示("正在更新ui.....")
    activity.newActivity("main")
    activity.finish()
    return
  end
end

sidear.setDrawerListener(DrawerLayout.DrawerListener{
  onDrawerSlide=function(v,i)
    --可能报错,所以用pcall。
    pcall(function() menu.setRotation(i*300)end)
end})
page=0
function onKeyDown(key,event)
  if(key==4)then

    page=page+1
    --记录点击

    if(page==2)then
      --2为点击次数，可修改
      appinfo=this.getPackageManager().getApplicationInfo(this.getPackageName(),0)
      applabel=this.getPackageManager().getApplicationLabel(appinfo)
      退出确认=对话框()
      .设置标题("退出"..applabel.."")
      .设置消息("你确定要退出"..applabel.."吗？")
      退出按钮={
        [1]=function()退出确认.设置积极按钮("确定",function() activity.finish() end).设置中立按钮("取消")end,
      }
      math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 6)))
      退出按钮[math.random(1)]()

      圆角显示(退出确认)
      page=0
      --点击次数归零
      --此处可以添加其他操作
    end

    --还可添加其它操作，如点击后需进行密码验证再进行操作

  end
  return true
end

import "android.content.Context"
local imei=activity.getSystemService(Context.TELEPHONY_SERVICE).getDeviceId()

--print(imei)
checkupNote()
if not (读取数据("1")) then
  import "com.tencent.smtt.sdk.QbSdk"
  local tbsVersion = QbSdk.getTbsVersion(this);
  local TID = QbSdk.getTID();
  local qBVersion = QbSdk.getMiniQBVersion(this);
  if qBVersion==0 or qBVersion==nil or qBVersion=="nil" then
    local dl=AlertDialog.Builder(this)
    .setTitle("使用提示")
    .setMessage([[
系统配置文件初始化失败
解决办法:1.点击确定按钮进入网页
2.然后点击安装线上内核
3.等待安装成功后重启即可!
]]    )
    .setPositiveButton("确定",{onClick=function(v)
        打开网页("http://debugtbs.qq.com","视频","x5内核调试",nil,nil)
    end})
    .setNegativeButton("不再提示",{onClick=function()
        写入数据("1","2")
    end})
    .setNeutralButton("取消",nil)
    圆角显示(dl)
    --tbs内核初始化失败事件
  end
end

itemc={
  LinearLayout;
  gravity="center";
  layout_width="fill";
  layout_height="50dp";
  orientation="horizontal";

  {
    ImageView;
    layout_height="21dp";
    id="srcf";
    layout_width="21dp";
    layout_gravity="center";
    layout_marginLeft="80dp";
    ColorFilter="#FF757575";
    --找不到图标的老铁可以去酷安了解一下IconsLua+
  };
  {
    TextView;
    id="srct";
    layout_gravity="center|left";
    layout_height="25dp";
    layout_marginLeft="20dp";
    textColor=0xFF333333,
    layout_width='80%w';
    gravity="left|center",
    textSize="14sp",
  };


};


datas={}



aic={"image/settings.png","image/help.png","image/account_circle.png","image/box_upload.png","image/gamepad_variant.png","image/ic_share_app.png","image/leaf_96x96.png","image/exit_to_app.png"}
aw={"设置","使用帮助","高级用户","安装视频内核","游戏插件下载","分享","关于","退出"}


for nj=1,#aw do
  table.insert(datas,{srct=aw[nj],srcf=aic[nj]})
end
yuxuan_adp=LuaAdapter(activity,datas,itemc)

cehuait.Adapter=yuxuan_adp


cehuait.setOnItemClickListener(AdapterView.OnItemClickListener{

  onItemClick=function(id,v,zero,one)

    if v.Tag.srct.Text=="退出" then
      activity.finish()
     elseif v.Tag.srct.Text=="关于" then
      activity.newActivity("about")
     elseif v.Tag.srct.Text=="安装视频内核" then
      local dl=AlertDialog.Builder(this)
      .setTitle("使用提示")
      .setMessage([[
建议您安装x5视频内核！给你更好的视频体验！
如果现在不想安装可在稍后通过侧滑栏安装！
1.点击确定按钮进入网页
2.然后点击安装线上内核
3.等待安装成功后重启即可!
]]      )
      .setPositiveButton("确定",{onClick=function(v)
          打开网页("http://debugtbs.qq.com","视频","x5内核调试",nil,nil)
      end})
      .setNeutralButton("取消",nil)
      圆角显示(dl)
     elseif v.Tag.srct.Text=="游戏插件下载" then
      dl=AlertDialog.Builder(this)
      .setTitle("使用提示")
      .setMessage([[游戏插件，就是好用！]])
      .setPositiveButton("确定",{onClick=function(v)
          downname="轻工具箱-游戏插件"
          url="https://pan.cccyun.cc/down.php/eabb0432398c800754c3cb838a3c2b9d.apk"
          if 文件是否存在("/sdcard/Download/"..downname)
            安装app("/sdcard/Download/"..downname)
           else
            后台下载并安装(downname,url)
          end
      end})
      .setNeutralButton("取消",nil)
      圆角显示(dl)
     elseif v.Tag.srct.Text=="分享" then
      分享文字("嗨！我正使用一款超好用的软件【轻工具箱】，内置103种功能，赶快来下载吧，下载地址:https://www.coolapk.com/apk/com.Light.toolbox")
     elseif v.Tag.srct.Text=="设置" then
      activity.newActivity("settings")
     elseif v.Tag.srct.Text=="高级用户" then
      activity.newActivity("sign_in")
     elseif v.Tag.srct.Text=="使用帮助" then
      对话框()
      local dl=AlertDialog.Builder(this)
      .setTitle("使用帮助")
      .setMessage([[
 问：为什么要有高级用户功能?
 答：开发者免费提供本软件也是要钱的,不用担心。该功能获得的收入将全部用于软件的维护。

 问：如何下载影视功能的视频?
 答：全屏后点击“下载视频”按提示安装qq浏览器下载即可。

 问：为什么进入软件后没有显示任何东西?
 答：可以是你的网络不好，或别的原因，出现此问题建议重启软件或向开发者联系。

 问：为什么我们的软件能那么小?
 答：软件使用AppLua制作，部分功能依赖网页开发，所以才那么小。
 
 问：为什么软件加载速度很慢?
 答：软件部分功能依赖网页开发，加载速度取决于你的网络速度。

 问:QQ强制聊天为什么没用?
 答:去对方名片给他点个赞，然后进入自己的名片，进入我赞过的人，给他发消息，不过前提是对方必须开启允许附近的人临时会话。
 
 问：如何支持开发者?
 答：可以去关于页面捐赠，我们将会在首页增加捐赠列表(前提是有人捐赠)。
 
 问：为什么软件启动速度慢?
 答：软件使用x5内核,当然启动慢，但是不影响使用速度。
 
 问：为什么有的实用功能没有加载成功
 答：实用功能大都由网页打包制作成，一般这样的问题产生的原因有很多种。大家耐心等就ok
 
 问：软件一些功能、布件显示不正常
 答：整个软件都是根据我的手机屏幕尺寸定的（5英寸）不适配也没办法. 
 最后感谢大家的支持!]]      )
      .setPositiveButton("好的",nil)
      .setNeutralButton("取消",nil)

      圆角显示(dl)
    end
    yuxuan_adp.notifyDataSetChanged()--更新列表

end})

检查vip()

function onNewIntent(intent)
  if intent then
    local uri = tostring(intent.getDataString())
    if uri and tostring(uri):find("快捷方式") then                    
          运行代码(tabfunc[tostring(uri):match("快捷方式(.+)")])
      end
    end
end