require "import"
import "Pretend"
import "android.widget.RelativeLayout"
import "android.widget.ImageView"
import "android.widget.DrawerLayout"
import "android.widget.LinearLayout"
import "android.widget.TextView"
import "android.widget.ScrollView"
import "android.net.ConnectivityManager"
import "android.widget.EditText"
import "com.androlua.LuaUtil"
import "java.io.FileOutputStream"
import "android.graphics.Bitmap"
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.PorterDuff"
import "android.widget.ProgressBar"
import "android.provider.Settings"
import "android.widget.ListView"
import "android.graphics.drawable.BitmapDrawable"
import "android.content.res.ColorStateList"
import "android.content.pm.PackageInfo"
import "android.support.v4.widget.SwipeRefreshLayout"
import "android.content.pm.PackageManager"
import "java.io.ByteArrayInputStream"
import "java.security.cert.CertificateFactory"
import "java.security.MessageDigest"
import "java.lang.String"
import "java.io.File"
import "android.graphics.drawable.GradientDrawable"
import "android.os.Environment"
import "android.os.Build"
import "android.provider.Settings$Secure"
import "android.os.StatFs"
import "android.text.format.Formatter"
import "android.view.ViewAnimationUtils"
import "android.view.animation.AlphaAnimation"
import "android.content.Intent"
import "android.net.Uri"
import "android.view.WindowManager"
import "android.view.View"
import "android.graphics.Color"
import "android.content.Context"
import "android.webkit.MimeTypeMap"
import "android.content.pm.ApplicationInfo"
import "android.telephony.TelephonyManager"
import "android.view.inputmethod.InputMethodManager"
import "android.view.animation.AlphaAnimation"
import "android.animation.ObjectAnimator"
import "android.animation.ArgbEvaluator"
--activity相关
h=activity.height
w=activity.width
window=activity.getWindow()
DecorView=window.getDecorView()
--本应用的名称
pack_name=activity.getPackageName()
--导航栏颜色
window.setNavigationBarColor(0xFFB8B8B8)
imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
--应用程序
沉浸状态栏()

pm=this.getPackageManager()

sdcard_path=Environment.getExternalStorageDirectory().getPath()
data_path=Environment.getDataDirectory().getPath()
cache_path=Environment.getDownloadCacheDirectory().getPath()
root_path=Environment.getRootDirectory().getPath()

appfilepath="/sdcard/轻工具箱/"
pickup_apkfile=appfilepath.."extract_apk/"
pickup_icon=appfilepath.."extract_icon/"
File(appfilepath).mkdirs()
File(pickup_apkfile).mkdirs()
File(pickup_icon).mkdirs()

--获取状态栏高度
local resid=activity.getResources().getIdentifier("status_bar_height","dimen","android")
if resid>0 then
  状态栏高度 = activity.getResources().getDimensionPixelSize(resid)
 else
  状态栏高度 = w*0.07
end

function transColor(view,type,color,time)
  ObjectAnimator.ofInt(view,type,color)
  .setDuration(time)
  .setEvaluator(ArgbEvaluator())
  .start()
end


function 上下渐变(color)
  return GradientDrawable(GradientDrawable.Orientation.TOP_BOTTOM,color)
end

function killApp(pm)
  os.execute("killall "..pm)
end

function uninstallApp(pm)
  activity.startActivity(Intent(Intent.ACTION_DELETE,Uri.parse("package:"..pm)))
end

function 圆形扩散(v,sx,ex,sy,ey,time)
  ViewAnimationUtils.createCircularReveal(v,sx,ex,sy,ey)
  .setDuration(time)
  .start()
end

function viewAppInSettings(pm)
  this.startActivity(Intent()
  .setAction(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
  .setData(Uri.fromParts("package", pm, nil)))
end

function 透明动画(id,时间,开始透明度,结束透明度)
  id.startAnimation(AlphaAnimation(开始透明度,结束透明度).setDuration(时间))
end

function openApp(pm)
  local f,e=pcall(function ()
    this.startActivity(this.getPackageManager().getLaunchIntentForPackage(pm)
    .addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP))
  end)
  if e then
    提示 ("未安装该应用")
  end
