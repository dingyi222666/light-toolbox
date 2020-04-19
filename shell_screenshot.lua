require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "res.strings"
import "mods.func"

载入页面("layout/shell_screenshot")

import "android.graphics.Bitmap"
import "android.view.WindowManager"
import "android.widget.PopupMenu"
import "android.widget.FrameLayout"
import "java.io.FileOutputStream"
import "java.io.File"
import "android.net.Uri"
import "android.content.Intent"
import "android.graphics.PorterDuff"
import "android.graphics.PorterDuffColorFilter"
import "android.content.res.ColorStateList"
import "android.graphics.BitmapFactory"
import "android.provider.MediaStore"

--activity.setContentView(loadlayout"layout")
local attrsArray = {android.R.attr.selectableItemBackgroundBorderless}
local typedArray =activity.obtainStyledAttributes(attrsArray)
ripple=typedArray.getResourceId(0,0)
function mmp(颜色)
  return ColorStateList(
  int[0].class{int{}},
  int{颜色})
end
function ly(颜色)
  local bck=Button(activity).background
  bck.setColor(mmp(颜色))
  return bck
end


local sdk = Build.VERSION.SDK_INT
if sdk >= 19 then
  local lp = chenjin.getLayoutParams()
  lp.height =activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height )
  chenjin.setLayoutParams(lp)
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
 else
  chenjin.setVisibility(View.GONE)
end

local fd=io.open("/sdcard/轻工具箱/带壳截图/")
if fd == nil then
  os.execute("mkdir /mnt/sdcard/轻工具箱/带壳截图/")
end


tp.onClick=function()
  import "android.content.Intent"
  local intent= Intent(Intent.ACTION_PICK)
  intent.setType("image/*")
  this.startActivityForResult(intent,1)
end

w=activity.width
h=activity.height

function onActivityResult(requestCode,resultCode,intent)
  if intent then
    bit=nil
    uri=tostring(intent.getData())--轉成字符串

    local cursor=this.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
    cursor.moveToFirst()
    local curcoulumn=cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
    local curstring=cursor.getString(curcoulumn)
    ActivityResultBitmap=BitmapFactory.decodeFile(curstring)
    if ActivityResultBitmap then
      if ActivityResultBitmap.width>w then
        local o,i=ActivityResultBitmap.width,ActivityResultBitmap.height
        local s=w/o        
        ActivityResultBitmap=Bitmap.createScaledBitmap(ActivityResultBitmap,o*s,i*s,false)
      end
     
      tp.setImageBitmap(ActivityResultBitmap)
    end
  end
  
  zbg=ActivityResultBitmap.height
  zbk=ActivityResultBitmap.width
  y=ActivityResultBitmap.getPixel(zbk/2,zbg/2)
  r.backgroundColor=y
  r2.backgroundColor=y
  r3.backgroundColor=y
  return true
end
function shot()
  fltBtn.setVisibility(View.GONE)
  view =activity.getWindow().getDecorView();
  display=activity.getWindowManager().getDefaultDisplay();
  view.layout(0, 0, display.getWidth(), display.getHeight());
  view.setDrawingCacheEnabled(true)
  --允许当前窗口保存缓存信息，这样getDrawingCache()方法才会返回一个Bitmap
  bmp = Bitmap.createBitmap(view.getDrawingCache());
  return bmp
end

function fx()
  intent = Intent();
  intent.setAction(Intent.ACTION_SEND);
  intent.putExtra(Intent.EXTRA_STREAM,"/sdcard/轻工具箱/带壳截图/123.png");
  intent.setType("image/png");
  activity.startActivity(Intent.createChooser(intent,"分享图片"));
end


function hh(mz)
  local bd=shot()
  local f=File("/sdcard/轻工具箱/带壳截图/"..mz)
  f.createNewFile();
  local fd=FileOutputStream(f);
  if bd.compress(Bitmap.CompressFormat.PNG,90,fd)~=nil then
    fd.close();
  end
  fltBtn.setVisibility(View.VISIBLE)
end
function bc()
  local mz=os.time()..".png"
  fltBtn.setVisibility(View.GONE)
  hh(mz)
  提示("已保存到 /sdcard/轻工具箱/带壳截图/"..mz)
  fltBtn.setVisibility(View.VISIBLE)

end
function ysjb()
  import "android.graphics.drawable.GradientDrawable"

  for u=1,100 do
    jjb=bit.getPixel(zbk/2-u,zbg/2-u)
    jjbb=bit.getPixel(zbk-u,zbg-u)
    if y~=jjb and y~=jjbb and jjbb~=jjb then
      break
    end
  end
  g=GradientDrawable(GradientDrawable.Orientation.BOTTOM_TOP,
  {jb,jjb,jjbb})
  r.background=g
end

function szbj()
  bj={"渐变","粉红","白","靛蓝色","青绿色","青色","酸橙色","亮蓝","深紫"}
  AlertDialog.Builder(this)
  .setTitle("颜色")
  .setItems(bj,{onClick=function(l,v)
      dm={
        "0xFFE91E63",
        "0xFFFFFFFF",
        "0xFF3F51B5",
        "0xFF009688",
        "0xFF0097A7",
        "0xFFCDDC39",
        "0xFF03A9F4",
        "0xFF673AB7"
      }
      if ActivityResultBitmap ~= nil then
        for i=1,#dm do
          if v==i then
            r.backgroundColor=tonumber(dm[i])
            r2.backgroundColor=tonumber(dm[i])
            r3.backgroundColor=tonumber(dm[i])
            break
          end

        end
        if v==0 then
          ysjb()
        end
       else
        提示("请选择图片")
      end
    end})
  .show()
end