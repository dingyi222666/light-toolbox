require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.glob"
import "mods.func"
import "res.strings"
import "android.graphics.drawable.BitmapDrawable"
import "android.graphics.drawable.ColorDrawable"
--程序启动时会执行的事件
import "java.io.File"
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xffffffff);
if tonumber(Build.VERSION.SDK) >= 23 then
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
end
local cc=0
local bb=0xff000000
隐藏状态栏()



import "com.hanks.htextview.evaporate.*"
import "com.hanks.htextview.base.*"
activity.setTheme(android.R.style.Theme_DeviceDefault_Light_NoActionBar)
activity.setContentView(loadlayout("layout/full_screen_clock"))




activity.setRequestedOrientation(0)



function mb()
  asp.animateText(os.date("%H:%M:%S"))
  --本地时间总和
  date.setText(os.date("%A · %B %d"))
end




aaa.onClick=function()
  if cc==1 then
    cc=0
    transColor(aaa,"backgroundColor",{aaa.getBackground().getColor(),0xffffffff},350)
    transColor(asp,"TextColor",{asp.getCurrentTextColor(),0xff000000},50)
    bb=0xffffffff
    transColor(date,"TextColor",{date.getCurrentTextColor(),0xff000000},10)
   else
    cc=1

    transColor(asp,"TextColor",{asp.getCurrentTextColor(),0xffffffff},50)
    transColor(aaa,"backgroundColor",{aaa.getBackground().getColor(),0xff000000},350)
    transColor(date,"TextColor",{date.getCurrentTextColor(),0xffffffff},10)
    bb=0xff000000
  end

end





thread(function()
  require "import"
  while true do
    Thread.sleep(500)
    call("mb")
  end
end)