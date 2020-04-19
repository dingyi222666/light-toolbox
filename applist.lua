require "import"
import "mods.glob"
import "mods.func"
import "Pretend"

function base_info(pack)
  return {--应用名称
    app_nm=pm.getPackageInfo(pack.packageName,64).applicationInfo.loadLabel(pm),
    --应用包名
    app_pn=pack.packageName,
    --安装包路径
    app_pt=pm.getApplicationInfo(pack.packageName,64).sourceDir,
    --版本号
    app_vc=pack.versionCode,
    --内部版本号
    app_vn=pack.versionName,
    --应用图标
    app_ic=pack.applicationInfo.loadIcon(pm)}
end

--用于适配器的布局
list_lay={
  RelativeLayout,
  layout_height="wrap",
  gravity="center",
  layout_width="fill",
  {
    LinearLayout,
    orientation="horizontal",
    layout_width="fill",
    {
      ImageView,
      id="app_ic",
      layout_height="20%w",
      layout_width="20%w",
      adjustViewBounds=true,
      padding="3.5%w",
    },
    {
      LinearLayout,
      orientation="vertical",
      layout_gravity="center|left",
      {
        TextView,
        textSize="16sp",
        textColor=0xff444444,
        id="app_nm",
        padding="2%w",
        paddingLeft=0,
        paddingRight="3.5%w",
      },
      {
        TextView,
        textSize="14sp",
        paddingBottom="2%w",
        paddingRight="3.5%w",
        id="app_pn",
      },
      {
        TextView,
        textSize="14sp",
        paddingBottom="2%w",
        visibility=8,
        paddingRight="3.5%w",
        id="app_pt",
      },
      {
        TextView,
        textSize="14sp",
        paddingBottom="2%w",
        paddingRight="3.5%w",
        id="app_vn",
      },
      {
        TextView,
        textSize="14sp",
        paddingBottom="2%w",
        paddingRight="3.5%w",
        visibility=8,
        id="app_vc",
      },
    },
  },
}


filter_data={"用户应用","系统应用","已冻结"}
filter_adp=LuaAdapter(activity,{},{TextView, textColor=0xff444444, gravity="center", padding="3.5%w", id="b"})
for i=1,#filter_data do
  filter_adp.add{b=filter_data[i]}
end
app_adp={}
pmdata=""
function setdata()
  if list_adp then
    pmdata=list_adp.getData()
  end
end
function doing(s)
  load(s)()
end
function setText(s,t,c)
  if c then
    _G[s].setAdapter(_G[t])
   else
    _G[s].text=t
  end
end
function add(t,s)
  _G[t].add(s)
end
function checkApps(f)
  if list_adp then
    list_adp.clear()
  end

  if not (a) then
    filter=f
    a=thread(checkApps2,filter,base_info)
    a()
   else
    pcall(function ()pcall(function() a.stop()end) end)
    a=nil

    _G["a"]=nil
    collectgarbage("collect")
    a=thread(checkApps2,filter,base_info)
    a()
    collectgarbage("collect")
  end

