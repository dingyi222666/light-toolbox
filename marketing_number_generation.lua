require "import"
import "android.widget.*"
import "android.view.*"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "mods.MyEditText"
通知栏颜色(returntheme())
this.setContentView(loadlayout(
{
  FrameLayout,
  layout_width="fill";
  layout_height="fill";
  {
    LinearLayout;
    layout_width="fill";
    layout_height="fill";
    orientation="vertical";
    BackgroundColor=0xffffffff,
    {
      LinearLayout;--整个动画栏--
      layout_height="-2";
      layout_width="-1";
      id="toolbar";
      BackgroundColor=returntheme();
      elevation="2dp";
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
          onClick=function()
            activity.finish();
          end,
          background=转波纹色(0x5FFFFFFF);
        };
        {
          TextView;
          layout_height="-2";
          layout_width="-1";
          layout_weight="1";
          paddingLeft="16dp";
          textColor="#ffffffff";
          textSize="20sp";
          text="营销号文章生成";
        };

      };

    };
    {
      LinearLayout,
      layout_width="fill";
      layout_height="20dp";
    },
    {
      MyEditText
      {
        id="zh1";
        Hint="请输入主体",
        radius=20;
        textSize="15dp";
        HintTextColor=returntheme();
      },
      layout_width="fill";
      layout_height="-2";
      BackgroundColor=0xffffffff,
    },
    {
      MyEditText
      {
        id="zh2";
        Hint="请输入事件",
        radius=20;
        textSize="15dp";
        HintTextColor=returntheme();
      },
      layout_width="fill";
      layout_height="-2";
      BackgroundColor=0xffffffff,
    },
    {
      MyEditText
      {
        id="zh3";
        Hint="请输入另一种说法",
        radius=20;
        textSize="15dp";
        HintTextColor=returntheme();
      },
      layout_width="fill";
      layout_height="-2";
      BackgroundColor=0xffffffff,
    },
    {
      MyEditText
      {
        id="zh4";
        Hint="请输入营销号名称",
        radius=20;
        textSize="15dp";
        HintTextColor=returntheme();
      },
      layout_width="fill";
      layout_height="-2";
      BackgroundColor=0xffffffff,
    },
    {
      MyEditText
      {
        id="zh5";
        Hint="结果",
        radius=20;
        textSize="15dp";
        HintTextColor=returntheme();
      },
      layout_width="fill";
      layout_height="-2";
      BackgroundColor=0xffffffff,
    }


  };
  {
    CardView,

    layout_width="56dp";
    layout_height="56dp";
    radius="28dp",
    layout_gravity="bottom|right",
    BackgroundColor=returntheme();
    layout_margin="13dp",
    {
      ImageView;
      layout_height="56dp";
      layout_width="56dp";
      padding="15dp";
      ColorFilter="#ffffffff";
      id="ks";
      src="image/check_black.png";

      background=转波纹色(0x5FFFFFFF);
    };
  }

}
))


function ks.onClick()
  if (#zh1.Text>0 and #zh2.Text>0 and #zh3.Text>0 and #zh4.Text>0) then
    zh5.Text=utf8.gsub(body,".",{
      ["1"]=tostring(zh1.Text),
      ["2"]=tostring(zh2.Text),
      ["3"]=tostring(zh3.Text),
     ["4"]=tostring(zh4.Text)
    })
   else
    提示("请全部输入成功后在生成")
  end
end
body=[[
12是怎么回事呢？
1相信大家都很熟悉，但是12是怎么回事呢，下面就让4带大家一起了解吧。

12，其实就是3，大家可能会很惊讶1怎么会2呢？很简单，因为1是1，12,所以13,事实就是这样，小编也感到非常惊讶。

这就是关于12的详细经过了，大家有什么想法呢，欢迎在评论区告诉小编一起讨论哦！]]
