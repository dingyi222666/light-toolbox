require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "cjson"
import "java.io.*"
import "android.content.DialogInterface"
import "android.app.ProgressDialog"

function 网址取源()
  import "mods.get_web_source_Code"--导入网页源码获取包
  下拉对话框({
    输入框id="edit",
    对话框id="mm",
    标题="网址取源",
    输入框hint="请输入网址",
    按钮1显示=8,
    按钮2文字="获取",
    按钮2点击事件=function()
      if #edit.Text<1 then
        edit.setError("请输入后再重试！")
       else
        activity.newActivity("websitelook",{http.get(edit.Text)})
      end
    end,
  })
end

function cleanb()
  执行Shell("rm -rf /data/data/"..this.packageName.."/cache")
  执行Shell("rm -rf /data/data/"..this.packageName.."/code_cache")
  执行Shell("rm -rf /data/data/"..this.packageName.."/app_webview")
  执行Shell("rm -rf /data/data/"..this.packageName.."/app_textures")
  执行Shell("rm -rf /data/data/"..this.packageName.."/files/data")
  执行Shell("rm -rf /data/data/"..this.packageName.."/files/live_log")
  提示("清除成功")

end
function webcheck()
  import "android.content.Context"
  import "android.content.Intent"
  import "com.androlua.Http"
  import "android.net.Uri"
  import "java.io.File"

  dialog = ProgressDialog(this)
  dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER)
  dialog.setTitle("提示")
  --设置进度条的形式为圆形转动的进度条
  dialog.setMessage("正在检测你的网络中，请稍等片刻".."\n小提示:如果长时间无反应，按手机「返回键」可以取消")
  dialog.setCancelable(true)--设置是否可以通过点击Back键取消
  dialog.setCanceledOnTouchOutside(false)--设置在点击Dialog外是否取消Dialog进度条
  dialog.setOnCancelListener{
    onCancel=function(l)
      提示("您取消了「检测网络」操作")
      return false
  end}

  --取消对话框监听事件
  圆角显示(dialog)

  fuck={}

  Http.get("https://www.baidu.com",function(code,content)
    if code==200 then
      fuck["1"]="好"
     else
      fuck["1"]="坏"
    end
  end)

  Http.get("http://djt6666.host3v.vip/",function(code,content)
    if code==200 then
      fuck["2"]="好"
     else
      fuck["2"]="坏"
    end
  end)

  task(3000,function()
    dialog.dismiss()
    local dl=AlertDialog.Builder(this)
    .setTitle("检测结果")
    .setMessage("和网络的连通性   "..fuck["1"].."\n和软件服务器的连通性  "..fuck["2"].."\n\n小提示:建议再来一次，会得到真正的结果")
    .setPositiveButton("确定",{onClick=function()
        fuck=nil
        collectgarbage("collect")--垃圾回收器
    end})
    .setNeutralButton("取消",{onClick=function()
        fuck=nil
        collectgarbage("collect")--垃圾回收器
    end})
    圆角显示(dl)
  end)

end
function 说说打赏()
  下拉对话框({
    输入框id="edit",
    对话框id="mm",
    标题="说说打赏",
    输入框hint="请输入待打赏的金额",
    按钮1显示=8,
    按钮2文字="获取",
    按钮2点击事件=function()
      if #edit.Text<1 then
        edit.setError("请输入后再重试！")
       else
        mm.dismiss()
        写入剪贴板("[em]e10033[/em]{uin:2742,nick: 打赏了"..edit.Text:sub(0,9).."元红包}")
        打开腾讯QQ()
      end
    end,
  })


end




function 短链接生成()
  下拉对话框({
    输入框id="txt",
    对话框id="mm",
    标题="短链接生成",
    输入框hint="请输入待转换的网址",
    按钮1文字="帮助",
    按钮1点击事件=function()
      local zjszj=AlertDialog.Builder(this)
      .setTitle("帮助")
      .setMessage("问:如何使用?\n"..
      "答:1.输入\n2.生成成功后自动复制\n3.ok"
      )
      .setPositiveButton("好的",nil)
      .setNeutralButton("取消",nil)
      圆角显示(zjszj)
    end,
    按钮2文字="生成",
    按钮2点击事件=function()
      if txt.Text=="" then
        txt.setError("没有输入任何东西")
       else

        body=http.get("https://api.d5.nz/api/dwz/url.php?url="..txt.Text)
        if body==nil then
          mm.dismiss()
          提示("生成失败")
         else
          mm.dismiss()
          local body=body:gsub("\\","")
          json=require "json"
          local ksk=json.decode(body)["url"]
          写入剪贴板(ksk)
          local jzzjzjj=AlertDialog.Builder(this)
          .setTitle("生成成功")
          .setMessage("您生成的链接为"..ksk)
          .setPositiveButton("复制",{onClick=function(v) 写入剪贴板(body)
              提示("已复制")
          end})
          .setNeutralButton("取消",nil)
          圆角显示(jzzjzjj)
        end

      end
    end,
  })

