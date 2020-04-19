require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "com.lua.*"

activity.setContentView(loadlayout("layout/qq_gps"))

qqdwwz="http://lokami.cn/ip/"
qqdwwz1="https://www.opengps.cn/Data/IP/LocHighAcc.aspx"

TbsWebView.loadUrl(qqdwwz)--加载网页

TbsWebView2.loadUrl(qqdwwz1)--加载网页

TbsWebView.getSettings().setJavaScriptEnabled(true);

TbsWebView2.getSettings().setJavaScriptEnabled(true);


function onKeyDown(keyCode,event)

  if (keyCode == KeyEvent.KEYCODE_BACK && TbsWebView.canGoBack())then

    TbsWebView.goBack()

    return true

  end

  return false

end