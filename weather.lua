require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "com.tencent.qq.widget.*"
import "android.view.WindowManager"
url="https://m.tianqi.com/"
Http.get(url,nil,"utf8",nil,function(code,content,cookie,header)
  if(code==200 and content)then
    con=content
    cs=content:match("<text>(.-)</text>")
    wd=content:match('<span class="b2"><i></i>湿度(.-)</span')
    fx=content:match('<span class="b3"><i></i>(.-)</span>')
    ds=content:match('<dd class="now">(.-)<i>')
    zk=content:match('<dd class="txt">(.-)</dd>')
    tu=content:match('<dt><img src="(.-)"></dt>')
    gx=content:match('<text id="nowHour">(.-)</text>')
    kx=content:match([[class="b1"><i></i>(.-)</a>
]])

    help=("城市:"..cs.."\n今日天气:"..zk.."\n温度:"..ds.."\n湿度:"..wd.."\n风力:"..fx.."\n空气质量:"..kx.."\n 来自轻工具箱的分享")

    aa=
    {
      LinearLayout;
      orientation="vertical";
      layout_width="fill";
      layout_height="fill";
      background="#44000000";
      gravity="center";
      id="aaa";
      onClick=function()
        pop=PopupMenu(activity,show)
        menu=pop.Menu
        menu.add("查看天气详细信息").onMenuItemClick=function(a)
          打开网页("https://m.tianqi.com/","普通","天气",nil,nil)
        end
        menu.add("复制天气信息").onMenuItemClick=function(a)
          写入剪贴板(help)
          提示("已复制")
        end
        menu.add("分享天气信息").onMenuItemClick=function(a)
          分享文字(help)
        end
        pop.show()--显示
      end,
      OnTouchListener={
        onTouch=function(v,e)
          show.x=e.x
          show.y=e.y
        end,
      },
      {
        View,
        id="show",
        Visibility=8,
      },
      {
        LinearLayout;
        orientation="horizontal";
        layout_width="fill";
        layout_height="30%h";
        gravity="center";
        {
          LinearLayout;
          layout_gravity="center";
          {
            ImageView;
            scaleType="fitXY";
            id="wtricon";
            src=("https://m.tianqi.com/"..tu);
            layout_height="45dp";

            layout_width="45dp";
          };
        };
        {
          LinearLayout;
          layout_height="10%h";
          orientation="vertical";
          layout_width="30%w";
          {
            LinearLayout;
            orientation="vertical";
            layout_marginLeft="8dp";
            layout_gravity="center";
            {
              LinearLayout;
              orientation="horizontal";
              {
                TextView;
                textSize="30sp";
                text=(ds.."℃");
                textColor="#ffffff";
              };

            };
            {
              TextView;
              textSize="12sp";

              text=(zk);

              layout_marginTop="-5dp";
            };
          };
        };
      };
      {
        LinearLayout;
        layout_height="10%h";
        orientation="horizontal";
        layout_width="fill";
        gravity="left";
        {
          TextView;
          text=("城市:"..cs);layout_marginLeft="20dp";
        };
        {
          TextView;
          text=("空气质量:"..kx);
          layout_marginLeft="5dp";
        };
        {
          TextView;
          text=("湿度:"..wd);
          layout_marginLeft="5dp";
        };
        {
          TextView;
          text=("风力:"..fx);
          layout_marginLeft="5dp";
        };
      };
    };

    activity.setContentView(aa)

  end
end)