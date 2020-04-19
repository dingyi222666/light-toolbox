require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.*"
import "android.content.*"
import "android.provider.MediaStore"
import "java.lang.Integer"
import "com.androlua.*"
import "mods.func"
import "android.graphics.drawable.ColorDrawable"



--------------取色区设置---------------------


--全局变量
w=activity.width
h=activity.height
bmp=nil

--初始化坐标
zbx=w/2
zby=h/4

--bmp
bmp=Bitmap.createBitmap(w,h/2,Bitmap.Config.ARGB_4444)

----------------载入视图-----

载入页面("layout/palette")--//特殊原因插在这😂


page=luajava.override(PageView,{

  onInterceptTouchEvent=function(super,event)

    return false

  end,

  onTouchEvent=function(super,event)

    return false

  end

})


ll.addView(page)



local adp=ArrayPageAdapter()
page.setAdapter(adp)
adp.add(loadlayout("layout.palette_1"))
adp.add(loadlayout("layout.palette_2"))

-------------------------

function 取颜色亮度(color)
  local r=utf8.sub(color,3,4)
  local g=utf8.sub(color,5,6)
  local b=utf8.sub(color,7,8)
  function toint(e)--封装函数
    import 'java.lang.Long'
    return Long.parseLong(e, 16)
  end
  local grayLevel = toint(r) * 0.299 + toint(g) * 0.587 + toint(b) * 0.114;--RGB 模式转换成 YUV 模式，而 Y 是明亮度（灰阶），因此只需要获得 Y 的值而判断他是否足够亮就可以了
  if (grayLevel <= 192) then
    return true --黑
   else
    return false--白
  end
end

--点击按钮选择图片
a6.onClick=function()
  intent= Intent(Intent.ACTION_PICK)
  intent.setType("image/*")
  this.startActivityForResult(intent,1)
end


a4.onClick=function()
  pop=PopupMenu(activity,a3)
  menu=pop.Menu
  menu.add("#"..argb0x).onMenuItemClick=function(a)
    --先导入包
    import "android.content.*"
    activity.getSystemService(Context.CLIPBOARD_SERVICE).setText("#"..argb0x)
    提示("复制成功")
  end
  menu.add(argb).onMenuItemClick=function(a)
    import "android.content.*"
    activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(argb)
    提示("复制成功")
  end
  pop.show()--显示
end

--图片选择回调
function onActivityResult(requestCode,resultCode,intent)

  if intent then

    cursor =activity.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
    cursor.moveToFirst()
    idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
    fileSrc = cursor.getString(idx)
    文件状态=true
    --图片选择后的bitmap格式
    bitmap =BitmapFactory.decodeFile(fileSrc)

    --获取选择后的bitmap宽高
    bitw=bitmap.getWidth()
    bith=bitmap.getHeight()

    --图片如果过大,等比缩小到刚好适配
    function 等比无限缩小()
      while (true) do
        if bitw > w or bith > h/2 then
          bitw=bitw/1.1
          bith=bith/1.1
         else
          break
        end
      end
    end

    --等比修改后,bitmap宽高适配
    等比无限缩小()

    --将图片绘制到bmp中心
    rect=Rect(w/2-bitw/2,h/4-bith/2,bitw + w/2-bitw/2,bith+h/4-bith/2)

    --创建画布
    bmp=Bitmap.createBitmap(w,h/2,Bitmap.Config.ARGB_4444)

    mCanvas=Canvas(bmp)
    mPaint=Paint()
    mCanvas.drawBitmap(bitmap,nil, rect, mPaint);

    --显示
    iv.ImageBitmap=bmp

   else
    提示("未选择图片")
  end
end

myLuaDrawable=LuaDrawable(function(mCanvas,mPaint,mDrawable)

  --画笔属性
  mPaint.setAntiAlias(true)
  mPaint.setStyle(Paint.Style.STROKE)

  --外圆
  mPaint.setStrokeWidth(15)
  mPaint.setColor(0xFFADADAD)
  mCanvas.drawCircle(100, 100, 90, mPaint);

  --内圆
  mPaint.setStrokeWidth(20)
  mPaint.setColor(0xFF888888)
  mCanvas.drawCircle(100, 100, 75, mPaint);

  --十字架
  mPaint.setStrokeWidth(3)
  mPaint.setColor(0xFFA5A5A5)
  mCanvas.drawLine(100, 0+35, 100, 200-35,mPaint);
  mCanvas.drawLine(0+35, 100, 200-35, 100,mPaint);

end)

tv.background=myLuaDrawable

aa.onTouch=function(v,e)
  --event：事件

  if e.getAction()==2 then
    --初始化x轴seekbar属性
    sbx.setProgress(e.X);
    --初始化y轴seekbar属性
    sby.setProgress(e.Y);
  end
  return true
end

--初始化x轴seekbar属性
sbx.setMax(w-1);
sbx.setProgress(w/2);