end

function 特殊文字生成()

  dialog=AlertDialog.Builder(this)
  .setTitle("特殊文字生成")
  .setView(loadlayout("layout/special_text_generation"))
  dialog=dialog.show()
  --下拉框
  nr={"草文","横线","花藤","菊花","射线1","射线2","射线3"}
  pz={TextView,padding="10dp",textSize="18sp",layout_width="-1"}
  adapter=LuaArrayAdapter(activity,pz,String(nr))
  xl.setAdapter(adapter)
  xl.onItemSelected=function(parent,view,position,id)
    w=view.Text
  end
  function sc.onClick()
    t=zf.Text
    --获取字符长
    s=utf8.len(t)
    a=0
    b=1
    t0="敏ۣۖิ"
    t3=""
    if zf.Text=="" then
      提示("没输入任何东西")
     else
      if w=="草文" then
        for n=1,s,1 do
          --截取
          t1=String(t).substring(a,b)
          --替换
          t2=string.gsub(t0,"敏",t1)
          t3=t3..t2
          a=a+1
          b=b+1
        end
        txt.Text=t3
        提示("生成成功")
       elseif w=="横线" then
        t0="敏̶"
        for n=1,s,1 do
          t1=String(t).substring(a,b)
          t2=string.gsub(t0,"敏",t1)
          t3=t3..t2
          a=a+1
          b=b+1
          txt.Text=t3
          提示("生成成功")
        end
       elseif w=="花藤" then
        t0="敏ۣۖิ"
        for n=1,s,1 do
          t1=String(t).substring(a,b)
          t2=string.gsub(t0,"敏",t1)
          t3=t3..t2
          a=a+1
          b=b+1
        end
        t3="ζั͡"..t3.." ั͡✾"
        txt.Text=t3
        提示("生成成功")
       elseif w=="菊花" then
        t0="敏҉"
        for n=1,s,1 do
          t1=String(t).substring(a,b)
          t2=string.gsub(t0,"敏",t1)
          t3=t3..t2
          a=a+1
          b=b+1
        end
        txt.Text=t3
        提示("生成成功")
       elseif w=="射线1" then
        t0="ฏ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎敏ฏ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎"
        for n=1,s,1 do
          t1=String(t).substring(a,b)
          t2=string.gsub(t0,"敏",t1)
          t3=t3..t2
          a=a+1
          b=b+1
        end
        txt.Text=t3
        提示("生成成功")
       elseif w=="射线2" then
        t0="ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็敏ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็"
        for n=1,s,1 do
          t1=String(t).substring(a,b)
          t2=string.gsub(t0,"敏",t1)
          t3=t3..t2
          a=a+1
          b=b+1
        end
        txt.Text=t3
        提示("生成成功")
       elseif w=="射线3" then
        t0="ۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖ 敏 ۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖ"
        for n=1,s,1 do
          t1=String(t).substring(a,b)
          t2=string.gsub(t0,"敏",t1)
          t3=t3..t2
          a=a+1
          b=b+1
        end
        txt.Text=t3
        提示("生成成功")
      end
    end
  end
  function fz.onClick()
    if zf.Text=="" then
      提示("复制失败")
     else
      写入剪贴板(t3)
      提示("复制成功")
    end
  end
  sc.foreground=转波纹色(0xcb5B5B5B);
  fz.foreground=转波纹色(0xcb5B5B5B);
  no.foreground=转波纹色(0xcb5B5B5B);
  no.onClick=function()
    dialog.dismiss()
  end

end



