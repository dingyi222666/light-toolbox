require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"

--Copyright© Ayaka_Ago. All Rights Reserved.

import "android.text.TextWatcher"

this.setContentView(loadlayout({
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
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
        BackgroundDrawable=转波纹色(0x5FFFFFFF);
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
        text="随机数生成";
      };
      {
        ImageView;
        src="image/ic_dots_vertical.png";
        layout_height="56dp";
        layout_width="56dp";
        padding="16dp";
        BackgroundDrawable=转波纹色(0x5FFFFFFF);
        onClick=function(l,v)
          pop=PopupMenu(activity,l)
          menu=pop.Menu
          menu.add("关于").onMenuItemClick=function(a)
            AlertDialog.Builder(this)
            .setTitle("关于")
            .setMessage("源码来自Ayaka_Ago")
            .setPositiveButton("知道了",nil)
            .show()
          end
          menu.add("复制源码").onMenuItemClick=function(a)
          写入剪贴板(读取文件(activity.getLuaDir().."/res/code.txt"))
          提示("已复制源码")
          end
          pop.show()--显示
        end;
        ColorFilter="#ffffffff";--图片着色
        id="ssss";
      };
    };

  };
  {
    LinearLayout,
    layout_width="fill",
    padding="16dp",
    paddingTop="8dp",
    paddingBottom="8dp",
    gravity="center",
    {
      EditText,
      gravity="center",
      ems=6,
      singleLine=true,
      backgroundColor=0,
      hint="最小值",
      textSize="16dp",
      inputType="number",
      id="random_lowest",
      text="",
      layout_weight=1,
    },
    {
      TextView,
      layout_gravity="center",
      layout_height="24dp",
      layout_width="24dp",
      textSize="20dp",
      text="~",
    },
    {
      EditText,
      ems=6,
      gravity="center",
      backgroundColor=0,
      hint="最大值",
      text="",
      inputType="number",
      layout_weight=1,
      textSize="16dp",
      id="random_max",
      textColor=文字色,
      hintTextColor=次要文字色,
      singleLine=true,
    },
  },
  {
    ScrollView,
    layout_width="fill",
    layout_weight=1,
    {
      TextView,
      id="random_result",
      text="",
      textColor=文字色,
      textSize="56dp",
      layout_gravity="center",
      layout_height="fill",
      padding="16dp",
      textIsSelectable=true,
    },
  },
  {
    Button,
    text="生成",
    layout_width="fill",
    layout_margin="16dp",
    onClick=function (v)
      if #random_lowest.text==00or #random_max.text==0 then
        提示("数值不能为空")
       else
        pcall(function () random_result.setText(tostring(math.random(tonumber(random_lowest.text),tonumber(random_max.text)))) end)
      end
    end,
    textColor=0xffffffff,
    id="random_create",
    textSize="16dp",
    elevation='0dp';--卡片阴影
    BackgroundColor=returntheme(),
  },
}))

local function TextChanged(v)
  return TextWatcher{
    onTextChanged=function(n)
      if #n>=19 then
        v.setText(tostring(n):sub(0,18)).setSelection(#v.text)
        提示("位数已达上限")
        imm.hideSoftInputFromWindow(v.getWindowToken(),0)
      end

    end}
end

random_lowest.addTextChangedListener(TextChanged(random_lowest))
random_max.addTextChangedListener(TextChanged(random_max))
通知栏颜色(returntheme())