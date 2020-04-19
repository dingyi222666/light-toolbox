require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "android.text.Html"
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
        text="归属地查询";
      };
    };

  };
  {
    LinearLayout,
    layout_width="fill",
    layout_height="7%h";
    {
      EditText,
      textSize="16dp",
      backgroundColor=0,
      paddingTop="8dp",
      paddingBottom="8dp",
      padding="16dp",
      hint="输入手机号码",
      inputType="number",
      layout_width="75%w",
      layout_height="fill";
      id="phone_number",
      singleLine=true,
      gravity="left|center",
      ems=11,
    };
    {
      CardView;--卡片控件
      layout_width="20%w",
      layout_height="6%h";
      layout_marginTop='5dp';--布局外边顶距   
      CardElevation='2dp';--卡片阴影
      radius='15';--卡片圆角
      CardBackgroundColor=returntheme();--卡片背景颜色
      onClick=function (v)
        Http.get("https://api.mlooc.cn/v1/phoneplace/?phone="..phone_number.text,function(c,n)
          if c==200 then
            cjson=require "cjson"
            n=cjson.decode(n)
            if tointeger(n["code"])~=200 then
              提示("号码输入错误")
             else
              local gsd=n["data"]["place"]
              local qh=n["data"]["areaCode"]
              local yys=n["data"]["cardType"]
              phone_result.text=Html.fromHtml("<br>归属地<br><br><font color="..returntheme().." >\t\t"..gsd.."\n\n\t".."<br>\n区号<br><br><font color="..returntheme().." >\t"..qh.."</font><br><br><br>\n运营商/卡类型<br><br><font color="..returntheme().." >\t\t"..yys.."</font>")
            end
           
         else
          提示("查询失败")
        end
      end)
    end,
    {
      LinearLayout;--线性布局
      layout_width='fill';--布局宽度
      BackgroundDrawable=转波纹色(0x5FFFFFFF);
      layout_height='fill';--布局高度
      gravity='center';--子控件在父控件中的对齐方式
      {
        TextView;--文本控件
        layout_width='wrap';--文本宽度
        layout_height='wrap';--文本高度
        textColor=0xffffffff;--文本颜色
        text='查询';--显示的文本
        -- gravity='center';--子控件在父控件中的对齐方式
        textSize='15sp';--文本大小
      };
    };
  };
};

{
  TextView,
  id="phone_result",
  textColor=returntheme();--背景颜色,
  textSize="16dp",
  text="\n归属地\n\n\n\n区号\n\n\n\n运营商/卡类型",
  padding="16dp",
  textIsSelectable=true,
},



}))

通知栏颜色(returntheme())
原波纹(back,0x5FFFFFFF)