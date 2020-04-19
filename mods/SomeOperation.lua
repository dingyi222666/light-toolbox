import "mods.func"
import "android.content.Context"
import "java.io.*"
import "android.graphics.drawable.GradientDrawable"
import "android.text.Html"


波纹(menu,0x5FFFFFFF)
波纹(search_func,0x5FFFFFFF)
波纹(dian1,0x44000000)
波纹(dian2,0x44000000)
波纹(dian3,0x44000000)
波纹(dian4,0x44000000)
波纹(dian5,0x44000000)
波纹(dian6,0x44000000)
波纹(dian7,0x44000000)
波纹(dian8,0x44000000)

--按
dian1.onClick=function ()
  activity.newActivity("function",{"常用","one"})--跳转页面
end
dian2.onClick=function ()
  activity.newActivity("function",{"实用","two"})--跳转页面

end
dian3.onClick=function ()
  activity.newActivity("function",{"有趣","three"})--跳转页面
end
dian4.onClick=function ()
  activity.newActivity("function",{"玩机","four"})--跳转页面
end
dian5.onClick=function ()
  if 检测是否安装软件("com.Light.toolbox.game") then
    打开app("com.Light.toolbox.game")
   else
    activity.newActivity("function",{"游戏","five"})--跳转页面
  end
end
dian6.onClick=function ()
  activity.newActivity("function",{"阅读","six"})--跳转页面
end
dian7.onClick=function ()
  activity.newActivity("function",{"音乐","seven"})--跳转页面
end
dian8.onClick=function ()
  activity.newActivity("function",{"直播","eight"})--跳转页面
end

dian9.onClick=function ()
  activity.newActivity("function",{"影视","nine"})--跳转页面
end

dian10.onClick=function ()
  activity.newActivity("function",{"新闻","ten"})--跳转页面
end

dian11.onClick=function ()
  activity.newActivity("function",{"其他","eleven"})--跳转页面
end

dian12.onClick=function ()
  activity.newActivity("function",{"会员","vip"})--跳转页面
end


menu.onClick=function()
  sidear.openDrawer(3)
end

--设置滑动条&字体颜色
appp=activity.getWidth()
local kuan=appp/4
huadong.setOnPageChangeListener(PageView.OnPageChangeListener{
  onPageScrolled=function(a,b,c)
    if c==0 then      
      for i=0,bottom.getChildCount()-1 do
        if i==a then
          bottom.getChildAt(i).setAlpha(1)
         else
          bottom.getChildAt(i).setAlpha(0.35)
        end
      end

    end
  end})


ji_png.onClick=function(l,v)
  pop=PopupMenu(activity,l)
  menu=pop.Menu
  menu.add("保存").onMenuItemClick=function(a)
    保存随手记内容()
    提示("保存成功!")
  end
  menu.add("分享").onMenuItemClick=function(a)
    分享文字(Chronicle.Text)
  end

  menu.add("清空").onMenuItemClick=function(a)
    Chronicle.Text=""
    提示("清空成功")
  end

  pop.show()--显示
end

--Pageview动画需要导入此包
import'android.widget.PageView$PageTransformer'

默认参数 = 0.75--设置默认参数，后面计算动画参数
--Pageview官方动画函数
huadong.setPageTransformer(true,PageTransformer{--获取到Pageview的位置
  transformPage = function(view,position)
    pageWidth = view.getWidth()
    if position<-1 then
      view.setAlpha(0)--设置透明度
     elseif position<=0 then
      view.setAlpha(1)
      view.setTranslationX(0)--设置偏移量(X轴平移)
      view.setScaleX(1)--设置X轴缩放
      view.setScaleY(1)--设置Y轴缩放
     elseif position<=1 then
      view.setAlpha(1-position)
      view.setTranslationX(pageWidth*-position)
      动画参数 = 默认参数+(1-默认参数)*(1-Math.abs(position))--动态计算动画参数
      view.setScaleX(动画参数)
      view.setScaleY(动画参数)
     else
      view.setAlpha(0)
    end
  end
})

function CircleButton(view,InsideColor,radiu)
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  view.setBackgroundDrawable(drawable)
end
角度=50
控件id=handwriting
控件颜色=0x00000000
--CircleButton(控件id,控件颜色,角度)