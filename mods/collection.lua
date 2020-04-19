require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "res.strings"
import "mods.tabfunc"
import "android.view.animation.ScaleAnimation"
import "android.view.animation.Animation"

--定义常量

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
        function onActivityResult(req, res, intent)
          if res == 10000 then
            刷新收藏()
            return
           elseif res== 10001 then
            检查vip()
            return
           elseif res== 10002 then
            提示("正在更新ui.....")
            activity.newActivity("main")
            activity.finish()
            return
          end
        end
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


--ci=0

--适配器

local data_2={}

--创建适配器
adp_2=LuaAdapter(activity,data_2,button_layout)


import "android.graphics.drawable.ColorDrawable"
import "android.content.res.ColorStateList"
import "android.graphics.drawable.RippleDrawable"


listdraw=RippleDrawable(ColorStateList(int[0].class{int{}},int{0x00000000}),nil,ColorDrawable(0xffffffff))
grid_2.setSelector(listdraw)

--第一次添加
function 第一次收藏()
  if 文件行数(收藏文件路径) ==0 or 读取文件(收藏文件路径)=="" then
    grid_2.Visibility=8
    no_collection.Visibility=0
   else
    grid_2.Visibility=0
    no_collection.Visibility=8
    for c in io.lines(收藏文件路径) do
      if #c>0 then
        adp_2.add{fuck=c,m={foreground=转波纹色(0xcb5B5B5B)}}
      end
    end
    grid_2.Adapter=adp_2

    grid_2.onItemClick=function(l,v,p,i)
      运行代码(tabfunc[v.Tag.fuck.Text])

      return true
    end



  end
end
--定义函数

第一次收藏()



function 刷新收藏()
  adp_2.clear()
  第一次收藏()

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
  刷新收藏()
  mytab=nil
end