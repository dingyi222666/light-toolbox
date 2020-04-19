require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

import "java.io.File"
import "mods.func"
--activity.setTitle('AndroLua+')
--activity.setTheme(android.R.style.Theme_Holo_Light)
activity.setContentView(loadlayout({
  LinearLayout;
  layout_height="fill";
  orientation="vertical";
  layout_width="fill";
  BackgroundColor=0xFF7ABD9A;
  {
    LinearLayout;
    gravity="center";
    id="mo";
    layout_width="fill";
    layout_weight="1";
    orientation="vertical";
    layout_height="fill";
    {
      LinearLayout;
      id="background";
      gravity='center';
      layout_width='70%w';
      layout_height='70%w';
      orientation='vertical';
      layout_gravity='center_horizontal';
      BackgroundColor="#FFAED8C0";
      {
        CardView;
        radius='28%w';
        elevation='0dp';
        layout_width='55%w';
        layout_height='55%w';
        layout_gravity='center';
        CardBackgroundColor="0xFFDFEEE7";
        {
          LinearLayout;
          id="up";
          gravity='center';
          layout_width='fill';
          layout_height='fill';
          orientation='vertical';
          layout_marginTop="-8dp";
          layout_marginLeft="-8dp";
          layout_marginRight="-8dp";
          layout_marginBottom="-8dp";
          layout_gravity='center_horizontal';
          style="?android:attr/borderlessButtonStyle";
          {
            TextView;
            gravity="center";
            textColor=0xFF7ABD9A;
            layout_marginBottom="5dp";
            id="mf";
            TextSize="13sp";
            text="0.00dB";
            paddingLeft="10dp";
          };
        };
      };
    };
    {
      TextView;
      gravity="bottom";
      textColor=0xFFFFFFFF;
      layout_marginTop="80dp";
      id="mfq";
      text="jdsjj";
      TextSize="13sp";
      text="";
      paddingLeft="10dp";
    };
  };

}))

isRun=true
import "android.animation.ObjectAnimator"


bst=function(b)
  local b=tointeger(b)
  mf.Text=tostring(tointeger(b).." DB")
  if b<=30 then
    mfq.Text="静谧之地，宜学习看书。"
   elseif b>30 and b<50 then
    mfq.Text="环境正常。"
   elseif b>=50 and b<=70 then
    mfq.Text="聒噪的环境。"
   elseif b>70 and b<100 then
    mfq.Text="喧嚣的环境，建议远离。"
   elseif b>=100 then
    mfq.Text="过度喧嚣的环境，建议马上远离。"
  end
end

function bsk()
  require "import"
  import "java.io.File"
  compile "libs/classes2"
  import "com.dingyi.soundmeter.*"
  if not mRecorder then
    mRecorder=MyMediaRecorder()--创建录音对象
    file=FileUtil.createFile("temp.amr")--创建缓存录音
    file=File(tostring(file))
    mRecorder.setMyRecAudioFile(file);--设置缓存录音
    if not (mRecorder.startRecorder()) then--启动录音,返回布尔值
      call("提示","启动失败 ")
     
    end
  end
  if activity.get("isRun")==false then
    mRecorder.delete()
    mRecorder=nil
    File("/storage/emulated/0/SoundMeter/temp.amr").delete()--删除缓存文件
  end
  while activity.get("isRun") do
    volume = mRecorder.getMaxAmplitude();--获取声压
    if(volume > 0 && volume < 1000000) then
      call("bst",World.setDbCount(20 * (Math.log10(volume)))); --//将声压值转为分贝值
    end
    Thread.sleep(250)
  end

end
thread(bsk)
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
控件颜色=0xFFAED8C0
CircleButton(控件id,控件颜色,角度)


function onKeyDown(code,event)
  if code==event.KEYCODE_BACK then
    isRun=false
    activity.finish()
    return true
  end
end


function onResume()
  if not isRun then
    isRun=true
    thread(bsk)
  end
end



function onPause()
  isRun=false
  File("/sdcard/SoundMeter/temp.amr").delete()
end


function onDestroy()
  isRun=false
  File("/storage/emulated/0/SoundMeter/temp.amr").delete()
end