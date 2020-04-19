require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "res.strings"
import "java.io.File"
import "mods.func"
import "android.graphics.drawable.GradientDrawable"
import "mods.tabfunc"
import "mods.VIP"
import "res.strings"

--状态栏亮色()

thiss=activity.getLuaDir().."/reslist"



ls=luajava.astable(File(thiss).listFiles())

table.sort(ls,function(a,b)
  return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
end) --根据是否文件夹与字母排序

date2={}

for i, v in pairs(ls) do--遍历主表
  if tostring(v):find("vip.conf") then
    if VIP权限() then
      for c in io.lines(tostring(v)) do
        table.insert(date2,tostring(c))
      end
    end
   else
    if not tostring(v):find("vip.conf") then
      for c in io.lines(tostring(v)) do
        table.insert(date2,tostring(c))
      end
    end

  end
end

载入页面("layout.search")


local button_layout=
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
            itemsa={"取消收藏","取消"}
           else
            itemsa={"收藏","取消"}
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

波纹(ssgb,0x44000000)


波纹(ssss,0x44000000)

data_3={}

--创建适配器
adp_3=LuaAdapter(activity,data_3,button_layout)


import "android.graphics.drawable.ColorDrawable"
import "android.content.res.ColorStateList"
import "android.graphics.drawable.RippleDrawable"


listdraw=RippleDrawable(ColorStateList(int[0].class{int{}},int{0x00000000}),nil,ColorDrawable(0xffffffff))
grid_3.setSelector(listdraw)

function 刷新列表()

  for i, v in pairs(date2) do--遍历主表    
    adp_3.add{fuck=c,m={foreground=转波纹色(0xcb5B5B5B)}}
  end
  grid_3.Adapter=adp_3


end



function update(pls)
  adp_3.clear()
  adp_3=LuaAdapter(activity,button_layout)
  for k,v in ipairs(pls) do
       adp_3.add{fuck=v,m={foreground=转波纹色(0xcb5B5B5B)}}

  end
  grid_3.Adapter=adp_3
end


import "android.text.TextWatcher"
ssbjk.addTextChangedListener(TextWatcher{
  onTextChanged=function(p1)
    local s=tostring(p1)
    local t={}
    for k,v in ipairs(date2) do
      if v:lower():find(s,1,true) then
        table.insert(t,v)
      end
    end
    update(t)

  end
})


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


弹出输入法()


page=0

function onKeyDown(key,event)
  if(key==4)then
    --注意，与应用启动时执行的事件那还有个代码
    --page变量和打开的page页仅做演示，可自行更改
    --其实这是很简单的一个东西

    page=page+1
    --记录点击

    if(page==3)then
      activity.setResult(10000,Intent());

      activity.finish();

      --点击次数归零
      --此处可以添加其他操作
    end

    --还可添加其它操作，如点击后需进行密码验证再进行操作

  end
  return true
end

ztl=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)

--dp转px--
function dp2px(dpValue)
  local scale = this.getResources().getDisplayMetrics().density
  return (dpValue * scale)
end

function sra()
  animator = ViewAnimationUtils.createCircularReveal(searchbar,activity.getWidth()-dp2px(22),dp2px(24)+ztl,0,Math.hypot(searchbar.getWidth(), searchbar.getHeight()));
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

通知栏颜色(returntheme())