--x轴seekbar监听
sbx.setOnSeekBarChangeListener{

  onProgressChanged=function(SeekBar,progress)

    zbx=progress

    tv.setTranslationX(progress-w/2)

    mColor = bmp.getPixel(zbx, zby)

    argb0x=Integer.toHexString(mColor)
    argb=tostring("0x"..(argb0x))
    if argb=="0x0" then
      提示("请勿移动超出此区域！")
     else
      --      a1.setBackgroundDrawable(ColorDrawable(int(argb)))
      a99.setBackgroundDrawable(ColorDrawable(int(argb)))
      a99.Text=(tostring(argb))
      if 取颜色亮度(argb0x) then
        a99.textColor=0xffffffff
       else
        a99.textColor=0xff000000
      end
    end
  end

}

--初始化y轴seekbar属性
sby.setMax((h/2)-1);
sby.setProgress(h/4);

--y轴seekbar监听
sby.setOnSeekBarChangeListener{

  onProgressChanged=function(SeekBar,progress)

    tv.setTranslationY(progress-h/4)

    zby=progress

    mColor = bmp.getPixel(zbx,zby)

    argb0x=Integer.toHexString(mColor)
    argb=tostring("0x"..(argb0x))
    if argb=="0x0" then
      提示("请勿移动超出此区域！")
     else
      --      a1.setBackgroundDrawable(ColorDrawable(int(argb)))
      a99.setBackgroundDrawable(ColorDrawable(int(argb)))
      a99.Text=(tostring(argb))
      if 取颜色亮度(argb0x) then
        a99.textColor=0xffffffff
       else
        a99.textColor=0xff000000
      end
    end
  end
}

a6.foreground=转波纹色(0x5FFFFFFF);
a4.foreground=转波纹色(0x5FFFFFFF);
a99.foreground=转波纹色(0x5FFFFFFF);
----------调色区设置--------------------------


主色=0xff1e8ae8;
副色=0xFFd68189;
文字色=0xffffffff;
警告色=0xff60c5ba;
背景底层色=0xfff1f1f1;
背景顶层色=0xffffffff;
左侧栏项目色=0xFFa3a1a1;

拖动一.setMax(255)
拖动二.setMax(255)
拖动三.setMax(255)
拖动四.setMax(255)
拖动一.setProgress(0xff)
拖动二.setProgress(0x1e)
拖动三.setProgress(0x8a)
拖动四.setProgress(0xe8)
--监听
拖动一.setOnSeekBarChangeListener{
  onProgressChanged=function(view, i)
    updateArgb()
  end
}

拖动二.setOnSeekBarChangeListener{
  onProgressChanged=function(view, i)
    updateArgb()
  end
}

拖动三.setOnSeekBarChangeListener{
  onProgressChanged=function(view, i)
    updateArgb()
  end
}

拖动四.setOnSeekBarChangeListener{
  onProgressChanged=function(view, i)
    updateArgb()
  end
}
--更新颜色
function updateArgb()
  local a=拖动一.getProgress()
  local r=拖动二.getProgress()
  local g=拖动三.getProgress()
  local b=拖动四.getProgress()
  local argb_hex=(a<<24|r<<16|g<<8|b)
  颜色文本.Text=string.format("%#x", argb_hex)
  卡片图.setCardBackgroundColor(argb_hex)
end

卡片图.onLongClick=function()
  b=颜色文本.Text
  b=b:match("0x(.+)")
  b="#"..b
  items={颜色文本.Text,b}
  AlertDialog.Builder(this)
  .setTitle("选择颜色")
  .setItems(items,{onClick=function(l,v) 写入剪贴板(items[v+1]) 提示("复制成功") end})
  .show();
end

拖动条颜色(拖动一,0xff000000)
拖动条颜色(拖动二,0xffff0000)
拖动条颜色(拖动三,0xFF1DE9B6)
拖动条颜色(拖动四,0xFF6699FF)


--页面文件配置---------------

appp=activity.getWidth()
local kuan=appp/5.5
page.setOnPageChangeListener(PageView.OnPageChangeListener{
  onPageScrolled=function(a,b,c)
    huat.setX(kuan*(b+a))
    if c==0 then
      if a==0 then
        tittle1.setTextColor(0xFFFFFFFF)
        tittle2.setTextColor(0xFF757575)
       elseif a==1 then
        tittle1.setTextColor(0xFF757575)
        tittle2.setTextColor(0xFFFFFFFF)
        --        提示帮助()
      end
    end

  end})


--按钮切换界面
window1.onClick=function()
  page.showPage(0)
end
window2.onClick=function()
  page.showPage(1)
  提示帮助()
end


back.onClick=function()
  activity.finish()
end


导航栏颜色(returntheme())

通知栏颜色(returntheme())


window1.foreground=转波纹色(0x5FFFFFFF);

window2.foreground=转波纹色(0x5FFFFFFF);