end

function openAppStore(pm)
  this.startActivity(Intent(Intent.ACTION_VIEW)
  .setData(Uri.parse("market://details?id="..pm)))
end

function onKeyDown(k)
  if k==4 then
    --返回键事件
    this.finish()
    return true
  end
end

function savePicture(fileName,bitmap)
  local f,e=pcall(function ()
    out = FileOutputStream(File(tostring(fileName)))
    bitmap.compress(Bitmap.CompressFormat.PNG,100, out)
    out.flush()
    out.close()
  end)
  if e then
    print(e)
    return false
   else
    return true
  end
end

function toHexString(bytes)
  local result = StringBuilder("")
  for n=1,#bytes - 1,1 do
    info = Integer.toHexString(bytes[n] & 0xFF)
    if #info == 1 then
      result.append("0"..info)
     else
      result.append(info)
    end
    result.append(":")
  end
  return (result.toString():upper()):sub(1,#result-1)
end

function getSignBase(packageName)
  local packageInfo = pm.getPackageInfo(packageName, PackageManager.GET_SIGNATURES)
  local ct = packageInfo.signatures[0].toByteArray()
  return CertificateFactory.getInstance("X509").generateCertificate(ByteArrayInputStream(ct))
end

function getsha1(packageName)
  return toHexString(MessageDigest.getInstance("SHA1").digest(getSignBase(packageName).getEncoded()))
end

function getMd5(packageName)
  return toHexString(MessageDigest.getInstance("MD5").digest(getSignBase(packageName).getEncoded()))
end

function getLaunchClass(packname)
  local resolveIntent = Intent(Intent.ACTION_MAIN, nil)
  resolveIntent.addCategory(Intent.CATEGORY_LAUNCHER)
  resolveIntent.setPackage(packname)
  local resolveinfoList = pm.queryIntentActivities(resolveIntent, 0)
  pcall(function ()
    resolveinfo = resolveinfoList.iterator().next()
  end)
  if resolveinfo~=nil then
    return resolveinfo.activityInfo.name
   else
    return "无启动类，该应用可能没有用户界面。"
  end
end

function getFreeSpace(path)
  local stat = StatFs(path)
  return stat.getAvailableBytes()
end

function getTotalSpace(path)
  local stat = StatFs(path)
  local blockSize = stat.getBlockSize()
  local totalBlocks = stat.getBlockCount()
  return blockSize * totalBlocks
end

function getFileSize(path)
  return File(tostring(path)).length()
end

function shareApk(path)
  local FileName=tostring(File(tostring(path)).Name)
  local Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension("apk")
  local intent = Intent()
  intent.setAction(Intent.ACTION_SEND)
  intent.setType(Mime)
  local uri = Uri.fromFile(File(path))
  intent.putExtra(Intent.EXTRA_STREAM,uri)
  intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  if pcall(function()
      activity.startActivity(Intent.createChooser(intent, "分享安装包"))
    end) then else
    提示 ("分享失败")
  end
end

function installApp(path)
  activity.startActivity(Intent(Intent.ACTION_VIEW)
  .setDataAndType(Uri.parse("file://"..path), "application/vnd.android.package-archive")
  .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
end


function showAndHiddenAnimation(view,state,duration)

  view.setVisibility(state);

  animation =AlphaAnimation(0,100);
  animation.setDuration(duration);
  animation.setFillAfter(true);
  
  import "android.view.animation.Animation$AnimationListener"
  animation.setAnimationListener(AnimationListener{
    onAnimationStart=function()
      
    end,
    onAnimationEnd=function()
      view.clearAnimation();
    end,
    onAnimationRepeat=function()
      
    end})
  view.setAnimation(animation);
  animation.start();
end