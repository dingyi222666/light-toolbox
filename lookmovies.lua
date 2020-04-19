require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "java.io.File"
import "com.lua.TbsWebView"
import "mods.func"
视频链接=...

通知栏颜色(returntheme())

layout=
{
  LinearLayout,
  layout_height="fill",
  layout_width="fill",
  background="#FFFFFF";
  orientation="vertical",
  {
    LinearLayout,
    layout_height="fill",
    layout_width="fill",
    orientation="vertical",
    {
      LinearLayout;
      orientation="vertical";
      layout_width='match_parent';
      layout_height='33%h';
      backgroundColor="#FF000000";
      id="text";
      Visibility=0;
      {
        LinearLayout;
        layout_width="match_parent";
        layout_height="33%h";
        gravity="center";
        {
          ImageView;--图片控件
          src='drawable/bf.png';--图片路径
          id="ks";
          layout_width='14%w';--图片宽度
          layout_height='8%h';--图片高度
          scaleType='fitXY';--图片显示类型
        };
      };
    };
    {
      TbsWebView;--浏览器控件
      layout_width='fill';--浏览器宽度
      layout_height='33%h';--浏览器高度
      id="WebView";
      Visibility=8;
    };
    {
      LinearLayout;
      orientation="vertical";
      layout_margin="8dp";
      layout_width="match_parent";
      layout_height="match_parent";
      id="xq";
      {
        TextView;
        textSize="16sp";
        id="bt";
        textColor="#FF000000";
      };
      {
        TextView;
        textSize="14sp";
        text="剧情介绍:";
        layout_marginTop="8dp";
        textColor="#FF000000";
      };
      {
        TextView;
        textSize="13sp";
        id="jj";
        textColor="#FF888888";
        layout_height="8%h";
        layout_width="fill";
        ellipsize="end";
        focusable="true";
        lines="3";
        focusableInTouchMode="true";
        onClick=function()
          AlertDialog.Builder(this)
          .setTitle("剧情简介")
          .setMessage(jj.Text)
          .setPositiveButton("确定",nil)
          .show()
        end,
      };
      {
        TextView;
        textSize="14sp";
        text="集数:";
        id="jjss";
        layout_marginTop="8dp";
        textColor="#FF000000";
      };
      {
        GridView;
        numColumns=4;--列数
        id="list1";
        layout_width="fill";
        layout_height="fill";
      };
    };
  };
};

activity.setContentView(loadlayout(layout))

function trim(str)
  return (string.gsub(str, "^%s*(.-)%s*$", "%1"))
end


function 播放显示()
  listx=
  {
    LinearLayout;
    layout_width="25%w";
    layout_height="9%h",
    {
      CardView;--卡片控件
      layout_margin='10dp';--卡片边距
      layout_gravity='center';--重力属性
      layout_width='match_parent';--卡片宽度
      layout_height='match_parent';--卡片高度   
      BackgroundDrawable=卡片细节(2,0xff333333,0xffffffff,20);
      {
        TextView;
        id="bfy";
        layout_width="match_parent";
        layout_height="match_parent";
        textSize="12sp",
        gravity="center";
      };
    };
  }
  bfadp=LuaAdapter(activity,listx)
  list1.setAdapter(bfadp)
end



header={
  ["User-Agent"]= "Mozilla/5.0 (Linux; U; Android 2.3.7; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1",
}
播放显示()

Http.get(视频链接,nil,"UTF-8",header,function(code,content)
  bt.Text=content:match([[名称：(.-)    </p>]])
  jj.Text=trim(content:match([[</h4>(.-)</div>]]))
  play=content:gmatch([[id="m3u8"(.-)</li>]])
  playtable={}
  looktable={}
  dianjitable={}
  for i in play do
    d=i:match("$(.-).m3u8")..".m3u8"
    table.insert(playtable,d)
    c=i:match([[javascript:show((.-));]]):match("'(.-)'")
    table.insert(looktable,c)
    dianjitable[c]=d
  end
  for k,v in pairs(looktable) do
    bfadp.add{bfy=v}
  end
end)

list1.onItemClick=function(l,v,p,i)
  text.setVisibility(8);
  WebView.setVisibility(0);
  jjss.Text="正在为您播放"..bt.Text..v.Tag.bfy.Text
  WebView.loadUrl(dianjitable[v.Tag.bfy.Text])
end