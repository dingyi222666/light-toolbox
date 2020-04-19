require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "android.app.*"
import "android.os.*"

import "android.app.ActionBar"
import "android.graphics.drawable.ColorDrawable"

import "android.graphics.Bitmap"
import "java.io.FileOutputStream"
import "java.io.File"
import "android.content.Intent"
import "android.provider.MediaStore"
import "android.graphics.BitmapFactory"
import "android.graphics.Canvas"
import "android.graphics.Paint"

import "Pretend"
pcall(function()导航栏颜色(returntheme())end)
pcall(function()通知栏颜色(returntheme())end)
this.setContentView(loadlayout(
{
  LinearLayout;
  layout_height="fill";
  orientation="vertical";
  layout_width="fill";
  {
    LinearLayout;
    BackgroundColor=returntheme();
    layout_height="0";
    layout_width="fill";
    elevation="2dp";
    id="status_bar";
  };
  {
    LinearLayout;
    BackgroundColor=returntheme();
    orientation="horizontal";
    layout_width="fill";
    layout_height="55dp";
    elevation="2dp";
    {
      LinearLayout;
      layout_width="55dp";
      gravity="center";
      layout_height="55dp";
      id="menu";
      onClick=function()
        activity.finish()
      end,
      foreground=转波纹色(0x20ffffff);
      {
        ImageView;
        src="image/left.png";
        layout_width="25dp";
        colorFilter="#ffffffff";
        layout_height="25dp";
        id="menu2"
      };
    };
    {
      LinearLayout;
      layout_height="fill";
      layout_weight="1";
      orientation="horizontal";
      {
        TextView;
        text="图片拼接";
        --layout_marginLeft='20dp';--布局左距
        textColor="#ffffffff";
        textSize="18sp";
        layout_gravity="center";
      };
    };
    {
      LinearLayout;
      layout_width="55dp";
      gravity="center";
      layout_height="55dp";
      id="add";
      onClick=function()
        local intent= Intent(Intent.ACTION_PICK)
        intent.setType("image/*")
        this.startActivityForResult(intent, 1)
        function onActivityResult(requestCode,resultCode,intent)
          if intent then
            local cursor =this.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
            cursor.moveToFirst()
            local idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
            local fileSrc = cursor.getString(idx)
            adp.add{img=fileSrc}
            bit=nil
            bit =BitmapFactory.decodeFile(fileSrc)
          end
        end
      end,
      foreground=转波纹色(0x20ffffff);
      {
        ImageView;
        src="image/add_black.png";
        layout_width="25dp";
        colorFilter="#ffffffff";
        layout_height="25dp";

      };
    };
    {
      LinearLayout;
      layout_width="55dp";
      gravity="center";
      layout_height="55dp";
      id="ojbk";
      onClick=function()
        if #data==0 then
          提示("请添加图片")
         elseif #data<2 then
          提示("至少添加2张图片")
         elseif #data>=2 then
          local h=0
          local w=0
          local hw={}
          AlertDialog.Builder(this)

          .setMessage("请选择拼接方向")
          .setPositiveButton("横向拼接",{onClick=function(v)
              for k,v in ipairs(data) do
                src=BitmapFactory.decodeFile(v.img)
                h=h+src.getHeight()
                w=w+src.getWidth()
                hw[k]=src.getHeight()
                src.recycle()
              end
              table.sort(hw)
              h=hw[#hw]
              bmp = Bitmap.createBitmap(w, h, src.getConfig());
              paint = Paint();
              canvas = Canvas(bmp);
              h=0
              w=0
              hw={}
              for k,v in ipairs(data) do
                h=0
                src=BitmapFactory.decodeFile(v.img)
                w=w+src.getWidth()
                canvas.drawBitmap(src,w-src.getWidth(),h,paint)
                src.recycle()
              end
              local suiji = math.random(10000,99999999)
              SavePicture("/sdcard/轻工具箱/图片拼接/"..suiji..".png",bmp)

            end})
          .setNegativeButton("纵向拼接 ",{onClick=function(v)
              for k,v in ipairs(data) do
                src=BitmapFactory.decodeFile(v.img)
                h=h+src.getHeight()
                w=w+src.getWidth()
                hw[k]=src.getWidth()
                src.recycle()
              end
              table.sort(hw)
              w=hw[#hw]
              bmp = Bitmap.createBitmap(w, h, src.getConfig());
              paint = Paint();
              canvas = Canvas(bmp);
              h=0
              w=0
              for k,v in ipairs(data) do
                w=0
                src=BitmapFactory.decodeFile(v.img)
                h=h+src.getHeight()
                canvas.drawBitmap(src,w,h-src.getHeight(),paint)
                src.recycle()
              end
              local suiji = math.random(10000,99999999)
              SavePicture("/sdcard/轻工具箱/图片拼接/"..suiji..".png",bmp)
            end})
          .show()
        end
      end,
      foreground=转波纹色(0x20ffffff),
      {
        ImageView;
        src="image/check_black.png";
        layout_width="25dp";
        colorFilter="#ffffffff";
        layout_height="25dp";

      };
    };
  };
  {
    GridView;
    layout_marginTop="3dp",--布局顶距
    layout_width="fill";
    id="grid";
    numColumns=3;
    layout_height="fill";
  };
}))

function SavePicture(name,bm)
  dialog = ProgressDialog.show(this,"","正在加载中")
  task(function(name,bm)
    require "import"
    import "mods.func"
    if bm then
      name=tostring(name)
      f = File(name)
      out = FileOutputStream(f)
      bm.compress(Bitmap.CompressFormat.PNG,90, out)
      out.flush()
      out.close()
      return name
     else
      return false
    end
    
  end,name,bm,function(e)
  提示("已保存到"..e)
  dialog.dismiss()
  end)
end
data={}
adp=LuaAdapter(activity,data,{
  LinearLayout;
  gravity="center";
  {
    AbsoluteLayout;
    id="bc";
    layout_width="30%w";
    layout_height="30%w";
    {
      ImageView;
      layout_x="0dp";
      layout_y="0dp";
      id="img";
      layout_width="fill";
      layout_height="fill";
    };

  };
})



grid.Adapter=adp

grid.onItemLongClick=function(parent,v,pos,id)
  adp.remove(pos)
end