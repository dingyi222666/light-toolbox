require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
activity.setContentView(loadlayout("layout/random_raaper"))

导航栏颜色(returntheme())
通知栏颜色(returntheme())
function 收藏(m,x,sa)
  local z=读取文件(activity.getLuaDir("res/random_raaper.txt"))
  local s={}
  if #z>0 then
    s=load(table.concat({"return ",z}))()
  end
  s[m]=x
  if not(sa) then
    提示("收藏 "..m.." 成功")
  end
  io.open(activity.getLuaDir("res/random_raaper.txt"),"w"):write(dump(s)):close()
end
function 查看收藏()
  local z=读取文件(activity.getLuaDir("res/random_raaper.txt"))
  local s={}
  local zs={}
  if #z>0 then
    s=load(table.concat({"return ",z}))()
   else
    提示("暂无收藏")
    return
  end
  for k,v in pairs(s) do
    zs[#zs+1]=k
  end
  local djxjz=AlertDialog.Builder(this)
  .setTitle("查看收藏")
  .setItems(zs,{onClick=function(l,v)
      提示("已切换到 "..zs[v+1])
      title.setText(zs[v+1])
      text.setText(s[zs[v+1]])
      return true
  end})
  djxjz=圆角显示(djxjz)
  djxjz.getListView().onItemLongClick=function(l,v,p,l)
    local zjdj=AlertDialog.Builder(this)
    .setTitle("提示")
    .setMessage("是否要删除收藏: "..v.Text.." ?")
    .setPositiveButton("删除",{onClick=function(z)
        收藏(v.Text,nil,true)
        djxjz.dismiss()
    end})
    .setNeutralButton("取消",nil)
    圆角显示(zjdj)
    return true
  end
end
url="https://meiriyiwen.com/random/iphone"
function 随机一文()
  title.setText("")
  text.setText("")
  Http.get(url,nil,'utf8',nil,function(状态码,网页源码)
    if 状态码 == 200 then
      --过滤字符
      网页源码=网页源码:gsub("\n","")
      网页源码=网页源码:gsub(" ","")
      网页源码=网页源码:gsub("<p>","")
      网页源码=网页源码:gsub("</p>","\n\n")
      --标题
      bt=网页源码:match('<title>(.-)@每日一文官网</title>')
      --内容
      nr=网页源码:match('<divclass="articleContent">(.-)</div>')
      title.setText(bt)
      text.setText(nr)
     else
      提示('获取一文失败')
    end
  end)
end
随机一文()
suij.onClick=function()
  随机一文()
end