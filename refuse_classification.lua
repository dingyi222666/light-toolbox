require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "mods.MyEditText"
import "com.google.android.material.floatingactionbutton.FloatingActionButton"
activity.setContentView(loadlayout("layout/refuse_classification"))


import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"
noting.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(returntheme(),PorterDuff.Mode.SRC_ATOP))

通知栏颜色(returntheme())

颜色table={
  0xff80CBC4,
  0xff80DEEA,
  0xffD7B98E,
  0xff66CC99,
  0xffA1887F,
  0xff56A36C,
  0xff8CD790,
  0xff80CBC4,
  0xffA1887F,
}

itemc={
  LinearLayout;
  layout_width="fill";
  {
    CardView;
    layout_width="36dp";
    layout_height="36dp";
    padding="2dp";
    id="img";
    layout_gravity="center";
    radius=35;
    Elevation=0;
    layout_marginLeft='10dp';--布局左距
    {
      TextView;--文本控件
      layout_width='wrap';--文本宽度
      layout_height='wrap';--文本高度
      layout_gravity='center';--重力属性
      textColor='#ffffffff';--文本颜色   
      textSize='14sp';--文本大小
      id="bt1";
    };

  };
  {
    LinearLayout;
    orientation="vertical";
    --layout_height="64dp";
    padding="2dp";
    layout_marginLeft='8dp';--布局左距
    layout_width="fill";
    {
      TextView;
      layout_width="fill";
      textSize="16dp";
      singleLine="true";
      id="bt2";
    };
    {
      TextView;
      layout_width="fill";
      textSize="11dp";
      singleLine="true";
      id="bt3";
      text="\n";
    };
    {
      TextView;
      layout_gravity="bottom";
      layout_width="fill";
      textSize="13dp";
      singleLine="true";
      id="bt4";
    };
  };
};

local adp=LuaAdapter(activity,itemc)
lbx.Adapter=adp

弹出输入法()


function ks.onClick()
  pcall(adp.clear())
  tis.setVisibility(0);
  lbx.setVisibility(8);
  local url="https://www.metalgearjoe.cn/mn/search?search="..zh1.Text

  local number=zh1.getText()
  if tostring(number)=="" then
    提示("你还没有输入什么！")
    tis.setVisibility(8);
    lbx.setVisibility(0);
   else

    Http.get(url,nil,"UTF-8",header,function(code,content)
      if code==200 then
        content=content:match([[<div id%="results">(.-)<script type%="text/javascript">]])
        content=content:gsub("&nbsp;","")
        content=content:gmatch([[">(.-)</div>]])      
        if content~=nil then
          for v in content do
            v=v:gsub("%s%s%s","")
            text1=v:match("%p(.-)%p")
            text2=v:match("(.+)%p"):match("(.+)%p")
            text3=utf8.sub(text1,0,1)            
            if v:find("没有找到您要的结果") then
              提示("暂无该垃圾的分类")
              break
            end
            adp.add{bt1=text3,bt2=text2,bt4=text1,img={CardBackgroundColor=颜色table[math.random(1,9)]}}--a.mtime取键值
          end
         else
          提示("暂无该垃圾的分类")
        end
        tis.setVisibility(8);
        lbx.setVisibility(0);
       else
        提示("搜索出错  "..code);
      end

    end)


  end
end


lbx.onItemLongClick=function(l,v,p,i)
  写入剪贴板(v.Tag.bt2.Text.."\n"..v.Tag.bt4.Text)
  提示("已复制"..v.Tag.bt2.Text.."的垃圾分类")
  return true
end