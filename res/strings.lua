require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

屏幕宽度=activity.getWidth()
屏幕高度=activity.getHeight()




卡片标题栏宽=activity.getWidth()/1.75

主文件夹路径="/sdcard/轻工具箱"

文字文件夹路径=主文件夹路径.."/text"

缓存文件夹路径=主文件夹路径.."/tmp"

随手记文件路径=缓存文件夹路径.."/handwriting.txt"

运行代码缓存文件=缓存文件夹路径.."/qks.lua"

收藏文件路径=activity.getLuaDir().."/res/collection.txt"

夜间JS文件路径=activity.getLuaDir().."/res/js.txt"

接口文件路径=activity.getLuaDir().."/res/jiekou.txt"

收藏缓存路径=缓存文件夹路径.."/collection.tmp"

主题文件路径=缓存文件夹路径.."/theme.tmp"

全屏时钟文件路径=缓存文件夹路径.."/full_screen_clock.tmp"

下载文件夹=主文件夹路径.."/downloads"

更新下载文件夹=下载文件夹.."/updateapk"

图片拼接文件夹=主文件夹路径.."/图片拼接"

下载图片文件夹=下载文件夹.."/image"

QQ空间代码地址=activity.getLuaDir().."/res/qzonecode.txt"


下载视频文件夹=下载文件夹.."/video/"


imagedate={--壁纸数据表
  "http://image.coolapk.com/picture/2019/0703/15/1635509_9931_8685@1920x1920.jpg.m.jpg",
  "http://image.coolapk.com/picture/2019/0703/15/1635509_9937_87@1995x1083.jpg.m.jpg",
  "http://image.coolapk.com/picture/2019/0703/15/1635509_9973_4049@2560x1600.jpg.m.jpg",
  "http://image.coolapk.com/picture/2019/0716/02/747505_4977_3819@2458x1360.jpg.m.jpg",
  "http://image.coolapk.com/picture/2019/0716/02/747505_4972_8124@2630x1324.jpg.m.jpg",
  "http://image.coolapk.com/picture/2019/0703/15/1635509_9958_27@3920x1750.jpg.m.jpg",
  "http://image.coolapk.com/picture/2019/0714/11/1092580_6710_763@1920x1080.jpg.m.jpg",
  "http://image.coolapk.com/picture/2019/0519/10/1203835_3934_9913@1920x1080.jpg.m.jpg",
}


function 读取主题()
  if File(主题文件路径).exists() then
    if io.open(主题文件路径):read("*a") then
      return tonumber(io.open(主题文件路径):read("*a"))
     else
      return 0xFF12B8F6
    end
  end
end

theme_list={"默认","深灰","翠绿","西柚","茶褐","自定义"}
theme_main={0xFF12B8F6,0xff444444,0xFF2EC4B6,0xFFEE7785,0xFF9B8281,读取主题()}