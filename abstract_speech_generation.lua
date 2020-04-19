require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "android.view.animation.Animation$AnimationListener"
import "android.view.animation.AlphaAnimation"
import "android.view.ViewAnimationUtils"
import "android.view.animation.AnimationSet"
import "android.view.animation.TranslateAnimation"
import "android.graphics.BitmapFactory"
import "android.view.animation.LayoutAnimationController"
import "android.view.animation.DecelerateInterpolator"
import "android.animation.ObjectAnimator"
import "android.animation.AnimatorSet"
import "android.graphics.drawable.GradientDrawable"
import "android.graphics.drawable.ColorDrawable"
activity.setTitle("抽象话生成")
activity.setTheme(android.R.style.Theme_Material)
edrawable = GradientDrawable()
edrawable.setShape(GradientDrawable.RECTANGLE)
edrawable.setColor(0xffffffff)
edrawable.setCornerRadii({dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8),dp2px(8)});
edrawable.setStroke(2, 0x21212121,0,0)
activity.setContentView(loadlayout({
  LinearLayout;
  layout_height="-1";
  layout_width="-1";
  id="_root";
  background="#FFFFFFFF";
  orientation="vertical";
  {
    TextView;
    layout_height="10dp";
    Visibility=4,
  };
  {
    RelativeLayout;
    focusable=true;
    layout_width="-1";
    layout_height="-2";
    focusableInTouchMode=true;
    layout_marginLeft="16dp";
    layout_marginRight="16dp";
    {
      TextView;
      layout_width="-1";
      layout_height="48dp";
      backgroundDrawable=edrawable;
      layout_marginTop="8dp";
    };
    {
      EditText;
      textColor=returntheme();
      textSize="14sp";
      gravity="center|left";
      --Typeface=字体("product");
      --layout_marginTop="12dp";
      SingleLine=true;
      layout_width="-1";
      layout_height="48dp";
      id="username";
      background="#00212121";
      layout_margin="8dp";
      padding="8dp";
      layout_marginTop="8dp";
    };
    {
      TextView;
      textColor=0xff000000;
      text="转换字符";
      textSize="14sp";
      padding="8dp";
      paddingTop=0;
      paddingBottom=0;
      layout_margin="8dp";
      layout_width="-2";
      layout_height="-2";
      id="username_hint";
      background="#FFFFFFFF";
      layout_marginTop="8dp";
      layout_alignBaseline="username";

    };
  };

  {
    CardView;
    layout_width="-1";
    layout_height="-2";
    radius="8dp";
    background="#FFFFFFFF";
    layout_marginTop="8dp";
    layout_marginLeft="16dp";
    layout_marginRight="16dp";
    layout_marginBottom="8dp";
    Elevation="2dp";
    foreground=转波纹色(0x40000000);
    id="button";
    {
      TextView;
      layout_width="-1";
      layout_height="-1";
      textSize="16sp";
      paddingRight="21dp";
      paddingLeft="21dp";
      paddingTop="12dp";
      paddingBottom="12dp";
      Text="转换";
      textColor=returntheme();

      gravity="center";

    };
  };
  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="wrap";
    layout_margin="16dp";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=0xffffffff;
      Radius=dp2px(8)-2;
      layout_margin="2px";
      layout_width="-1";
      layout_height="-1";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";

        padding="16dp";
        {
          CheckBox;
          text="'我'转为'爷'",
          id="p1",
          textColor=returntheme(),
        };
        {
          CheckBox;
          text="'大'转为'带'",
          id="p2",
          textColor=returntheme(),
        };
      };
    };
  };
  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="wrap";
    layout_margin="16dp";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=0xffffffff;
      Radius=dp2px(8)-2;
      layout_margin="2px";
      layout_width="-1";
      layout_height="-1";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        orientation="vertical";
        padding="16dp";
        {
          TextView;
          text="结果";
          textColor=returntheme();
          textSize="13sp";
          gravity="center|left";
        };
        {
          TextView;
          text="",--感谢下载使用MDesign\n该软件使用AndroLua+编辑打包\n部分UI仿自Google I/O 2019\n\nMDesign by MUK";
          textColor=returntheme();
          textSize="14sp";
          textIsSelectable=true,
          id="result",
          gravity="center|left";
          --Typeface=字体("product");
          layout_marginTop="12dp";
        };
      };
    };
  };
  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor="#FFE0E0E0";
    Radius="8dp";
    layout_width="-1";
    layout_height="wrap";
    layout_margin="16dp";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor=0xffffffff;
      Radius=dp2px(8)-2;
      layout_margin="2px";
      layout_width="-1";
      layout_height="-1";
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        orientation="vertical";
        padding="16dp";
        {
          TextView;
          text="说明";
          textColor=returntheme();
          textSize="13sp";
          gravity="center|left";

        };
        {
          TextView;
          text="\n词库来自：https://github.com/gaowanliang/NMSL/blob/master/src/data/emoji.json\n目前仅支持中文转换\n更新时间:2020-1-25";
          textColor=returntheme();
          textSize="14sp";
          textIsSelectable=true,
          gravity="center|left";
          --Typeface=字体("product");
          layout_marginTop="12dp";
        };
      };
    };
  };
}))

通知栏颜色(returntheme())

--自定义ActionBar标题颜色
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
sp = SpannableString("抽象话生成")
sp.setSpan(ForegroundColorSpan(0xffffffff),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
activity.getActionBar().setTitle(sp)
activity.getActionBar().setElevation(2)
activity.getActionBar().setDisplayHomeAsUpEnabled(true)
import "android.graphics.drawable.ColorDrawable"
activity.getActionBar().setBackgroundDrawable(ColorDrawable(returntheme()))

function onOptionsItemSelected(item)
  switch (item.getItemId())
   case android.R.id.home --//返回键的id
    this.finish();
    return false;
  end
end

button.onClick=function()
  username.setFocusable(false);
  username.setFocusableInTouchMode(true);
  if #(username.Text)==0 then
    提示("还没有输入文字呢")
   else
    local json=import "json"    
    local Mytable=json.decode(读取文件(activity.getLuaDir("/res/emoji.json")))
    Mytext=tostring(username.getText())    
    for k,v in pairs(Mytable) do 
    Mytext=utf8.gsub(Mytext,tostring(k),tostring(v))
      Mytext=tostring(Mytext)
    end
    if p1.isChecked() then
    Mytext=Mytext:gsub("我","👴")
    end
    if p2.isChecked() then
    Mytext=Mytext:gsub("大","带")    
    end
    result.setText(Mytext)    
    提示("生成成功")
  end
end

username.setOnFocusChangeListener({
  onFocusChange=function(v,hasFocus)
    if hasFocus then
      username_hint.setTextColor(0xff000000)
      if username.text=="" then
        username_hint.startAnimation(TranslateAnimation(0,0,0,-dp2px(48/2)).setDuration(100).setFillAfter(true))
      end
     else
      username_hint.setTextColor(0xff000000)
      if #username.Text==0 then
        username_hint.startAnimation(TranslateAnimation(0,0,-dp2px(48/2),0).setDuration(100).setFillAfter(true))
       else
        username_hint.setTextColor(0xff000000)
      end

    end
  end})


for k,v ipairs({p1,p2}) do
  v.ButtonDrawable.setColorFilter(PorterDuffColorFilter(returntheme(),PorterDuff.Mode.SRC_ATOP));
end