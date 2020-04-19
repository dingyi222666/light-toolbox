--[[
码上 project by Ayaka_Ago

Barcode Scanning by ZXing
https://github.com/zxing/zxing
]]

require "import"
import "mods.glob"
import "mods.func"
import "res.strings"
import "mods.onclick"
checkTheme()
tabc={}

get=读取数据("主题")

page=0
function onKeyDown(key,event)
  if(key==4)then
    page=page+1
    --记录点击

    if(page==2)then
      if get~=读取数据("主题")
        activity.setResult(10002,Intent());
      end
      activity.finish()

    end
  end
  return true
end


this.setContentView(loadlayout({
  RelativeLayout,
  {
    RelativeLayout,
    layout_height="21.75%w",
    layout_width="fill",
    id="topBar",
    backgroundColor=主题色,
    elevation="1%w",
    onClick=function ()
    end,
    paddingTop=状态栏高度,
    {
      ImageView,
      src="image/left.png",
      layout_alignParentLeft=true;
      layout_height="56dp";
      layout_width="56dp";
      padding="14dp";
      onClick=function ()
        if get~=读取数据("主题")
          activity.setResult(10002,Intent());
        end
        activity.finish()

      end,
      foreground=转波纹色(0x20ffffff),
      
      id="back",
      ColorFilter=0xffffffff,
    },
    {
      TextView,
      id="title",
      text="设置",
      layout_toRightOf="back",
      gravity="left|center",
      textSize="18sp",
      layout_height="fill",
      textColor=0xffffffff,
    },

  },
  {
    ScrollView,
    layout_width="fill",
    id="content",
    background="0",
    {
      LinearLayout,
      padding="3.5%w",
      paddingTop="21.75%w",
      orientation="vertical",
      {
        TextView,
        padding="3.5%w",
        text="常规",
        -- textColor=按钮文字色,
        id="normal",
        textSize="14sp",
      },
      {
        RelativeLayout,
        onClick=function()
          cp_toggle.performClick()
        end,
        paddingRight="3.5%w",
        layout_height="13%w",
        foreground=转波纹色(0x705B5B5B),
        {
          LinearLayout,
          layout_height="fill",
          orientation="horizontal",
          layout_alignParentLeft=true;
          {
            ImageView,
            src="image/message.png",
            layout_height="fill",
            layout_width="13%w",
            padding="3.5%w",
          },
          {
            TextView,
            text="接收通知",
            textColor=0xff444444,
            layout_height="fill",
            textSize="16sp",
            gravity="center",
          },
        },
        {
          Switch,
          layout_alignParentRight=true;
          layout_height="fill",
          id="cp_toggle",
          onClick=function ()
          end,
          OnCheckedChangeListener={
            onCheckedChanged=function(d,isChecked)
              if isChecked then
                写入数据("通知","true")
                tabc["cp_toggle"]=isChecked
                d.ThumbDrawable.setColorFilter(PorterDuffColorFilter(按钮文字色,PorterDuff.Mode.SRC_ATOP))
                d.TrackDrawable.setColorFilter(PorterDuffColorFilter(按钮文字色,PorterDuff.Mode.SRC_ATOP))
               else
                写入数据("通知","false")
                tabc["cp_toggle"]=isChecked
                d.ThumbDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))
                d.TrackDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))
              end
          end },
        },
      },

      {
        RelativeLayout,
        onClick=function()
          ls_toggle.performClick()
        end,
        paddingRight="3.5%w",
        layout_height="13%w",
        foreground=转波纹色(0x705B5B5B),
        {
          LinearLayout,
          layout_height="fill",
          orientation="horizontal",
          layout_alignParentLeft=true;
          {
            ImageView,
            src="image/file_upload.png",
            layout_height="fill",
            layout_width="13%w",
            padding="3.5%w",
          },
          {
            TextView,
            text="检查更新",
            textColor=0xff444444,
            layout_height="fill",
            textSize="16sp",
            gravity="center",
          },
        },
        {
          Switch,
          layout_alignParentRight=true;
          layout_height="fill",
          id="ls_toggle",
          onClick=function ()
          end,
          OnCheckedChangeListener={
            onCheckedChanged=function(d,isChecked)
              if isChecked then
                写入数据("更新","true")
                tabc["ls_toggle"]=isChecked
                d.ThumbDrawable.setColorFilter(PorterDuffColorFilter(按钮文字色,PorterDuff.Mode.SRC_ATOP))
                d.TrackDrawable.setColorFilter(PorterDuffColorFilter(按钮文字色,PorterDuff.Mode.SRC_ATOP))
               else
                写入数据("更新","false")
                tabc["ls_toggle"]=isChecked
                d.ThumbDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))
                d.TrackDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))
              end
          end },
        },
      },
      {
        TextView,
        padding="3.5%w",
        textSize="14sp",
        textColor=按钮文字色,
        id="appearance",
        text="外观",
      },

      {
        RelativeLayout,
        layout_height="13%w",
        onClick=function()
          theme_select.performClick()
        end,
        paddingRight="3.5%w",
        foreground=转波纹色(0x705B5B5B),
        {
          LinearLayout,
          layout_height="fill",
          orientation="horizontal",
          layout_alignParentLeft=true;
          {
            ImageView,
            src="image/color.png",
            layout_height="fill",
            layout_width="13%w",
            padding="3.5%w",
          },
          {
            TextView,
            text="主题颜色",
            textColor=0xff444444,
            layout_height="fill",
            textSize="16sp",
            gravity="center",
          },
        },
        {
          Spinner,
          layout_alignParentRight=true;
          layout_height="fill",
          layout_width="35%w",
          Adapter=LuaArrayAdapter(activity,{TextView,padding="3%w",textSize="16sp",layout_width="fill"},theme_list),
          id="theme_select",
        },
      },
      {
        RelativeLayout,
        layout_height="13%w",
        paddingRight="3.5%w",
        id="setTheme";
        Visibility=8;
        onClick=function ()
          setThemea()
        end,
        foreground=转波纹色(0x705B5B5B),
        {
          LinearLayout,
          layout_height="fill",
          orientation="horizontal",
          layout_alignParentLeft=true;
          {
            ImageView,
            src="image/color.png",
            layout_height="fill",
            layout_width="13%w",
            padding="3.5%w",
          },
          {
            TextView,
            text="自定义主题颜色",
            textColor=0xff444444,
            layout_height="fill",
            textSize="16sp",
            gravity="center",
          },
        },
        {
          ImageView,
          layout_alignParentRight=true;
          layout_height="fill",
          padding="3.5%w",
          layout_width="13%w",
          src="image/chevron_right.png",
        },
      },
      {
        TextView,
        padding="3.5%w",
        textSize="14sp",
        id="other",
        textColor=按钮文字色,
        text="杂项",
      },
      {
        RelativeLayout,
        layout_height="13%w",
        paddingRight="3.5%w",
        onClick=function ()
          webcheck()
        end,
        foreground=转波纹色(0x705B5B5B),
        {
          LinearLayout,
          layout_height="fill",
          orientation="horizontal",
          layout_alignParentLeft=true;
          {
            ImageView,
            src="image/web_96x96.png",
            layout_height="fill",
            layout_width="13%w",
            padding="3.5%w",
          },
          {
            TextView,
            text="网络检测",
            textColor=0xff444444,
            layout_height="fill",
            textSize="16sp",
            gravity="center",
          },
        },
        {
          ImageView,
          layout_alignParentRight=true;
          layout_height="fill",
          padding="3.5%w",
          layout_width="13%w",
          src="image/chevron_right.png",
        },
      },
      {
        RelativeLayout,
        layout_height="13%w",
        paddingRight="3.5%w",
        onClick=function ()
          cleanb()
        end,
        foreground=转波纹色(0x705B5B5B),
        {
          LinearLayout,
          layout_height="fill",
          orientation="horizontal",
          layout_alignParentLeft=true;
          {
            ImageView,
            src="image/broom_96x96.png",
            layout_height="fill",
            layout_width="13%w",
            padding="3.5%w",
          },
          {
            TextView,
            text="清除缓存",
            textColor=0xff444444,
            layout_height="fill",
            textSize="16sp",
            gravity="center",
          },
        },
        {
          ImageView,
          layout_alignParentRight=true;
          layout_height="fill",
          padding="3.5%w",
          layout_width="13%w",
          src="image/chevron_right.png",
        },
      },

    },
  },
}))




