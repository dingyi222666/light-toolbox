require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"

通知栏颜色(returntheme())

layout={
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  layout_height="fill",
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
        text="选择目标语言";
      };

    };

  };
  {
    ListView,
    layout_width="fill",
    layout_height="fill",
    id="list",
    dividerHeight="1",
  },
}


items={
  TextView,
  layout_width="fill",
  layout_height="60dp",
  Gravity="center|left",
  paddingLeft="40",
  textColor="#808080",
  textSize="15",
  id="name"
}

activity.setContentView(loadlayout(layout))

--去滑条
list.setVerticalScrollBarEnabled(false)

maxText={"自动检测","中文","英文","日文","韩文","法文","俄文","西班牙文"}


数据={}

for i=1,#maxText do
  table.insert(数据,{name=maxText[i]})
end

adp=LuaAdapter(activity,数据,items)
list.setAdapter(adp)

list.setOnItemClickListener(AdapterView.OnItemClickListener{
  onItemClick=function(parent,v,pos,id)
    activity.result{maxText[pos+1]}
    activity.finish()
  end
})




