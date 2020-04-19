require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"

import "mods.mod"
import "cn.hugo.android.scanner.decode.BitmapDecoder"


activity.setContentView(loadlayout("layout/qr_code"))
--设置滑动条&字体颜色
appp=activity.getWidth()
local kuan=appp/5.5
slide.setOnPageChangeListener(PageView.OnPageChangeListener{
  onPageScrolled=function(a,b,c)
    huat.setX(kuan*(b+a))
    if c==0 then
      if a==0 then
        tittle1.setTextColor(0xFFFFFFFF)
        tittle2.setTextColor(0xff808080)
      elseif a==1 then
        tittle1.setTextColor(0xff808080)
        tittle2.setTextColor(0xFFFFFFFF)
      end
    end
  end})

--按钮切换界面
window1.onClick=function()
  slide.showPage(0)
  弹出输入法()
end
window2.onClick=function()
  slide.showPage(1)
end

波纹(window1,0xffffffff)
波纹(window2,0xffffffff)


function CircleButton(view,InsideColor,radiu)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable() 
  drawable.setShape(GradientDrawable.RECTANGLE) 
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  view.setBackgroundDrawable(drawable)
end
角度=150
控件id=shengcheng
控件颜色=returntheme()
CircleButton(控件id,控件颜色,角度)

function CircleButton(view,InsideColor,radiu)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable() 
  drawable.setShape(GradientDrawable.RECTANGLE) 
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  view.setBackgroundDrawable(drawable)
end
角度=500
控件id=background
控件颜色=returntheme()
CircleButton(控件id,控件颜色,角度)

edit.setVisibility(View.GONE)
--fltBtn.setVisibility(View.GONE)
zhacai.setVisibility(View.GONE)
Qrcode.setVisibility(View.GONE)
--窗口2点击事件
up.onClick=function()
  edit.Text=""
  import "android.content.Intent"
  local intent= Intent(Intent.ACTION_PICK)
  intent.setType("image/*")
  this.startActivityForResult(intent, 1)
  -------
  function onActivityResult(requestCode,resultCode,intent)
    if intent then
      local cursor =this.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
      cursor.moveToFirst()
      import "android.provider.MediaStore"
      local idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
      fileSrc = cursor.getString(idx)
      bit = nil
      import "android.graphics.BitmapFactory"
    end
    --开始识别二维码
    if fileSrc == nil or fileSrc == "" then
      提示("请选择要识别的图片")
    else
      saom=BitmapDecoder(Result)
      nr=saom.getRawResult(loadbitmap(fileSrc))
      if nr~=nil then
        提示("获取成功")
        edit.Text=nr.toString();
        up.setVisibility(View.GONE)
        background.setVisibility(View.GONE)
        edit.setVisibility(View.VISIBLE)
        zhacai.setVisibility(View.VISIBLE)
      else
        提示("没有发现图中有二维码或条形码，获取失败")
        up.setVisibility(View.VISIBLE)
        background.setVisibility(View.VISIBLE)
        edit.setVisibility(View.GONE)
      end
    end 
  end
end

zhacai.onClick=function()
  edit.Text=""
  import "android.content.Intent"
  local intent= Intent(Intent.ACTION_PICK)
  intent.setType("image/*")
  this.startActivityForResult(intent, 1)
  -------
  function onActivityResult(requestCode,resultCode,intent)
    if intent then
      local cursor =this.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
      cursor.moveToFirst()
      import "android.provider.MediaStore"
      local idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
      fileSrc = cursor.getString(idx)
      bit = nil
      import "android.graphics.BitmapFactory"
    end
    --开始识别二维码
    saom=BitmapDecoder(Result)
    nr=saom.getRawResult(loadbitmap(fileSrc))
    if nr~=nil then
      提示("获取成功")
      edit.Text=nr.toString();
      up.setVisibility(View.GONE)
      background.setVisibility(View.GONE)
      edit.setVisibility(View.VISIBLE)
            tittle.setVisibility(View.VISIBLE)
    else
      提示("没有发现图中有二维码或条形码，获取失败")
      up.setVisibility(View.GONE)
      background.setVisibility(View.GONE)
      edit.setVisibility(View.VISIBLE)
      tittle.setVisibility(View.VISIBLE)
    end
  end
end

--窗口1点击事件
shengcheng.onClick=function()
  颜色(0xff000000)
  b=生成二维码(edit1.text)
  Qrcode.setImageBitmap(b)
  Qrcode.setVisibility(View.VISIBLE)
end

Qrcode.onLongClick=function()
  import "com.tencent.qq.widget.*"
  MyMenuDialog=MenuDialog(this);--设置弹窗进出动画
  MyMenuDialog.setButton("取消",MenuDialog.setTextColor.BLACK);--设置取消按钮文字及颜色
  MyMenuDialog.addItem("保存",MenuDialog.setTextColor.BLACK,--设置选项文字及颜色
  {onClick = function()
      function saveBitmapAsPng(bitmap, filePath)
        import "java.io.FileOutputStream"
        local out = FileOutputStream(filePath)
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, out);
        out.flush();
        out.close();
      end
      import "java.io.*"
      if File("/sdcard/轻工具箱/images/").isDirectory() then
      else
        import "java.io.File"--导入File类
        File("/sdcard/轻工具箱/images/").mkdir()
      end
      name=os.date("%Y-%m-%d-%H-%M-%S")
      saveBitmapAsPng(b,"/sdcard/轻工具箱/images/"..name..".png")
      提示("图片已成功保存至：/sdcard/轻工具箱/images/"..name..".png")

    end});
MyMenuDialog.addItem("分享",MenuDialog.setTextColor.BLACK,--设置选项文字及颜色
  {onClick = function()
      function saveBitmapAsPng(bitmap, filePath)
        import "java.io.FileOutputStream"
        local out = FileOutputStream(filePath)
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, out);
        out.flush();
        out.close();
      end
      import "java.io.*"
      if File("/sdcard/轻工具箱/images/").isDirectory() then
      else
        import "java.io.File"--导入File类
        File("/sdcard/轻工具箱/images/").mkdir()
      end
      name=os.date("%Y-%m-%d-%H-%M-%S")
      saveBitmapAsPng(b,"/sdcard/轻工具箱/images/"..name..".png")
      分享文件("/sdcard/轻工具箱/images/"..name..".png")
    end});
  MyMenuDialog.show();--显示弹窗
end

back.onClick=function()
  activity.finish()
end


导航栏颜色(returntheme())

通知栏颜色(returntheme())