end
function checkApps2(filter,base_info)

  --获取所有应用
  require "import"
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
  function base_info(pack)
    return {--应用名称
      app_nm=pm.getPackageInfo(pack.packageName,64).applicationInfo.loadLabel(pm),
      --应用包名
      app_pn=pack.packageName,
      --安装包路径
      app_pt=pm.getApplicationInfo(pack.packageName,64).sourceDir,
      --版本号
      app_vc=pack.versionCode,
      --内部版本号
      app_vn=pack.versionName,
      --应用图标
      app_ic=pack.applicationInfo.loadIcon(pm)}
  end
  pm=activity.getPackageManager()
  call("doing","refresh.setRefreshing(true)")
  all_packages=pm.getInstalledPackages(0)
  call("setText","app_count","总共 "..#all_packages.." 个应用")

  call("doing",[[list_adp=LuaAdapter(activity,app_adp,list_lay)]])
  --索引从0开始，将所有应用的基本信息添加在适配器
  if filter then
    call("doing",[[
    app_count.setVisibility(8)
    find_count.setVisibility(0)]])
  end
  if filter=="fam.filter.app.isfrozen" then
    for l=0,#all_packages-1 do
      pack=all_packages.get(l)
      if tonumber(pm.getApplicationEnabledSetting(pack.packageName))==pm.COMPONENT_ENABLED_STATE_DISABLED then
        activity.runOnUiThread(Runnable{
        run=function()
          pack=all_packages.get(l)
          activity.get("list_adp").add(base_info(pack))
        end
      })
      end
    end
   elseif filter then
    for l=0,#all_packages-1 do
      pack=all_packages.get(l)
      if pm.getPackageInfo(pack.packageName,64).applicationInfo.loadLabel(pm):find(filter) or pack.packageName:find(filter) then
       activity.runOnUiThread(Runnable{
        run=function()
          pack=all_packages.get(l)
          activity.get("list_adp").add(base_info(pack))
        end
      })
      end
    end
    --没有权限
    --[[pm.getPackageSizeInfo(pack.packageName,{
onGetStatsCompleted=function(pStats,isSuccess)
print ("缓存大小="..Formatter.formatFileSize(this, pStats.cacheSize).."\n数据大小="..Formatter.formatFileSize(this, pStats.dataSize).."\n程序大小=".. Formatter.formatFileSize(this, pStats.codeSize))
end})]]
   else
    for l=0,#all_packages-1 do
      
      activity.runOnUiThread(Runnable{
        run=function()
          pack=all_packages.get(l)
          activity.get("list_adp").add(base_info(pack))
        end
      })
    end
    call("doing",[[
    app_count.setVisibility(0)
    find_count.setVisibility(8)]])
  end


  call("setText","app_ls","list_adp",1)
  if activity.get("list_adp").getCount()>0 then
    if filter=="fam.filter.app.isfrozen" then
      call("setText","find_count",activity.get("list_adp").getCount().." 个已冻结应用")
     else
      call("setText","find_count","找到 "..activity.get("list_adp").getCount().." 个应用")
    end
   else
    if filter=="fam.filter.app.isfrozen" then
      call("setText","find_count","没有已冻结的应用")
     else
      call("setText","find_count","没有找到要搜索的应用")
    end
  end
  --设置下拉刷新的状态
  call("doing","refresh.setRefreshing(false)")
  call("doing","a=nil")
  call("setdata")
end

--状态栏亮色()

this.setContentView(loadlayout ({
  RelativeLayout,
  {
    LinearLayout,
    orientation="vertical",
    {
      RelativeLayout,
      layout_height="21.75%w",
      layout_width="fill",
      id="topBar",
      elevation="2dp",
      paddingTop=状态栏高度,
      BackgroundColor=returntheme(),
      {
        TextView,
        id="title",
        text="应用管理",
        paddingRight="13%w",
        paddingLeft="3.5%w",
        layout_alignParentLeft=true;
        gravity="left|center",
        singleLine=true,
        ellipsize="end",
        textSize="18sp",
        layout_height="fill",
        layout_width="fill",
        textColor=0xffffffff,
      },
      {
        LinearLayout,
        layout_alignParentRight=true;
        {
          ImageView,
          src="image/search.png",
          onClick=function ()
            searchBar.Parent.setVisibility(0)
            base_filter.setVisibility(0)
            圆形扩散(searchBar.Parent,w,0,0,h,350)
            --弹出输入法
            imm.toggleSoftInput(0,InputMethodManager.RESULT_SHOWN)
            --取得edittext焦点
            searchBar.getChildAt(0).requestFocus()
          end,
          ColorFilter="#FFFFFFFF";
          foreground=转波纹色(0xffffffff),
          layout_height="fill",
          layout_width="15%w",
          padding="4%w",
        },

      },
    },
    {
      TextView,
      id="app_count",
      layout_width="fill",
      textSize="14sp",
      padding="2%w",
      paddingLeft="3.5%w",
    },
    {
      TextView,
      id="find_count",
      layout_width="fill",
      textSize="14sp",
      padding="2%w",
      paddingLeft="3.5%w",
    },
    {
      SwipeRefreshLayout,
      id="refresh",
      OnRefreshListener={
        onRefresh=function()
          checkApps()
        end},
      DistanceToTriggerSync=w*0.2175+状态栏高度,
      --设置颜色
      --ColorSchemeColors={0xff000000},
      {
        ListView,
        id="app_ls",
        layout_width="fill",
        fastScrollEnabled=true,
        VerticalScrollBarEnabled=false,
        dividerHeight=1,

      },
    },
  },
  {
    LinearLayout,
    visibility=8,
    layout_height="fill",
    orientation="vertical",
    {
      RelativeLayout,
      layout_height="21.75%w",
      layout_width="fill",
      id="searchBar",
      paddingTop=状态栏高度,
      BackgroundColor=returntheme(),
      {
        EditText,
        id="search_edit",
        hint="搜索应用名称",
        imeOptions="actionSearch",
        paddingRight="26%w",
        paddingLeft="3.5%w",
        layout_alignParentLeft=true,
        gravity="left|center",
        singleLine=true,
        backgroundColor=0,
        textSize="18sp",
        layout_height="fill",
        layout_width="fill",
        textColor=0xffffffff,
      },
      {
        LinearLayout,
        orientation="horizontal",
        layout_alignParentRight=true;
        {
          ImageView,
          src="image/search.png",
          onClick=function ()
            if #search_edit.text<1 then
              print("未输入关键词")
              base_filter.setVisibility(0)
             else
              base_filter.setVisibility(8)
              checkApps(search_edit.text)
            end
          end,
          ColorFilter="#FFFFFFFF";
          foreground=转波纹色(0xffffffff),
          layout_height="fill",
          layout_width="13%w",
          id="search_mag",
          visibility=8,
          padding="3.5%w",
        },
        {
          ImageView,
          src="image/close.png",
          onClick=function ()
            圆形扩散(searchBar.Parent,w,0,h,0,350)
            task(300, function ()
              searchBar.Parent.setVisibility(8)
            end)
            --透明动画(searchBar.Parent,350,1,0)
            if filter~=nil then
              search_edit.text=""
              task(300,function()checkApps("")end)
            end
            --隐藏输入法，同时会清除edittext焦点
            imm.hideSoftInputFromWindow(searchBar.getChildAt(0).getWindowToken(), 0)
          end,
          ColorFilter="#FFFFFFFF";
          foreground=转波纹色(0xffffffff),
          layout_height="fill",
          layout_width="15%w",
          padding="4%w",
        },
      },
    },
    {
      LinearLayout,
      backgroundColor=0xaefafafa,
      orientation="vertical",
      id="base_filter",
      layout_height="fill",
      onClick=function ()
      end,
      layout_width="fill",
      {
        TextView,
        text="分类查看",
        textSize="16sp",
        layout_gravity="center",
        padding="5%w",
      },
      {
        GridView;
        numColumns=3;
        gravity="center",
        id="sb";
        Adapter=filter_adp,
        paddingLeft="5%w",
        paddingRight="5%w",
      },
    },
  },
}))



checkApps()



search_edit.addTextChangedListener({
  onTextChanged=function()
    if #search_edit.text<1 then
      filter=nil
      task(300,function()checkApps()end)
      base_filter.setVisibility(0)
      -- search_mag.setVisibility(8)
     else
      filter=search_edit.text
      task(300,function()checkApps(filter)end)
      base_filter.setVisibility(8)
    end
  end})

search_edit.setOnEditorActionListener{
  onEditorAction=function(view,int,KeyEvent)
    task(300,function()checkApps(filter)end)
    return true
  end}

function onKeyDown(k)
  if k==4 and searchBar.Parent.getVisibility()~=8 then
    圆形扩散(searchBar.Parent,w,0,h,0,350)
    task(300, function ()
      searchBar.Parent.setVisibility(8)
    end)
    imm.hideSoftInputFromWindow(searchBar.getChildAt(0).getWindowToken(), 0)
    if filter~=nil then
      search_edit.text=""
      task(300,function()checkApps()end)
    end
    return true
  end
end



app_ls.onItemClick=function(parent, view, position, id)
  this.newActivity("info",{view.getChildAt(0).getChildAt(1).getChildAt(1).text})
end
app_ls.onItemLongClickListener={
  onItemLongClick=function(parent, view, position, id)
    this.newActivity("manage",{view.getChildAt(0).getChildAt(1).getChildAt(1).text})
    return true
  end}



sb.onItemClick=function(parent, view, position, id)
  if position==0 then

   elseif position==1 then

   elseif position==2 then
    filter="fam.filter.app.isfrozen"
    checkApps(filter)
  end
  base_filter.setVisibility(8)
end
function b()
  if a then
    a=nil
    collectgarbage("collect")
  end
end
function onPause()
  b()
end

function onStop()
  b()
end

function onDestroy()
  b()
end