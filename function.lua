require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "res.strings"
import "com.androlua.LuaAdapter"
import "android.graphics.drawable.ColorDrawable"
import "android.content.res.ColorStateList"
import "android.graphics.drawable.RippleDrawable"
import "com.dingyi.*"
import "android.view.animation.DecelerateInterpolator"
import "android.view.animation.AccelerateInterpolator"
import "com.androlua.Ticker"
import "android.graphics.drawable.GradientDrawable"
import "android.*"


载入页面("layout.func")



ztl=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)

--dp转px--
function dp2px(dpValue)
  local scale = this.getResources().getDisplayMetrics().density
  return (dpValue * scale)
end

--沉浸状态栏--
window=activity.getWindow()
window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)




toolbar.setBackgroundColor(returntheme())

--动画--
function sra()
  animator = ViewAnimationUtils.createCircularReveal(toolbar,activity.getWidth()-dp2px(22),dp2px(24)+ztl,0,Math.hypot(toolbar.getWidth(), toolbar.getHeight()));
  --animator.setInterpolator(AccelerateInterpolator());
  animator.setInterpolator(DecelerateInterpolator());--动画减速器
  animator.setDuration(500);
  animator.start();
end

--延时0秒(直接放入主事件会报错)--
ti=Ticker()
ti.Period=0
ti.onTick=function()
  ti.stop()
  sra()
end
ti.start()


标题文字,加载内容=...

加载内容=activity.getLuaDir().."/reslist/"..加载内容..".conf"

import "mods.tabfunc"
import "mods.VIP"


波纹(back,0x20ffffff)

back.onClick=function()
  activity.setResult(10000,Intent());
  activity.finish()
end


page=0

function onKeyDown(key,event)
  if(key==4)then
    page=page+1
    --记录点击

    if(page==2)then
      activity.setResult(10000,Intent());
      activity.finish()
    end
  end
  return true
end


标题.Text=(标题文字)


layout_parent=
{
  LinearLayout;
--  orientation="vie";
--  Elevation="300dp";
  layout_width="fill";
  layout_height="-2";
  {
    GridView;
    numColumns="2";
    layout_weight="1";
    id="grid";
    gravity="center";
    horizontalSpacing="-15dp";--横向布局
    verticalSpacing="-15dp";--竖向布局
  };
};

布局.addView(loadlayout(layout_parent))




button_layout=
{
  LinearLayout;
  layout_width="45%w";
  layout_height="80dp";
  gravity="center";
  id="s",
  {
    CardView;
    layout_gravity="center";
    layout_marginTop="2%h";
    elevation="0dp";
    layout_width="45%w";
    layout_height="45dp";
    cardBackgroundColor="#FFF7F7F7";
    radius="5dp";
    {
      LinearLayout,
      layout_margin="0dp";
      layout_width="fill";
      layout_height="fill";
      gravity="center";
      id="m",
      onClick=function(v)
        运行代码(tabfunc[v.getChildAt(0).text])
        return true
      end,
      OnLongClickListener={
        onLongClick=function(v)
          local a=读取文件(收藏文件路径)
          local itemsa={}
          if a:find(v.getChildAt(0).Text) then
            itemsa={"取消收藏","添加到桌面","取消"}
           else
            itemsa={"收藏","添加到桌面","取消"}
          end

          pop=PopupMenu(activity,v)
          menu=pop.Menu
          for k,q in pairs(itemsa) do
            menu.add(q).onMenuItemClick=function(c)
              local c=tostring(c)
              if c=="收藏" then
                收藏项目(v.getChildAt(0).Text)
                提示("收藏 "..v.getChildAt(0).Text.." 成功!")
               elseif c=="取消收藏" then
                删除收藏(v.getChildAt(0).Text)
                elseif c=="添加到桌面" then
                createShortcut(v.getChildAt(0).Text)
              end
            end

          end
          pop.show()--显示

          return true
        end,
      },


      {
        TextView;
        textSize="14sp";
        textColor="#333333";
        id="fuck";
        OnTouchListener=点击监听,
        gravity="center";
        layout_gravity="center";
      };
    };
  };
}




data={}

--创建适配器
adp=LuaAdapter(activity,data,button_layout)


import "android.graphics.drawable.ColorDrawable"
import "android.content.res.ColorStateList"
import "android.graphics.drawable.RippleDrawable"


listdraw=RippleDrawable(ColorStateList(int[0].class{int{}},int{0x00000000}),nil,ColorDrawable(0xffffffff))
grid.setSelector(listdraw)



--adp.add{fuck={Text="",Visibility=8},s={Visibility=8},m={foreground=转波纹色(0xcb5B5B5B)}}
for c in io.lines(加载内容) do
  if #c>1 then
  adp.add{fuck=c,m={backgroundDrawable=转波纹色(0xcb5B5B5B)}}
 end
end

function 删除收藏(text)
  local mytab={}
  for c in io.lines(收藏文件路径) do
    if c~=text then
      mytab[#mytab+1]=c;
    end
  end
  追加写入文件(收藏文件路径,table.concat(mytab,"\n"))
  提示("删除成功")

  mytab=nil
end

grid.Adapter=adp

--项目被单击