function QQ_getheadportrait()
  下拉对话框({
    输入框id="edit2",
    对话框id="mm",
    标题="QQ头像获取",
    输入框hint="请输入QQ号",
    按钮1显示=8,
    按钮2文字="获取",
    按钮2点击事件=function()
      if edit2.Text~="" then
        mm.dismiss()
        task(1000,function()
          seeimage([[http://q.qlogo.cn/headimg_dl?dst_uin=]]..edit2.Text..[[&spec=640&img_type=jpg]],edit2.Text.."的头像")
        end)
       else
        edit2.setError("没有输入任何东西")
      end
    end,
  })

end

function bilibili_getpng()
  下拉对话框({
    输入框id="edit",
    对话框id="mm",
    标题="bilibili封面获取",
    输入框hint="请输入AV号或者BV号",
    按钮1显示=8,
    按钮2文字="获取",
    按钮2点击事件=function()
      mm.dismiss()
      import "mods.get_web_source_Code"--导入网页源码获取包
      dialog5= ProgressDialog(this)
      dialog5.setProgressStyle(ProgressDialog.STYLE_SPINNER)
      --设置进度条的形式为圆形转动的进度条
      dialog5.setMessage("正在获取中...")
      dialog5.setCancelable(true)--设置是否可以通过点击Back键取消
      dialog5.setCanceledOnTouchOutside(false)--设置在点击Dialog外是否取消Dialog进度条
      dialog5.setOnCancelListener{
        onCancel=function(l)
          return
      end}
      圆角显示(dialog5)
      i=0
      function 回调(html)--重写回调事件。
        i=i+1
        if i==1 then
          filename=string.match(html,"/bfs/archive/(.-).jpg")
          dialog5.dismiss()

          seeimage("http://i0.hdslb.com/bfs/archive/"..filename..".jpg",a)
          return html
        end
      end
      if String(edit.text).startsWith("av") or String(edit.text).startsWith("BV") then --如果用户输入了av号
        url=("https://www.bilibili.com/video/"..edit.text)
        a=edit.Text
        getHtml(url,回调)
      end
    end,
  })
end


function qq_forcedchat()
  下拉对话框({
    输入框id="edit",
    对话框id="mm",
    标题="QQ强制聊天",
    输入框hint="请输入你需要强制聊天的QQ号",
    按钮1文字="教程",
    按钮1点击事件=function()
      local asz=AlertDialog.Builder(this)
      .setTitle("教程")
      .setMessage(
      "1.输入QQ号。\n"..
      "2.点击聊天\n"..
      "3.ok\n"..
      "附:如果不能正常聊天怎么办?\n"..
      "解决办法:去对方名片给他点个赞，然后进入自己的名片，进入我赞过的人，给他发消息，不过前提是对方必须开启允许附近的人临时会话。")

      .setPositiveButton("确定",nil)
      .setNeutralButton("取消",nil)
      圆角显示(asz)
    end,
    按钮2文字="聊天",
    按钮2点击事件=function()
      if edit.Text~="" then
        mm.dismiss()
        task(1000,function()
          --   提示(edit.Text)
          QQ强制聊天(edit.Text)
        end)
       else
        edit.setError("没有输入任何东西")
      end
    end,
  })

end

function seeimage(path2,name2)
  import "android.graphics.drawable.ColorDrawable"
  import "android.content.res.ColorStateList"
  import "android.view.animation.Animation"
  import "android.view.animation.RotateAnimation"
  import "android.animation.Animator$AnimatorListener"
  path=nil
  name=nil
  path=path2
  name=name2


  local dl=AlertDialog.Builder(this)
  .setView(loadlayout("layout/seeimage"))
  .show()
  dialog1=dl.show()
  dialog1.getWindow().setBackgroundDrawable(ColorDrawable(0x00000000));
  dialogWindow = dialog1.getWindow();
  dialogWindow.setGravity(Gravity.BOTTOM);
  --设置弹窗与返回键的响应,true为消失
  dialog1.setCancelable(true)
  --设置点击外部弹窗不消失
  dialog1.setCanceledOnTouchOutside(false)
  --设置弹窗宽度
  p=dialog1.getWindow().getAttributes();
  p.width=(activity.Width);
  dialog1.getWindow().setAttributes(p);

  src.setImageBitmap(loadbitmap(path))--图片路径
  --弹窗背景和圆角
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(0x00FFFFFF)
  drawable.setCornerRadii({25,25,25,25,0,0,0,0});
  dc.setBackgroundDrawable(drawable)


  角度=15
  控件id=Ghost
  控件颜色=0xFFFFFFFF
  CircleButton(控件id,控件颜色,角度)


end


function QQ_Talk_about_Blue_Font()
  下拉对话框({
    输入框id="edit",
    对话框id="mm",
    标题="QQ蓝色说说",
    输入框hint="想说些什么呢",
    按钮1显示=8,
    按钮2文字="生成",
    按钮2点击事件=function()
      mm.dismiss()
      写入剪贴板("{uin:0,nick:"..edit.Text..",who:1}")
      打开腾讯QQ()
    end,
  })
end


function 提示帮助()

  preferences=activity.getSharedPreferences("qpdhk",0);
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
          text="长按圆圈复制颜色!";
          textSize='18sp',--文字大小
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
    .setTitle("提示")--标题
    .setView(loadlayout(gt))
    .setPositiveButton("好的",{onClick=function()
        if 状态==true then
          import "android.content.Context"
          preferences=this.getSharedPreferences("qpdhk",0);
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


end



function 王者荣耀重复名()

  activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);

  dialog=AlertDialog.Builder(this)
  .setTitle("王者荣耀重复名")
  .setView(loadlayout("layout/king_name"))
  dialog=dialog.show()
  ---代码
  no.foreground=转波纹色(0xcb5B5B5B);
  no.onClick=function()
    dialog.dismiss()
  end;


  sc.onClick=function()
    txzf=""
    if txt.Text=="" then
      提示("没有输入任何东西")
     else
      z1=txzf..txt.Text
      z2=txt.Text..txzf
      z3=txzf..txt.Text..txzf
      z4=txzf..txzf..txt.Text
      z5=txt.Text..txzf..txzf
      z6=txzf..txzf..txt.Text..txzf..txzf
      items={}
      table.insert(items,z1)
      table.insert(items,z2)
      table.insert(items,z3)
      table.insert(items,z4)
      table.insert(items,z5)
      table.insert(items,z6)
      AlertDialog.Builder(this)
      .setTitle("生成结果(点击复制)")
      .setItems(items,{onClick=function(l,v)
          提示("已复制")
          写入剪贴板(items[v+1])
      end})
      .show()
    end
  end
  sc.foreground=转波纹色(0xcb5B5B5B);
end



function bilibili_download()

  activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);

  dialog=AlertDialog.Builder(this)
  .setTitle("bilibili视频下载")
  .setView(loadlayout("layout/bilibilidownload"))
  dialog=dialog.show()
  ---代码
  no.foreground=转波纹色(0xcb5B5B5B);
  no.onClick=function()
    dialog.dismiss()
  end;
  sc2.onClick=function()

    if String(txt.text).startsWith("av") then --如果用户输入了av号
      url=("http://www.bilibilijj.com/video/"..txt.text)
      打开网页(url,"普通","bilibili视频解析",nil,nil)
     else
      url=("http://www.bilibilijj.com/video/av"..txt.text)
      打开网页(url,"普通","bilibili视频解析",nil,nil)
    end
  end

  sc2.foreground=转波纹色(0xcb5B5B5B);

  sc.onClick=function()
    import "mods.get_web_source_Code"--导入网页源码获取包
    dialog5= ProgressDialog(this)
    dialog5.setProgressStyle(ProgressDialog.STYLE_SPINNER)
    --设置进度条的形式为圆形转动的进度条
    dialog5.setMessage("正在获取下载网址...")
    dialog5.setCancelable(true)--设置是否可以通过点击Back键取消
    dialog5.setCanceledOnTouchOutside(false)--设置在点击Dialog外是否取消Dialog进度条
    dialog5.setOnCancelListener{
      onCancel=function(l)
        return
    end}
    dialog5.show()
    i=0
    function 回调(html)--重写回调事件。
      i=i+1
      if i==1 then
        filename=string.match(html,'"initUrl":"//(.-)","')
        下载文件("http://"..filename,下载视频文件夹..q..".mp4")
        function ding(a,b)
          dialog5.setMessage("已下载……"..(a/1044480).."mb,还有"..((b-a)/1044480).."mb")
        end
        function dstop(c)--总长度
          MD提示("下载完成，保存在"..下载视频文件夹..q..".mp4","#FF12B8F6","#ffffffff","0","15")
          dialog5.setMessage("总下载……"..(c/1044480).."mb")
        end
        return html
      end
    end

    if String(string.lower(txt.text)).startsWith("av") then --如果用户输入了av号
      url=("https://b23.tv/"..txt.text)
      q=txt.text
      getHtml(url,回调)
     else
      url=("https://b23.tv/av"..txt.text)
      getHtml(url,回调)
      q="av"..txt.text
    end

  end

  sc.foreground=转波纹色(0xcb5B5B5B);




end


function 使用协议()
  preferences=activity.getSharedPreferences("abilibili",0);
  数据=preferences.getString("数据","nil");
  if 数据=="nil" then
    AlertDialog.Builder(this)
    .setTitle("用户协议")
    .setCancelable(false)
    .setMessage(读取文件(activity.getLuaDir().."/res/usageprotocol.txt"))
    .setPositiveButton("同意",{onClick=function(v)
        import "android.content.Context"
        preferences=this.getSharedPreferences("abilibili",0);
        editor=preferences.edit();
        数据="1";
        editor.putString("数据",数据);
        editor.commit();
        AlertDialog.Builder(this)
        .setTitle("使用提示")
        .setMessage([[
建议您安装x5视频内核！给你更好的视频体验！
如果现在不想安装可在稍后通过侧滑栏安装！
1.点击确定按钮进入网页
2.然后点击安装线上内核
3.等待安装成功后重启即可!
]]        )
        .setPositiveButton("确定",{onClick=function(v)
            打开网页("http://debugtbs.qq.com","视频","x5内核调试",nil,nil)
        end})
        .setNeutralButton("取消",nil)
        .show()
    end})
    .setNeutralButton("不同意",{onClick=function()
        os.execute("pm clear "..activity.getPackageName())
    end})
    .show()
  end
end


function 协议()
  AlertDialog.Builder(this)
  .setTitle("使用协议")
  .setCancelable(false)
  .setMessage(读取文件(activity.getLuaDir("/res/usageprotocol.txt")))
  .setPositiveButton("同意",{onClick=function(v)
      import "android.content.Context"
      preferences=this.getSharedPreferences("abilibili",0);
      editor=preferences.edit();
      数据="1";
      editor.putString("数据",数据);
      editor.commit();
      提示("欢迎使用!")
  end})
  .setNeutralButton("不同意",{onClick=function()
      os.execute("pm clear "..activity.getPackageName())
  end})
  .show()

end


function 更新日志()
  dialog1= AlertDialog.Builder(this)
  .setTitle("更新日志")
  .setMessage("加载中")
  .setPositiveButton("好的",nil)
  .setNeutralButton("取消",nil)
  dialog1=dialog1.show()
  获得更新日志()
end



function 图片点击(view)
  local addview=loadlayout({
    View,
    layout_width="1",
    layout_height="1",
    Visibility=8,
  })

  view.addView(addview)
  view.onTouch=function(v,e)
    if v.getChildCount()==2 then
      v.getChildAt(1).x=e.x
      v.getChildAt(1).y=e.y+v.getScrollY()
     else
      v.getChildAt(0).x=e.x
      v.getChildAt(0).y=e.y+v.getScrollY()
    end
  end

  import "android.webkit.WebView"
  view.onLongClick=function(v)
    hitTestResult = v.getHitTestResult()

    if (hitTestResult.getType() == WebView.HitTestResult.IMAGE_TYPE or hitTestResult.getType() == WebView.HitTestResult.SRC_IMAGE_ANCHOR_TYPE)then

      local pop=PopupMenu(activity,v.getChildAt(1) or v.getChildAt(0) )
      menu=pop.Menu
      menu.add("保存图片").onMenuItemClick=function(a)
        picUrl = hitTestResult.getExtra()
        Http.download(picUrl,"/sdcard/轻工具箱/pictures/"..os.date("%Y-%m-%d-%H-%M-%S")..".png",function(a)
        end)
        提示("图片已保存于/sdcard/轻工具箱/pictures/")
      end
      menu.add("保存动态图片").onMenuItemClick=function(a)
        picUrl = hitTestResult.getExtra()
        Http.download(picUrl,"/sdcard/轻工具箱/pictures/"..os.date("%Y-%m-%d-%H-%M-%S")..".gif",function(a)
        end)
        提示("图片已保存于/sdcard/轻工具箱/pictures/")
      end
      menu.add("复制链接").onMenuItemClick=function(a)
        picUrl = hitTestResult.getExtra()
        v.loadUrl("https://pic.sogou.com/pic/ris_searchList.jsp?statref=home&v=5&ul=1&keyword="..picUrl)
        提示("正在识图....")
      end
      menu.add("搜狗识图").onMenuItemClick=function(a)
        picUrl = hitTestResult.getExtra()
        v.loadUrl("https://pic.sogou.com/pic/ris_searchList.jsp?statref=home&v=5&ul=1&keyword="..picUrl)
        提示("正在识图....")
      end

      pop.show()--显示

    end

  end
end