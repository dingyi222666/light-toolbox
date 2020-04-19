require "import"
import "mods.func"
import "Pretend"
--[[
原作者 fa二群 小白
原作者QQ 2926037170
由 Ayaka_ago 修改
]]

function 控件圆角(控件,背景色,上角度,下角度)
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

function captureLongBitmap(view)
  bitmap=Bitmap.createBitmap(view.width,view.height,Bitmap.Config.RGB_565)--bitmap的创建与配置
  canvas=Canvas(bitmap)
  view.draw(canvas)--把view内容绘制到画布中
  return bitmap
end




function savePicture(fileName,bitmap,msg,shouldPrintIfFinish)
  if bitmap and fileName then
    import "java.io.FileOutputStream"
    import "java.io.File"
    import "android.graphics.Bitmap"
    if pcall(function ()
        out = FileOutputStream(File(tostring(fileName)))
        bitmap.compress(Bitmap.CompressFormat.PNG,90, out)
        out.flush()
        out.close()
      end) then
      if shouldPrintIfFinish then
        提示("保存成功，保存在了\n"..fileName,nil,nil,长toast)
      end
      if msg then
        提示(tostring(msg))
      end
      return true
     else
      if shouldPrintIfFinish then
        提示 ("保存失败")
      end
      return false
    end
   else
    if shouldPrintIfFinish then
      提示 ("保存失败, 没有传入图片")
    end
    return false
  end
end

import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "java.io.File"

molirobotname="/data/data/"..activity.getPackageName().."/molirobotname.txt"
File(molirobotname).createNewFile() --创建保存密码的文件
茉莉机器人名字=io.open(molirobotname):read("*a") --读取文件

moliyourname="/data/data/"..activity.getPackageName().."/moliyourname.txt"
File(moliyourname).createNewFile() --创建保存密码的文件
茉莉主人名字=io.open(moliyourname):read("*a") --读取文件

function getRobotName()
  if #茉莉机器人名字<1 then
    return "dingyi"
   else
    return 茉莉机器人名字
  end
end



function setDialogButtonColor(id,button,color)
  if Build.VERSION.SDK_INT >= 22 then
    import "android.graphics.PorterDuffColorFilter"
    import "android.graphics.PorterDuff"
    if button==1 then
      id.getButton(id.BUTTON_POSITIVE).setTextColor(color)
     elseif button==2 then
      id.getButton(id.BUTTON_NEGATIVE).setTextColor(color)
     elseif button==3 then
      id.getButton(id.BUTTON_NEUTRAL).setTextColor(color)
     elseif button==0 then
      id.getButton(id.BUTTON_NEUTRAL).setTextColor(color)
      id.getButton(id.BUTTON_NEGATIVE).setTextColor(color)
      id.getButton(id.BUTTON_POSITIVE).setTextColor(color)
    end
   else
    return false
  end
end

function 控件圆角(控件,背景色,上角度,下角度)
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

--自定义toast弹出消息 by ayaka_ago
import "android.graphics.drawable.GradientDrawable"

--import "android.view.inputmethod.InputMethodManager"

--imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
local etc={title="标题",content="内容",number1="签号",number2="签号",haohua="好坏",qianyu="签语",shiyi="诗意解签",jieqian="解签",type="类型",zhushi="注释",jieshuo="解说",jieguo="结果",hunyin="婚姻",jiaoyi="交易",baihua="白话浅析"}
local function getcn(t) return etc[t] or t end

