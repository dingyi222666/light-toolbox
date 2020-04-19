require "import"
require "Pretend"
import "mods.func"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.res.ColorStateList"
import "com.androlua.Http"
import "android.R$id"
import "android.content.Intent"
import "android.view.animation.RotateAnimation"
import "android.view.animation.*"
import "android.view.animation.Animation"
import "mods.get_web_source_Code"

导航栏颜色(returntheme())
通知栏颜色(returntheme())


function rotateArrow(arrow,flag)
  pivotX = arrow.getWidth() / 2;
  pivotY = arrow.getHeight() / 2;
  fromDegrees = 0;
  toDegrees = 0;
  -- flag为true则向上
  if (flag) then
    fromDegrees =0;
    toDegrees = 360;
   else
    fromDegrees = 180;
    toDegrees = 360;
  end
  --旋转动画效果   参数值 旋转的开始角度  旋转的结束角度  pivotX x轴伸缩值
  animation = RotateAnimation(fromDegrees, toDegrees,pivotX, pivotY);
  --该方法用于设置动画的持续时间，以毫秒为单位
  animation.setDuration(400);
  --设置重复次数
  --animation.setRepeatCount(int repeatCount);
  --动画终止时停留在最后一帧
  animation.setFillAfter(true);
  --启动动画
  arrow.startAnimation(animation);
end

Title,url=...

dingyi=
{
  LinearLayout;
  layout_height="fill";
  layout_width="fill";
  orientation="vertical";
  {
    LinearLayout;
    BackgroundColor=returntheme();
    layout_height="0";
    layout_width="fill";
    elevation="2dp";
    id="status_bar";
  };
  {
    LinearLayout;
    BackgroundColor=returntheme();
    orientation="horizontal";
    layout_width="fill";
    layout_height="55dp";
    elevation="2dp";
    {
      LinearLayout;
      layout_width="55dp";
      gravity="center";
      layout_height="55dp";
      id="menu";
      onClick=function()
        activity.finish()
      end,
      foreground=转波纹色(0x20ffffff);
      {
        ImageView;
        src="image/left.png";
        layout_width="25dp";
        colorFilter="#ffffffff";
        layout_height="25dp";
        id="menu2"
      };
    };
    {
      LinearLayout;
      layout_height="fill";
      layout_weight="1";
      orientation="horizontal";
      {
        TextView;
        text=Title;
        --layout_marginLeft='20dp';--布局左距
        textColor="#ffffffff";
        textSize="18sp";
        layout_gravity="center";
      };
    };


  };
  {
    ScrollView;
    layout_height="fill";
    layout_width="fill";
    {
      LinearLayout;
      layout_height="fill";
      layout_width="fill";
      orientation="vertical";
      --随机美图展示
      {
        CardView;--卡片控件
        layout_margin="10dp";
        layout_gravity='center';--重力属性
        Elevation='2dp';--阴影属性
        layout_width='fill';--卡片宽度
        layout_height='50%h';--卡片高度
        radius='6dp';--卡片圆角
        CardBackgroundColor='#FFFFFFFF';--卡片背景颜色

        {
          ImageView;--图片控件
          layout_width='fill';--图片宽度
          id="美图";
          layout_height='fill';--图片高度
          scaleType="centerInside",
          layout_gravity='center';--重力属性
        };
      };
      --美图直链
      {
        CardView;--卡片控件
        layout_margin='10dp';--卡片边距
        layout_gravity='center';--重力属性
        Elevation='2dp';--阴影属性
        layout_width='fill';--卡片宽度
        layout_height='fill';--卡片高度
        radius='6dp';--卡片圆角
        CardBackgroundColor='#FFFFFFFF';--卡片背景颜色
        {
          LinearLayout;
          layout_margin="15dp";
          layout_height="-1";
          orientation="horizontal",--水平布局
          layout_width="fill";
          {
            LinearLayout;
            orientation="vertical",--垂直布局
            layout_width="75%w";
            {
              TextView;
              textColor="#FF000000";
              text="美图直链";
              textSize="16dp";
              layout_marginBottom="10dp";
            };
            {
              TextView;
              textColor="#FF444444";
              textSize="12dp";
              textIsSelectable=true;
              id="直链text",
              ellipsize="end",--文字过长自动隐藏
            };
          };
          {
            ImageView,--图片框控件
            layout_width="56dp",--布局宽度
            layout_height="25dp",--布局高度
            src="http://p.qpic.cn/pic_wework/1948211503/c2c44ad131d3fa57b656c06af935c6fc384494ee7a57ffd8/0",--视图路径
            onClick=function(v)
              rotateArrow(v,true)
              获取美图()
            end,
          },
        };
      };
      --下载及分享美图
      {
        LinearLayout;
        layout_height="70dp";
        layout_width="fill";
        {
          LinearLayout;
          layout_weight="1";
          layout_height="fill";
          {
            CardView;--卡片控件
            layout_margin='10dp';--卡片边距
            layout_gravity='center';--重力属性
            layout_width='fill';--卡片宽度
            layout_height='fill';--卡片高度
            radius='6dp';--卡片圆角
            CardBackgroundColor='#FFFFFFFF';--卡片背景颜色
            {
              LinearLayout;
              id="ab1";
              elevation="1dp";
              layout_width="fill";
              gravity="center";
              layout_height="fill";
              {
                ImageView;
                layout_width="56dp",--布局宽度
                layout_height="25dp",--布局高度
                src="http://p.qpic.cn/pic_wework/1948211503/b9bf6ba944d4dd340af7dbd4f6806dd58acf997db0891429/0";
              };
              {
                TextView;
                textColor="#000000";
                text="保存图片";
                textSize="13dp";
              };
            };
          };
        };
        {
          LinearLayout;
          layout_weight="1";
          layout_height="fill";
          {
            CardView;--卡片控件
            layout_margin='10dp';--卡片边距
            layout_gravity='center';--重力属性
            layout_width='fill';--卡片宽度
            layout_height='fill';--卡片高度
            radius='6dp';--卡片圆角
            CardBackgroundColor='#FFFFFFFF';--卡片背景颜色
            {
              LinearLayout;
              id="ab2";
              elevation="1dp";
              layout_width="fill";
              gravity="center";
              layout_height="fill";
              {
                ImageView;
                layout_width="56dp",--布局宽度
                layout_height="25dp",--布局高度
                src="http://p.qpic.cn/pic_wework/1948211503/797fab69bb3069d70f6cfcbb4086eaebcb061fa28e4fc563/0";
              };
              {
                TextView;
                textColor="#000000";
                text="分享图片";
                textSize="13dp";
              };
            };
          };
        };
      };
    };
  };
};

