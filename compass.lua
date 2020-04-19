require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.Context"
import "android.hardware.SensorManager"
import "android.hardware.SensorEventListener"
import "android.hardware.Sensor"
import "mods.func"
import "res.strings"

载入页面("layout/compass")

通知栏颜色(returntheme())

dirs=""
FPS=50
磁场=0
传感器 = activity.getSystemService(Context.SENSOR_SERVICE)
local 磁场传感器 = 传感器.getDefaultSensor(Sensor.TYPE_ORIENTATION)
传感器.registerListener(SensorEventListener({ 
  onSensorChanged=function(event) 
    磁场 = event.values[0]
  end,nil}), 磁场传感器, SensorManager.SENSOR_DELAY_NORMAL)
function CircleButton(view,InsideColor,radiu,da,db)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable() 
  drawable.setShape(GradientDrawable.RECTANGLE) 
  drawable.setStroke(10, 0xff0088ff,da,db)
  drawable.setColor(InsideColor) 
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  drawable.setGradientType(1)
  view.setBackgroundDrawable(drawable)
end
角度=activity.getWidth()
控件id=cor
控件颜色=0xFFFFFFFF
CircleButton(控件id,控件颜色,角度,2,2)
CircleButton(cors,控件颜色,角度,(activity.getWidth()*0.8)/2,10)
tick=Ticker()
tick.Period=1000/FPS
tick.onTick=function()
  if 磁场>165 and 磁场<195 then
    dirs="南"
  elseif 磁场>195 and 磁场<255 then
    dirs="西南"
  elseif 磁场>255 and 磁场<285 then
    dirs="西"
  elseif 磁场>285 and 磁场<345 then
    dirs="西北"
  elseif 磁场>345 or 磁场<15 then
    dirs="北"
  elseif 磁场>15 and 磁场<75 then
    dirs="东北"
  elseif 磁场>75 and 磁场<105 then
    dirs="东"
  elseif 磁场>105 and 磁场<165 then
    dirs="东南"
  end
  dir.setText(dirs)
  cors.setRotation(360-磁场)
  w.setRotation(磁场)
  s.setRotation(磁场)
  n.setRotation(磁场)
  e.setRotation(磁场)
  deg.setText(tostring(tointeger(磁场).."°"))
  --Toast.makeText(activity,tostring(磁场.."°"),Toast.LENGTH_SHORT).show()
end
tick.start()

function onDestroy()
  tick.stop()
  传感器.unregisterListener(Listener);
end

function onTouchEvent(event)
  ac=event.action
  if ac==2 or ac==0 then
    x=event.X
    y=event.Y
    coe.setRotationX((activity.getHeight()-y)/30)
    coe.setRotationY(x/30)
  elseif ac==1 then
    coe.setRotationX(0)
    coe.setRotationY(0)
  end
end