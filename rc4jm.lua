require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "android.text.TextWatcher"

this.setContentView(loadlayout({
  LinearLayout,
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
        text="rc4加解密";
      };
      {
        ImageView;
        layout_height="56dp";
        layout_width="56dp";
        padding="16dp";
        ColorFilter="#ffffffff";
        id="copy";
        Visibility=8;
        src="image/trans_copy_normal.png";
        onClick=function() 写入剪贴板(resul.Text) 提示("已写入剪贴板") end,
      };
      {
        ImageView;
        layout_height="56dp";
        layout_width="56dp";
        padding="16dp";
        ColorFilter="#ffffffff";
        id="clear";
        Visibility=8;
        src="image/broom_96x96.png";
        onClick=function() from.Text="" end,
      };
    };

  };
  {
    ScrollView,
    layout_width="fill",
    {
      LinearLayout,
      orientation="vertical",
      padding="18dp",
      layout_width="fill",
      {
        EditText,
        layout_marginBottom="18dp",
        layout_width="fill",
        backgroundColor=0,
        textSize="16dp",
        id="from",
        gravity="top",
        minLines=6,
        hint="输入",
      },
      {
        EditText,
        layout_marginBottom="18dp",
        layout_width="fill",
        --   backgroundColor=0,
        textSize="16dp",
        id="key",
        gravity="top",
        minLines=1,
        hint="密匙",
      },
      {
        LinearLayout;
        layout_width="fill";
        layout_height='wrap';--布局高度
        {
          CardView;--卡片控件
          layout_margin='5dp';--卡片边距
          CardElevation='0';--卡片阴影
          layout_width='40%w';--卡片宽度
          layout_height='7.5%h';--卡片高度
          radius='45';--卡片圆角              
          CardBackgroundColor=returntheme();--卡片背景颜色
          {
            LinearLayout;
            layout_width="fill";
            layout_height='fill';--布局高度
            id="f1";
            gravity='center';--子控件在父控件中的对齐方式
            {
              TextView;
              layout_height="wrap";
              layout_width="wrap";
              textColor="#ffffffff";
              textSize="16sp";
              text="加密";
            };
          };
        };
        {
          CardView;--线性布局
          layout_weight='1';--权重值
        };--线性布局 结束
        {
          CardView;--卡片控件
          layout_margin='5dp';--卡片边距
          CardElevation='0';--卡片阴影
          layout_width='40%w';--卡片宽度
          layout_height='7.5%h';--卡片高度
          radius='45';--卡片圆角      
          CardBackgroundColor=returntheme();--卡片背景颜色
          {
            LinearLayout;
            layout_width="fill";
            layout_height='fill';--布局高度
            id="f2";
            gravity='center';--子控件在父控件中的对齐方式
            {
              TextView;
              layout_height="wrap";
              layout_width="wrap";
              textColor="#ffffffff";
              textSize="16sp";
              text="解密";
            };
          };
        };
      };
      {
        TextView,
        layout_width="fill",
        hint="输出",
        textSize="16dp",
        padding="6dp",
        id="resul",
        layout_marginTop="8dp",
        textIsSelectable=true,
      },
    },
  },
}))



import "mods.rc4"

通知栏颜色(returntheme())
原波纹(f1,0x5FFFFFFF)
原波纹(f2,0x5FFFFFFF)
原波纹(copy,0x5FFFFFFF)
原波纹(clear,0x5FFFFFFF)
原波纹(back,0x5FFFFFFF)
f1.onClick=function()
  if #from.text~=0 and #key.Text~=0 then
    pcall(function()resul.Text=rc4.encrypt(from.text,key.text)end)
    o()
   else
    提示("输入为空！")
  end
end
f2.onClick=function()
  if #from.text~=0 and #key.Text~=0 then
    if pcall(function()resul.Text=rc4.decrypt(from.text,key.text)end) then
     else
      提示("密匙错误！")
    end
    o()
   else
    提示("输入为空！")
  end
end

function o()
  if #from.text~=0 then
    clear.Visibility=(0)
   else
    clear.Visibility=(8)
  end
  if #resul.text~=0 then
    copy.Visibility=(0)
   else
    copy.Visibility=(8)
  end
end
function TextChanged(v)
  return TextWatcher{
    onTextChanged=function(n)
      o()
    end}
end

from.addTextChangedListener(TextChanged(from))