require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "json"

activity.setContentView(loadlayout("layout/a_brief_remark"))

function getAncientPoetry(shouldPrintIfFalse,isOnCreate)
  Http.get("https://api.gushi.ci/all.json",function(code,cont)
    if code == 200 then
      gushiContent.getChildAt(2).text=((json.decode(tostring(cont)))["content"])
      gushiContent.getChildAt(0).text=((json.decode(tostring(cont)))["origin"])
      gushiContent.getChildAt(1).text=((json.decode(tostring(cont)))["author"])
      gushiCopy.setVisibility(0)
     else
      if shouldPrintIfFalse~=false then
        提示("无法获取古诗内容 "..code)
      end
      if gushiContent.getChildAt(0).text==" " then
        gushiCopy.setVisibility(8)
      end
      if isOnCreate then
        gushiContent.getChildAt(2).text=" "
        gushiContent.getChildAt(0).text=" "
        gushiContent.getChildAt(1).text="无法获取古诗词内容"
      end
    end
  end)
end

function 获取一言(shouldPrintIfFalse,isOnCreate)
  Http.get("https://v1.hitokoto.cn/",nil,"utf8",nil,function(code,content)
    if code==200 then
      cjson=require "json"
    content=cjson.decode(content)
    text=content["hitokoto"]
    by=content["from"]    
      yiyantext.setText(tostring(text.."\n---"..by))
      yiyanCopy.setVisibility(0)
     else
      if shouldPrintIfFalse~=false then
        提示("无法获取一言内容 "..code)
      end
      if yiyantext.text=="无法获取一言内容" or yiyantext.text==" " then
        yiyanCopy.setVisibility(8)
      end
      if isOnCreate then
        yiyantext.setText("无法获取一言内容")
      end
    end
  end)
end

function 获取毒鸡汤(shouldPrintIfFalse,isOnCreate)
  Http.get("http://www.nows.fun/",nil,"utf8",nil,function(code,content)
    if code==200 then
    yiyanResult=content:match([[2rem;">(.-)</span>]])
      dujiContent.setText(tostring(yiyanResult))
      dujiCopy.setVisibility(0)
     else
      if shouldPrintIfFalse~=false then
        提示("无法获取毒鸡汤内容 "..code)
      end
      if dujiContent.text=="无法获取毒鸡汤内容" or dujiContent.text==" " then
        dujiCopy.setVisibility(8)
      end
      if isOnCreate then
        dujiContent.setText("无法获取毒鸡汤内容")
      end
    end
  end)
end

getAncientPoetry(false,true)
获取一言(false,true)
获取毒鸡汤(false,true)


通知栏颜色(returntheme())
导航栏颜色(returntheme())