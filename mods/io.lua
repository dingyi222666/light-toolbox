require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "res.strings"


if 是否存在文件夹(主文件夹路径) then
 else
  创建文件夹(主文件夹路径)
end


if 是否存在文件夹(文字文件夹路径) then
 else
  创建文件夹(文字文件夹路径)
end

if 是否存在文件夹(缓存文件夹路径) then
 else
  创建文件夹(缓存文件夹路径)
end

if 是否存在文件(随手记文件路径) then
 else
  创建文件(随手记文件路径)
end

if 是否存在文件(全屏时钟文件路径) then
  else
  创建文件(全屏时钟文件路径)
  写入文件(全屏时钟文件路径,"#FFFFFFFF")
end

if File(主题文件路径).exists() then
  else
  File(主题文件路径).createNewFile()
  io.open(主题文件路径,"w+"):write("0xFF12B8F6"):close()  
end

if 是否存在文件夹(下载文件夹) then
  else
  创建文件夹(下载文件夹)
end

if 是否存在文件夹(下载图片文件夹) then
  else
  创建文件夹(下载图片文件夹) 
end

if 是否存在文件夹(图片拼接文件夹) then
  else
  创建文件夹(图片拼接文件夹) 
end

if 是否存在文件夹(下载视频文件夹) then
  else
  创建文件夹(下载视频文件夹) 
end



if 是否存在文件夹(更新下载文件夹) then
 else
  创建文件夹(更新下载文件夹)
end