require "import"
import "mods.glob"
import "mods.func"
import "Pretend"
function getCorrectIPAddress(iPAddress)
  local sb = StringBuilder()
  sb.append(iPAddress & 0xFF).append(".")
  sb.append((iPAddress >> 8) & 0xFF).append(".")
  sb.append((iPAddress >> 16) & 0xFF).append(".")
  sb.append((iPAddress >> 24) & 0xFF).append(".")
  local sb=sb.toString():gsub("%.0%.",".")
  return sb:sub(1,#sb-1)
end

function refreshInfo()
  --系统信息
  and_ver.text=Build.VERSION.RELEASE
  phone_md.text=Build.MANUFACTURER.." "..Build.MODEL
  and_sdk.text=Build.VERSION.SDK
  phone_cpu.text=Build.CPU_ABI
  phone_hw.text=Build.HARDWARE
  and_id.text = Secure.getString(this.getContentResolver(), Secure.ANDROID_ID)
  --网络
  local cm = this.getSystemService(Context.CONNECTIVITY_SERVICE)
  local tm = this.getSystemService(Context.TELEPHONY_SERVICE)
  netInfo_area.setVisibility(0)
  net_isRoam.Parent.setVisibility(8)
  local mobileNet=cm.getNetworkInfo(ConnectivityManager.TYPE_MOBILE)
  if tostring (mobileNet.getState())=="CONNECTED" then
    --移动
    local nSubType=mobileNet.getSubtype()
    if nSubType==TelephonyManager.NETWORK_TYPE_LTE then
      mMobileType="4G"
     elseif nSubType == TelephonyManager.NETWORK_TYPE_UMTS or nSubType == TelephonyManager.NETWORK_TYPE_HSDPA or nSubType == TelephonyManager.NETWORK_TYPE_EVDO_0 then
      mMobileType="3G"
     elseif nSubType == TelephonyManager.NETWORK_TYPE_GPRS or nSubType == TelephonyManager.NETWORK_TYPE_EDGE or nSubType == TelephonyManager.NETWORK_TYPE_CDMA then
      mMobileType="2G"
     else
      mMobileType="其他"
    end
    net_type.text="移动网络 - "..mMobileType
    netWifi_area.setVisibility(8)
    net_isRoam.Parent.setVisibility(0)
    if tostring (tm.isNetworkRoaming())=="false" then
      isRoaming="否"
     else
      isRoaming="是"
    end
    net_isRoam.text=isRoaming
   elseif tostring (cm.getNetworkInfo(ConnectivityManager.TYPE_WIFI).getState())=="CONNECTED" then
    --wifi
    net_type.text="WiFi 网络"
    netWifi_area.setVisibility(0)
    local mWiFi=activity.Context.getSystemService(Context.WIFI_SERVICE)
    wifiInfo=mWiFi.getConnectionInfo()
    if wifiInfo.getSSID()=="0x" then
      wifi_ssid.text="当前未连接 WiFi"
      wifi_bssid.text=wifi_ssid.text
      wifi_macad.text=wifi_ssid.text
      wifi_ipad.text=wifi_ssid.text
      wifi_strength.text=wifi_ssid.text
     else
      wifissid=tostring(wifiInfo.getSSID())
      wifi_ipad.text=getCorrectIPAddress(wifiInfo.getIpAddress())
      wifi_bssid.text=tostring(wifiInfo.getBSSID())
      wifi_macad.text=tostring(wifiInfo.getMacAddress())
      wifi_ssid.text=wifissid:gsub("\"","")
      wifi_strength.text=tostring(wifiInfo.getRssi())
    end
   else
    --无网络
    netInfo_area.setVisibility(8)
  end
  cache_datashow.text=Formatter.formatFileSize(this,getFreeSpace(cache_path)).." / "..Formatter.formatFileSize(this,getTotalSpace(cache_path))
  data_datashow.text=Formatter.formatFileSize(this,getFreeSpace(data_path)).." / "..Formatter.formatFileSize(this,getTotalSpace(data_path))
  sd_datashow.text=Formatter.formatFileSize(this,getFreeSpace(sdcard_path)).." / "..Formatter.formatFileSize(this,getTotalSpace(sdcard_path))
  root_datashow.text=Formatter.formatFileSize(this,getFreeSpace(root_path)).." / "..Formatter.formatFileSize(this,getTotalSpace(root_path))
  refresh.setRefreshing(false)
end

this.setContentView(loadlayout ({
  LinearLayout,
  orientation="vertical",
  {
    RelativeLayout,
    layout_height="21.75%w",
    layout_width="fill",
    id="topBar",
    elevation="2dp",
    paddingTop=状态栏高度,
    BackgroundColor=returntheme();
    {
      ImageView,
      src="image/left.png",
      layout_alignParentLeft=true;
      layout_height="fill",
      layout_width="15%w",
      onClick=function ()
        this.finish()
      end,
      ColorFilter="#FFFFFFFF";
      foreground=转波纹色(0xcb5B5B5B),
      padding="4%w",
      id="back",
    },
    {
      TextView,
      id="title",
      text="设备信息",
      paddingRight="13%w",
      paddingLeft="3%w",
      layout_toRightOf="back",
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
      orientation="horizontal",
      {
        ImageView,
        src="info.png",
        onClick=function ()

        end,
        foreground=转波纹色(0xcb5B5B5B),
        layout_height="fill",
        layout_width="13%w",
        visibility=8,
        padding="3.5%w",
      },
    },
  },
  {
    SwipeRefreshLayout,
    id="refresh",
    OnRefreshListener={
      onRefresh=function()
        refreshInfo()
      end},
    DistanceToTriggerSync=w*0.2175+状态栏高度,
    --设置颜色    
    {
      ScrollView,
      layout_width="fill",
      {
        LinearLayout,
        orientation="vertical",
        layout_width="fill",
        paddingBottom="3.5%w",
        paddingTop="3.5%w",
        {
          TextView,
          padding="3.5%w",
          textColor=0xff444444,
          text="系统信息",
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_width="fill",
          {
            TextView,
            padding="3.5%w",
            text="设备型号",
          },
          {
            TextView,
            textColor=0xff444444,
            textIsSelectable=true,
            id="phone_md",
            padding="3.5%w",
          },
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_width="fill",
          {
            TextView,
            padding="3.5%w",
            text="Android 系统版本号",
          },
          {
            TextView,
            textColor=0xff444444,
            textIsSelectable=true,
            id="and_ver",
            padding="3.5%w",
          },
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_width="fill",
          {
            TextView,
            padding="3.5%w",
            text="SDK 版本号",
          },
          {
            TextView,
            textColor=0xff444444,
            textIsSelectable=true,
            id="and_sdk",
            padding="3.5%w",
          },
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_width="fill",
          {
            TextView,
            padding="3.5%w",
            text="CPU 架构",
          },
          {
            TextView,
            textColor=0xff444444,
            textIsSelectable=true,
            id="phone_cpu",
            padding="3.5%w",
          },
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_width="fill",
          {
            TextView,
            padding="3.5%w",
            text="硬件类型",
          },
          {
            TextView,
            textColor=0xff444444,
            textIsSelectable=true,
            id="phone_hw",
            padding="3.5%w",
          },
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_width="fill",
          {
            TextView,
            padding="3.5%w",
            text="设备 ID",
          },
          {
            TextView,
            textColor=0xff444444,
            textIsSelectable=true,
            id="and_id",
            padding="3.5%w",
          },
        },
        {
          LinearLayout,
          orientation="vertical",
          id="netInfo_area",
          layout_width="fill",
          {
            TextView,
            padding="3.5%w",
            textColor=0xff444444,
            text="网络信息",
          },
          {
            LinearLayout,
            orientation="horizontal",
            layout_width="fill",
            {
              TextView,
              padding="3.5%w",
              text="网络类型",
            },
            {
              TextView,
              textColor=0xff444444,
              id="net_type",
              padding="3.5%w",
              textIsSelectable=true,
            },
          },
          {
            LinearLayout,
            orientation="horizontal",
            layout_width="fill",
            {
              TextView,
              padding="3.5%w",
              text="是否漫游",
            },
            {
              TextView,
              textColor=0xff444444,
              id="net_isRoam",
              padding="3.5%w",
              textIsSelectable=true,
            },
          },
          {
            LinearLayout,
            orientation="vertical",
            id="netWifi_area",
            layout_width="fill",
            {
              LinearLayout,
              orientation="horizontal",
              layout_width="fill",
              {
                TextView,
                padding="3.5%w",
                text="SSID",
              },
              {
                TextView,
                textColor=0xff444444,
                id="wifi_ssid",
                padding="3.5%w",
                textIsSelectable=true,
              },
            },
            {
              LinearLayout,
              orientation="horizontal",
              layout_width="fill",
              {
                TextView,
                padding="3.5%w",
                text="BSSID",
              },
              {
                TextView,
                textColor=0xff444444,
                id="wifi_bssid",
                padding="3.5%w",
                textIsSelectable=true,
              },
            },
            {
              LinearLayout,
              orientation="horizontal",
              layout_width="fill",
              {
                TextView,
                padding="3.5%w",
                text="信号强度",
              },
              {
                TextView,
                textColor=0xff444444,
                id="wifi_strength",
                padding="3.5%w",
                textIsSelectable=true,
              },
            },
            {
              LinearLayout,
              orientation="horizontal",
              layout_width="fill",
              {
                TextView,
                padding="3.5%w",
                text="MAC 地址",
              },
              {
                TextView,
                textColor=0xff444444,
                id="wifi_macad",
                padding="3.5%w",
                textIsSelectable=true,
              },
            },
            {
              LinearLayout,
              orientation="horizontal",
              layout_width="fill",
              {
                TextView,
                padding="3.5%w",
                text="IP 地址",
              },
              {
                TextView,
                textColor=0xff444444,
                id="wifi_ipad",
                padding="3.5%w",
                textIsSelectable=true,
              },
            },

          },
        },
        {
          TextView,
          padding="3.5%w",
          textColor=0xff444444,
          text="储存空间",
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_width="fill",
          {
            TextView,
            padding="3.5%w",
            text="SD 卡",
          },
          {
            TextView,
            textColor=0xff444444,
            id="sd_datashow",
            padding="3.5%w",
            textIsSelectable=true,
          },
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_width="fill",
          {
            TextView,
            padding="3.5%w",
            text="根目录",
          },
          {
            TextView,
            textIsSelectable=true,
            textColor=0xff444444,
            id="root_datashow",
            padding="3.5%w",
          },
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_width="fill",
          {
            TextView,
            padding="3.5%w",
            text="数据目录",
          },
          {
            TextView,
            textColor=0xff444444,
            textIsSelectable=true,
            id="data_datashow",
            padding="3.5%w",
          },
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_width="fill",
          {
            TextView,
            padding="3.5%w",
            text="缓存目录",
          },
          {
            TextView,
            textColor=0xff444444,
            textIsSelectable=true,
            id="cache_datashow",
            padding="3.5%w",
          },
        },
        {
          TextView,
          padding="3.5%w",
          textColor=0xff444444,
          text="其他信息",
        },
        {
          RelativeLayout,
          layout_height="13%w",
          onClick=function()
            this.newActivity("featurelist")
          end,
          paddingLeft="3.5%w",
          foreground=转波纹色(0xcb5B5B5B),
          {
            TextView,
            text="系统 Features",
            gravity="left|center",
            textSize="16sp",
            layout_height="fill",
            textColor=0xff444444,
          },
          {
            ImageView,
            src="image/arrow.png",
            layout_height="fill",
            layout_width="13%w",
            padding="3.5%w",
            layout_alignParentRight=true,
            rotation=-90,
          },
        },

      },
    },
  },
}))

refreshInfo()



--refresh.setColorSchemeColors={0xFF21B8F6}