theme_select.onItemSelected=function(parent,view,position,id)
  pcall(function ()
    写入数据("主题",view.text)
    if view.text==theme_list[1] then
      new_color=theme_main[1]
     elseif view.text==theme_list[2] then
      new_color=theme_main[2]
     elseif view.text==theme_list[3] then
      new_color=theme_main[3]
     elseif view.text==theme_list[4] then
      new_color=theme_main[4]
     elseif view.text==theme_list[5] then
      new_color=theme_main[5]
     elseif view.text==theme_list[6] then
      new_color=theme_main[6]
    end
    if view.text==theme_list[6] then
      showAndHiddenAnimation(setTheme,0,0)
     else
      if setTheme.getVisibility==0 then
        showAndHiddenAnimation(setTheme,8,0)

      end
      setTheme.setVisibility(8)

    end
    checkTheme()
    transColor(normal,"textColor",{normal.getCurrentTextColor(),按钮文字色},350)
    transColor(appearance,"textColor",{appearance.getCurrentTextColor(),按钮文字色},350)
    transColor(topBar,"backgroundColor",{appearance.getCurrentTextColor(),按钮文字色},350)
    transColor(other,"textColor",{other.getCurrentTextColor(),按钮文字色},350)
    switch_list={cp_toggle,ls_toggle}
    switch_fuck={"cp_toggle","ls_toggle"}
    for k,d in pairs(switch_list) do
      if tabc[switch_fuck[k]]==true then
        d.ThumbDrawable.setColorFilter(PorterDuffColorFilter(按钮文字色,PorterDuff.Mode.SRC_ATOP))
        d.TrackDrawable.setColorFilter(PorterDuffColorFilter(按钮文字色,PorterDuff.Mode.SRC_ATOP))
       else
        d.ThumbDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))
        d.TrackDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))
      end
    end
    通知栏颜色(主题色)
    导航栏颜色(主题色)
  end)

