require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"

通知栏颜色(returntheme())
dingyi=
{
  LinearLayout;--线性控件
  orientation='vertical';--布局方向
  layout_width='fill';--布局宽度
  layout_height='fill';--布局高度
  BackgroundColor="#ffffffff";
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
        foreground=转波纹色(0x5FFFFFFF);
      };
      {
        TextView;
        layout_height="-2";
        layout_width="-1";
        layout_weight="1";
        paddingLeft="16dp";
        textColor="#ffffffff";
        textSize="20sp";
        text="历史上的今天";
        id="tittle",
      };
      {
        ImageView;
        src="image/ic_dots_vertical.png";
        layout_height="56dp";
        layout_width="56dp";
        padding="16dp";
        foreground=转波纹色(0x5FFFFFFF);
        onClick=function(l,v)
          pop=PopupMenu(activity,l)
          menu=pop.Menu
          menu.add("切换日期").onMenuItemClick=function(a)
            DatePickerDialog(this).show().setOnDateSetListener({
              onDateSet=function(a,b,c,d)
                url="http://www.todayonhistory.com/"..tostring(c+1).."/"..tostring(d).."/"
                tittle.Text=string.format("历史上%s月%s号的某天",c+1,d)
                刷新(url)
              end,
            })
          end

          pop.show()--显示;
        end;
        ColorFilter="#ffffffff";--图片着色
        id="ssss";
      };

    };
  };
  {
    ListView;--列表视图
    layout_width='fill';--布局宽度
    layout_height='fill';--布局高度
    dividerHeight='0';--设置分隔线宽度,0表示无分隔线
    BackgroundColor="#ffffffff";
    id="list";
  };
}


activity.setContentView(loadlayout(dingyi))

aa={
  LinearLayout;
  id="f2";
  layout_height="wrap",
  layout_width="fill",
  orientation="vertical";
  BackgroundColor="#ffffff";
  {
    TextView,
    layout_height="wrap",
    layout_width="wrap",
    layout_gravity="left|center",
    gravity="center",
    text="2020",
    id="k1";
    layout_margin='15dp';--布局外边距
    textSize="30sp",
    textColor='#ff000000';--文本颜色
  },
  {
    CardView;
    layout_margin='15dp';--布局外边距
    layout_marginTop='10dp';--布局顶距
    layout_width="fill";
    CardBackgroundColor="#ffffff";
    layout_height="wrap";
    Elevation='0dp';--阴影属性
    radius='6dp';--卡片圆角
    {
      ImageView;
      layout_width="fill",
      layout_height="fill",
      layout_gravity="center",
      scaleType='centerCrop';
      id="k2";
    },
    {
      LinearLayout;
      id="f5";
      layout_height="wrap",
      layout_width="fill",
      orientation="horizontal";
      background="#B24D4D4D";
      layout_gravity="center|bottom",
      {
        TextView,
        layout_height="wrap",
        layout_width="fill",
        layout_marginLeft='15dp';--布局外边左距
        id="k3";
        layout_gravity="center|bottom",
        textColor='#ffffffff';--文本颜色
        textSize="20sp",
      },
    },
  },
}


adp=LuaAdapter(activity,aa)
list.Adapter=adp

function 打开网页(url)
  import "android.content.Intent"
  import "android.net.Uri"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end
function 刷新(url)
  adp.clear()
  tab={}
  Http.get(url or "http://www.todayonhistory.com/index.php" ,nil,nil,nil,function(code,content)
    if code==200 then
      --     content=content:gmatch([[&nbsp;—&nbsp;●&nbsp;</i></span>(.-)li class="circler]])
      content=content:gmatch([[&nbsp;—&nbsp;●&nbsp;</i></span>(.-)<li class="]])
      for i in content do
        local time=i:match("<span>(.-)年")
        local title=i:match([[title="(.-)"]])
        local img=i:match([[original="(.-)"]])
        local url=i:match([[<a href="(.-)"]])
        tab[title]=url
        if img~=nil then
          if img:find("http://www.todayonhistory.com") then
            adp.add{k1=time,k2=img,k3=title}
           else
            adp.add{k1=time,k2="http://www.todayonhistory.com"..img,k3=title}
          end
         else
          adp.add{k1=time,k3=title,k2="h"}
        end
      end
      adp.notifyDataSetChanged()
     else
      提示("网络未连接")
    end
  end)
end
刷新()
list.onItemClick=function(l,v,p,i)
  打开网页(tab[v.Tag.k3.Text])
  return true
end