function 发送信息(text)
  text=tostring(text)
  if #text>0 then
    lt.addView(loadlayout({
      LinearLayout,
      Gravity="center|right",
      layout_width="-1",
      layout_height="-1",
      {
        TextView,
        layout_width="wrap",
        layout_height="-1",
        Gravity="center|right",
        textColor=returntheme(),
        textSize="18sp",
        id="usersendmsg",
        layout_marginLeft="6%w",
        layout_marginRight="6%w",
        onClick=function(v)
          local p=PopupMenu(this,v)
          local m=p.Menu
          m.add("复制消息内容").onMenuItemClick=function(a)
            写入剪贴板(v.text)
            提示 ("已复制消息内容")
          end
          m.add("删除此条消息").onMenuItemClick=function(a)
            local dl=AlertDialog.Builder(this)
            .setMessage("确定删除此条消息？")
            . setPositiveButton ("取消", function ()
            end)
            .setNeutralButton("删除", function ()
              v.Parent.removeView(v)
              提示 ("已删除此条消息")
            end)
            local dl=dl.show()
            控件圆角(dl.getWindow(),0xffffffff)
            setDialogButtonColor(dl,0,returntheme())
          end
          p.show()
        end,
        elevation="2dp",
        padding="3%w",
        onTouchListener=点击监听,
        layout_marginTop="2%w",
        layout_marginBottom="2%w",
        text=string.gsub(text,"cqname"," "..茉莉机器人名字.." "),
      },
    }))
    控件圆角(usersendmsg,0xffffffff,10)
    robotname.text=茉莉机器人名字.." 正在输入..."
    task(500, function ()
      scrollView.fullScroll(ScrollView.FOCUS_DOWN)
    end)
    dataurl="http://i.itpk.cn/api.php?question="..text
    Http.get(dataurl,nil,"utf8",nil,function(code,content)
      robotname.text=茉莉机器人名字
      if code~=200 then
        content="亲，没有网络哦"
       else
        content=content:gsub("%[cqname%]",茉莉机器人名字)
        if 茉莉主人名字 and #茉莉主人名字>0 then
          content=content:gsub("%[name%]",茉莉主人名字)
         else
          content=content:gsub("%[name%]","你")
        end
        content=content:gsub("%[father%]","itpk")
        content=content:gsub("%[mother%]","itpk")
        content=content:gsub("\r","")
        content=content:gsub("\n","")
        content=content:gsub("\f","")
        content=content:gsub("\t","")
        content=content:gsub("NULL"," ")
        local f,e=pcall(function()
          return cjson.decode("{"..(content:match("{(.+)") or ""))
        end)
        if f then
          local ct=""
          for k,v in pairs(e) do
            ct=ct..getcn(k).."\n\t\t"..v.."\n"
--          ct=ct.."\n\t\t"..v.."\n"
          end
          content=ct:sub(1,-2)
        end
      end
      local content=content:gsub("&nbsp;","")
    
    lt.addView(loadlayout({
      LinearLayout,
      Gravity="center|left",
      layout_width="-1",
      layout_height="-1",
      {
        TextView,
        layout_width="wrap",
        onTouchListener=点击监听,
        onClick=function(v)
          local p=PopupMenu(this,v)
          local m=p.Menu
          m.add("复制消息内容").onMenuItemClick=function(a)
            写入剪贴板(v.text)
            提示 ("已复制消息内容")
          end
          m.add("删除此条消息").onMenuItemClick=function(a)
            local dl=AlertDialog.Builder(this)
            .setMessage("确定删除此条消息？")
            . setPositiveButton ("取消", function ()
            end)
            .setNeutralButton("删除", function ()
              v.Parent.removeView(v)
              提示 ("已删除此条消息")
            end)
            local dl=dl.show()
            控件圆角(dl.getWindow(),0xffffffff)
            setDialogButtonColor(dl,0,returntheme())
          end
          p.show()
        end,
        layout_height="-1",
        Gravity="center|left",
        textSize="18sp",
        padding="3%w",
        textColor=0xffffffff,
        id="botreplymsg",
        layout_marginTop="2%w",
        elevation="2dp",
        layout_marginLeft="6%w",
        layout_marginRight="6%w",
        layout_marginBottom="2%w",
        text=content,
      },
    }))
    控件圆角(botreplymsg,returntheme(),10)
    task(500, function ()
      scrollView.fullScroll(ScrollView.FOCUS_DOWN)
    end)
  end)
  et.setText("")
  task(500, function ()
    scrollView.fullScroll(ScrollView.FOCUS_DOWN)
  end)
 else
  提示 ("请先输入内容")
  scrollView.fullScroll(ScrollView.FOCUS_DOWN)
end
end