activity.setContentView(loadlayout(dingyi))
美图.setImageBitmap(loadbitmap("icon.png"))
直链text.text="获取中…"

function 点击波纹(id,颜色)
  local attrsArray = {android.R.attr.selectableItemBackgroundBorderless}
  local typedArray =activity.obtainStyledAttributes(attrsArray)
  ripple=typedArray.getResourceId(0,0)
  Pretend=activity.Resources.getDrawable(ripple)
  Pretend.setColor(ColorStateList(int[0].class{int{}},int{颜色}))
  id.setBackground(Pretend.setColor(ColorStateList(int[0].class{int{}},int{颜色})))
end

function 保存图片(picUrl)
  Http.download(picUrl,"/sdcard/轻工具箱/downloads/image"..os.date("%Y-%m-%d-%H-%M-%S")..".png",function(a)
    弹出消息("图片已保存于 /sdcard/轻工具箱/downloads/image/ ♪‎( ᷇࿀ ᷆ و(و")
  end)
end

function 分享文本(文本)
  text=文本
  intent=Intent(Intent.ACTION_SEND);
  intent.setType("text/plain");
  intent.putExtra(Intent.EXTRA_SUBJECT, "分享");
  intent.putExtra(Intent.EXTRA_TEXT, text);
  intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
  activity.startActivity(Intent.createChooser(intent,"分享到:"));
end

--随机一
function 获取美图()
  美图.setImageBitmap(loadbitmap("icon.png"))
  直链text.text="获取中…"
  getHtml(url,function(e)
    local ee=e:match([[src="(.-)"]])
    美图.setImageBitmap(loadbitmap(ee))
    直链text.text=ee
  end)
end


--点击波纹
点击波纹(ab1,0x19000000)
点击波纹(ab2,0x19000000)

--点击事项
ab1.onClick=function()
  保存图片(链接)
end

ab2.onClick=function()
  分享文本("我看到一个好看的图片，分享给你(ฅ∀<`๑)╭:" ..链接)
end

获取美图()

