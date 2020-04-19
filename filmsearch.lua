require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "android.support.v4.widget.*"

activity.setContentView(loadlayout("layout/filmsearch"))


import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"
noting.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(returntheme(),PorterDuff.Mode.SRC_ATOP))

通知栏颜色(returntheme())

波纹(ssgb,0xffffffff)
波纹(ssss,0xffffffff)

sr.setColorSchemeColors({returntheme(),0xff000000});

sr.setOnRefreshListener(SwipeRefreshLayout.OnRefreshListener{onRefresh=function()
pcall(function()adp.clear();end);
    刷新()
    sr.setRefreshing(false);
  end})


header={
  ["User-Agent"]= "Mozilla/5.0 (Linux; U; Android 2.3.7; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1",
}

item={
  LinearLayout,
  orientation="vertical",
  layout_height="60dp",
  layout_width="fill",
  Gravity="center";
  {
    TextView,
    id="text2",
    layout_height="fill",
    layout_width="fill",
    layout_marginLeft='5dp';--布局左距    
    textSize="16sp",
    layout_gravity="center";
    textColor=0xff000000;
  },

}
--创建项目数组

function 刷新()
  tis.setVisibility(0);
  nono.setVisibility(8);
  listview.setVisibility(8);
  if ssbjk.Text~="" or #ssbjk.Text~=0 then
    url="https://wolongzy.net/search.html?searchword="..ssbjk.Text;
    Http.get(url,nil,"UTF-8",header,function(code,content)
      if code==200 then
        content=content:match([[<ul class="videoContent">(.-)</ul>]])
        content=content:gmatch([[370px;">(.-)</li>]])
         if content==nil then
            提示("暂无该影片的资源")            
         end
        tab={}
        tabname2={}
        tabname={}
        tabwebsite={}
        for i in content do
          table.insert(tab,i)
        end
        for v=1,#tab do
          sb=tab[v]
          name=sb:match([[(.+)&nbsp]])
          table.insert(tabname2,name)
          website="https://wolongzy.net"..tab[v]:match([[<a href="(.-).html"]])..".html"
          tabwebsite[name]=website
        end
        for w,z in pairs(tabname2) do         
          table.insert(tabname,{text2=z})
        end
        adp=LuaAdapter(activity,tabname,item)
        listview.Adapter=(adp)
        tis.setVisibility(8);
        nono.setVisibility(8);
        listview.setVisibility(0);
       else
        tis.setVisibility(8);
        nono.setVisibility(0);
        listview.setVisibility(8);
        text.Text=("搜索出错  "..code);
      end

    end)
   else
    提示("你还没有输入什么！")
    tis.setVisibility(8);
    nono.setVisibility(0);
    listview.setVisibility(8);
    text.Text=("你还没有输入什么！");
  end
end

ssss.onClick=function()
  刷新()
end

listview.onItemClick=function(l,v,p,i)
  activity.newActivity("lookmovies",{tabwebsite[v.Tag.text2.Text]})  
  return true
end