activity.setContentView(loadlayout({
  LinearLayout,
  layout_width="-1",
  layout_height="-1",
  orientation="vertical",
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
        id="robotname",
        text=茉莉机器人名字,
        textSize="20sp";
      };
      {
        ImageView;
        src="image/config.png";
        layout_height="56dp";
        layout_width="56dp";
        padding="16dp";
        foreground=转波纹色(0x5FFFFFFF);
        onClick=function ()
          setName("取消",8)
        end,
        ColorFilter="#ffffffff";--图片着色
        id="ssss";
      };
    };

  };

  {
    LinearLayout,
    layout_width="fill",
    layout_height="-1",
    orientation="vertical",
    layout_weight="1",
    {
      ScrollView,
      layout_width="fill",
      layout_height="wrap",
      fillViewport="true",
      id="scrollView",
      OverScrollMode=2,
      {
        LinearLayout,
        layout_width="fill",
        layout_height="wrap",
        orientation="vertical",
        id="lt",
        {
          TextView,
          layout_width="wrap",
          layout_height="-2",
          gravity="center|left",
          textSize="18sp",
          layout_marginTop="4%w",
          layout_marginBottom="2%w",
          text="快和 "..getRobotName().." 一起聊天吧",
          id="finalwait",
          padding="3%w",
          onTouchListener=点击监听,
          onClick=function(v)
            local p=PopupMenu(this,v)
            local m=p.Menu
            m.add("复制消息内容").onMenuItemClick=function(a)
              写入剪贴板(v.text)
              提示 ("已复制消息内容")
            end
            m.add("删除此条消息").onMenuItemClick=function(a)
              local dl=AlertDialog.Builder(this)
              .setMessage("确定删除此条消息？")
              . setPositiveButton ("取消", function ()
              end)
              .setNeutralButton("删除", function ()
                v.Parent.removeView(v)
                提示 ("已删除此条消息")
              end)
              local dl=dl.show()
              控件圆角(dl.getWindow(),0xffffffff)
              setDialogButtonColor(dl,0,0xff00b1ff)
            end
            p.show()
          end,
          elevation="2dp",
          layout_marginLeft="6%w",
          layout_marginRight="6%w",
          textColor=0xffffffff,
        }
      },
    },
  },
  {
    LinearLayout,
    layout_width="fill",
    layout_height="10%h",
    orientation="horizontal",
    layout_gravity="center",
    gravity="center",
    background="#ffffffff",
    {
      EditText,
      layout_width="75%w",
      layout_height="fill",
      textSize="15sp",
      hint="想和我说什么",
      backgroundColor=0,
      id="et",
    },
    {
      Button,
      layout_width="15%w",
      layout_height="fill",
      text="发送",
      onTouchListener=点击监听,
      onClick=function()
        发送信息(et.text)
      end,
      textColor=returntheme(),
      backgroundColor=0,
    },
  },
}))

function setName(neutraltext,notevisible)
  local 信息完善=AlertDialog.Builder(this)
  .setTitle("设置名称")
  .setView(loadlayout ({
    LinearLayout,
    id="information",
    layout_width="fill",
    orientation="vertical",
    {
      LinearLayout,
      layout_width="fill",
      orientation="horizontal",
      layout_height="wrap",
      layout_marginTop="3%w",
      {
        ImageView,
        src="image/user.png",
        layout_height="5%h",
        layout_gravity="center",
      },
      {
        EditText,
        hint="请输入你的昵称",
        text=茉莉主人名字,
        layout_width="80%w",
        id="owner_nane",
        singleLine=true,
        backgroundColor=0,
        layout_gravity="center",
        gravity="center|left",
      },
    },
    {
      LinearLayout,
      layout_width="fill",
      layout_height="wrap",
      orientation="horizontal",
      {
        ImageView,
        src="image/bot.png",
        layout_height="5%h",
        layout_gravity="center",
      },
      {
        EditText,
        hint="请为我起个名字",
        text=getRobotName(),
        layout_width="80%w",
        id="rob_nane",
        --layout_height="10%h",
        backgroundColor=0,
        layout_gravity="center",
        gravity="center|left",
        singleLine=true,
      },
    },
    {
      TextView,
      text="可在设置中随意修改",
      layout_gravity="center",
      visibility=notevisible,
    },
  }))
  .setPositiveButton ("好的", function ()
    io.open(moliyourname,"w+"):write(owner_nane.text):close()
    茉莉主人名字=io.open(moliyourname):read("*a") --读取文件
    if 茉莉主人名字~=rob_nane.text then
      io.open(molirobotname,"w+"):write(rob_nane.text):close()
      茉莉机器人名字=io.open(molirobotname):read("*a") --读取文件
    end
    if #rob_nane.text<1 then
      robotname.text="dingyi"
      io.open(molirobotname,"w+"):write("dingyi"):close()
      茉莉机器人名字=io.open(molirobotname):read("*a") --读取文件
      提示("已恢复默认名称")
     else
      robotname.text=rob_nane.text

      提示("已设置名称")
      finalwait.text="快和 "..getRobotName().." 一起聊天吧"
    end
  end)
  .setNeutralButton (neutraltext,nil)
  --.setCancelable(false)
  local 信息完善=信息完善.show()
  控件圆角(信息完善.getWindow(),0xffffffff)
  setDialogButtonColor(信息完善,0,returntheme())
end

if #茉莉机器人名字<1 or #茉莉主人名字<1 then
  if #茉莉机器人名字<1 then
    robotname.text="dingyi"
  end
  setName("稍候设置",0)
end

控件圆角(finalwait,returntheme(),10)

--[[
原作者 fa二群 小白
原作者QQ 2926037170
由 Ayaka_ago 修改
]]

et.setOnEditorActionListener{
  onEditorAction=function(view,int,KeyEvent)
    if KeyEvent and KeyEvent.keyCode==66 then
      发送信息(et.text)
    end
  end}

通知栏颜色(returntheme())