end

setTheme.onClick=function()

  InputLayout={
    LinearLayout;
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      EditText;
      hint="输入十六进制颜色代码";
      layout_marginTop="5dp";
      layout_width="80%w";
      layout_gravity="center",
      id="edit";
      -- text="";
    };
  };

  aa=AlertDialog.Builder(this)
  aa.setTitle("自定义主题设置")
  aa.setView(loadlayout(InputLayout))
  aa.setPositiveButton("保存",{onClick=function(v)
      if(edit.Text=="")then
        提示("未输入任何东西")
       else
        if tostring(edit.text):match("0[xX][0-9a-fA-F]+")==nil then
          提示("不是0x前缀16进制文件")
         else
          追加写入文件(主题文件路径,edit.Text)
          checkTheme()
          transColor(normal,"textColor",{normal.getCurrentTextColor(),按钮文字色},350)
          transColor(appearance,"textColor",{appearance.getCurrentTextColor(),按钮文字色},350)
          transColor(topBar,"backgroundColor",{appearance.getCurrentTextColor(),按钮文字色},350)
          transColor(other,"textColor",{other.getCurrentTextColor(),按钮文字色},350)
          switch_list={cp_toggle,ls_toggle}
          switch_fuck={"cp_toggle","ls_toggle"}
          for k,d in pairs(switch_list) do
            if tabc[switch_fuck[k]]==true then
              d.ThumbDrawable.setColorFilter(PorterDuffColorFilter(按钮文字色,PorterDuff.Mode.SRC_ATOP))
              d.TrackDrawable.setColorFilter(PorterDuffColorFilter(按钮文字色,PorterDuff.Mode.SRC_ATOP))
             else
              d.ThumbDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))
              d.TrackDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))
            end
          end
          通知栏颜色(主题色)
          导航栏颜色(主题色)
        end
      end
  end})
  aa.setNegativeButton("取消",nil)
  aa.show()
  edit.setText(读取文件(主题文件路径))
end


if 读取数据("主题")==theme_list[1] then
  theme_select.setSelection(0)
 elseif 读取数据("主题")==theme_list[2] then
  theme_select.setSelection(1)
 elseif 读取数据("主题")==theme_list[3] then
  theme_select.setSelection(2)
 elseif 读取数据("主题")==theme_list[4] then
  theme_select.setSelection(3)
 elseif 读取数据("主题")==theme_list[5] then
  theme_select.setSelection(4)
 elseif 读取数据("主题")==theme_list[6] then
  theme_select.setSelection(5)
end


cp_toggle.ThumbDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))
cp_toggle.TrackDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))
ls_toggle.ThumbDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))
ls_toggle.TrackDrawable.setColorFilter(PorterDuffColorFilter(0xFFB9B9B9,PorterDuff.Mode.SRC_ATOP))


if 读取数据("通知")=="true" then
  cp_toggle.setChecked(true)
  tabc["cp_toggle"]=true
 else
  tabc["cp_toggle"]=false
end

if 读取数据("更新")=="true" then
  ls_toggle.setChecked(true)
  tabc["ls_toggle"]=true
 else
  tabc["ls_toggle"]=false
end
