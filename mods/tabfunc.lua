require "import"
import "res.strings"



tabfunc={}

tabfunc["图片拼接"]=[[activity.newActivity("image_mosaic")]]

tabfunc["动漫图片"]=[[activity.newActivity("random_pictures",{"动漫图片","http://api.btstu.cn/sjbz/?lx=m_dongman"})]]

tabfunc["美女图片"]=[[activity.newActivity("random_pictures",{"美女图片","http://api.btstu.cn/sjbz/?lx=m_meizi"})]]

tabfunc["网址取源"]=[[网址取源()]]

tabfunc["摩斯电码"]=[[activity.newActivity("morse_code")]]

tabfunc["说说打赏"]=[[说说打赏()]]

tabfunc["抽象话生成"]=[[activity.newActivity("abstract_speech_generation")]]

tabfunc["分贝仪"]=[[activity.newActivity("decibel_meter")]]

tabfunc["music"]='打开网页("https://static.hfi.me/mikutap/","全屏_横",nil,nil,nil)'

tabfunc["翻应用"]='打开网页("http://www.iapps.me","全屏_竖",nil,nil,{"main-nav float","@ID<footer>","footer-scripts"})'

tabfunc["base64加解密"]='activity.newActivity("base64")'

tabfunc["小霸王游戏机"]='打开网页("https://www.yikm.net/","全屏_竖",nil,nil,{"footer"})'

tabfunc["小刀娱乐网"]='打开网页("https://www.xd0.com/","全屏_竖",nil,nil,{"cj-mainbar","@ID<logo>","@ID<HtmlMoKua_108983>","@ID<HtmlMoKua_512577>"})'

tabfunc["xp框架"]='打开网页("https://xposed.appkg.com/","全屏_竖",nil,nil,{"nav-menu","main-nav","logo","body-overlay","nav-footer","copyright-footer","links-footer","copyright-footer","navbar navbar-default navbar-fixed-top header-01"})'

tabfunc["mt管理器论坛"]='打开网页("https://bbs.binmt.cc/","全屏_竖",nil,nil,nil)'

tabfunc["健康消消乐"]='打开网页("http://game.uixsj.cn/health-elimination/","全屏_竖",nil,nil,nil)'

tabfunc["2048"]='打开网页("http://game.uixsj.cn/2048/","全屏_竖",nil,nil,nil)'

tabfunc["扫雷"]='打开网页("http://h5games.applinzi.com/saolei","全屏_竖",nil,nil,nil)'

tabfunc["像素小鸟"]='打开网页("http://game.uixsj.cn/bird","全屏_竖",nil,nil,nil)'

tabfunc["看你有多色"]='打开网页("http://game.uixsj.cn/se/","全屏_竖",nil,nil,nil)'

tabfunc["史上最坑爹的游戏9"]='打开网页("http://h.4399.com/play/175320.htm","全屏_竖",nil,nil,nil)'

tabfunc["见缝插针"]='打开网页("http://game.uixsj.cn/jfcz/","全屏_竖",nil,nil,nil)'

tabfunc["智力撑杆"]='打开网页("http://game.uixsj.cn/zlcg/","全屏_竖",nil,nil,nil)'

tabfunc["超级玛丽"]='打开网页("http://tool.uixsj.cn/s/super-mario/","全屏_横",nil,nil,nil)'

tabfunc["别踩白块"]='打开网页("http://game.uixsj.cn/bcbk/","全屏_竖",nil,nil,nil)'

tabfunc["消灭星星"]='打开网页("http://www.taotools.cn/popstar/","全屏_竖",nil,nil,nil)'

tabfunc["更多"]='打开网页("http://h.4399.com/wap","全屏_竖",nil,nil,nil)'

tabfunc["密室逃脱"]='打开网页("http://game.uixsj.cn/mstt/","全屏_竖",nil,nil,nil)'

tabfunc["还有这种操作"]='打开网页("http://h.4399.com/play/206304.htm","全屏_竖",nil,nil,nil)'

tabfunc["3D元素周期表"]='打开网页("http://tool.uixsj.cn/3dzqb/","全屏_竖",nil,nil,nil)'

tabfunc["文字差异比较"]=[[打开网页("http://tool.mkblog.cn/contrast/","普通","文字差异比较","document.body.style.marginTop='-55px'",{"main-footer"})]]

tabfunc["代码高亮转换"]=[[打开网页("http://tool.uixsj.cn/highlight/","普通","代码高亮转换","document.body.style.marginTop='-55px'",{"navbar-header","main-footer","row"})]]

tabfunc["代码运行工具"]=[[打开网页("https://c.runoob.com/compile/15","普通","代码运行工具",nil,{"container","col-lg-12"})]]

tabfunc["高级重启"]=[[
items={"重启","recovery","erecovery"} 
AlertDialog.Builder(this) 
.setTitle("高级重启") 
.setItems(items,{onClick=function(l,v) 
    if v==0 then
 AlertDialog.Builder(this)
.setTitle("重启")
.setMessage("确定重启？")
.setPositiveButton("确定",{onClick=function()
 执行Shell("su svc power reboot")
 判断代码执行("su svc power reboot")   
 end})
.setNeutralButton("取消",nil)
.show()
    end
    if v==1 then
 AlertDialog.Builder(this)
.setTitle("recovery")
.setMessage("确定重启到recovery？")
.setPositiveButton("确定",{onClick=function()
 执行Shell("su svc power reboot recovery")
 判断代码执行("su svc power reboot recovery")
 end})
.setNeutralButton("取消",nil)
.show()     
 end 
    if v==2 then
AlertDialog.Builder(this)
.setTitle("华为系统恢复")
.setMessage("确定重启到华为erecovery？")
.setPositiveButton("确定",{onClick=function()
 执行Shell("su svc power reboot erecovery")
 判断代码执行("su svc power reboot erecovery")
 end})
.setNeutralButton("取消",nil)
.show()      
end
  end}) 
.show()
]]

tabfunc["网页制作"]='打开网页("http://www.144g.com/","普通","网页制作",nil,nil)'

tabfunc["应用管理"]='activity.newActivity("applist")'

tabfunc["营销号文章生成"]='activity.newActivity("marketing_number_generation")'

tabfunc["轻小说"]='activity.newActivity("read_look")'

tabfunc["历史上的今天"]='activity.newActivity("today_in_history")'

tabfunc["gif图制作"]='打开网页("https://www.52doutu.cn/maker/","全屏_竖",nil,nil,{"@ID<footer>","@ID<menu-btn>","comments","col-md-4 right-info-panel"})'

tabfunc["在线地图"]='打开网页("https://map.baidu.com/mobile/webapp/index/index/","普通","在线地图",nil,nil)'

tabfunc["尖叫字体生成"]='打开网页("http://tool.uixsj.cn/jjzt/","普通","尖叫字体生成",nil,nil)'

tabfunc["学生计算器"]='打开网页("https://www.zybang.com/static/question/m-calculator/m-calculator.html?token=1_XPXQH3c5HRPtFHkSwi3sCCURmT25QfxM&vc=398&channel=yingyongbao&_dc=0.9332630658204307&city=%E8%82%87%E5%BA%86%E5%B8%82&province=%E5%B9%BF%E4%B8%9C%E7%9C%81&vcname=9.2.0&cuid=2FC2A8F5F4992ECF6C9F12590FC56AD0|731223170523553&dayivc=37&zbkvc=24&os=android","普通","计算器",nil,nil)'

tabfunc["生成整人网页"]='打开网页("http://zr.uixsj.cn/","普通","生成整人网页",nil,{"alert alert-success","container-fluid"})'

tabfunc["磁力搜索"]='打开网页("http://pipicili.bid/","普通","磁力搜索",nil,nil)'

tabfunc["电影字幕速成"]=
[[
打开网页("http://tool.uixsj.cn/film-subtitle/","普通","电影字幕速成",nil,nil)
]]
tabfunc["微博视频解析"]='打开网页("http://tool.uixsj.cn/weibovideo/","普通","微博视频解析",nil,nil)'

tabfunc["轻搜书"]='打开网页("https://www.jiumodiary.com","普通","轻搜书",nil,{"top-wrapper"})'

tabfunc["自由的音乐"]='打开网页("https://www.tikitiki.cn/","普通","自由的音乐",nil,nil)'

tabfunc["其他音乐"]='打开网页("http://47.112.23.238/music","普通","其他音乐",nil,{"mdui-color-transparent"})'

tabfunc["乐享音乐"]='打开网页("https://music.laod.cn","全屏_竖",nil,nil,nil)'

tabfunc["ocr文字识别"]=[[this.startActivity(Intent(Intent.ACTION_VIEW,Uri.parse("http://tool.mkblog.cn/ocr//")))
提示("由于特殊原因该功能使用浏览器打开....")

]]

tabfunc["画板"]='打开网页("https://witeboard.com","全屏_横",nil,nil,nil)'

tabfunc["电视直播"]=[[打开网页("http://m.leshi123.com/","视频","电视直播","var d=document;var s=d.createElement('script');s.setAttribute('src', 'https://greasyfork.org/scripts/7410-jskillad/code/jsKillAD.user.js');d.head.appendChild(s);",{"top-search icon","foot-border","@ID<app-downlaod>","banner2"})]]

tabfunc["斗鱼直播"]='打开网页("https://m.douyu.com/","视频","斗鱼直播",nil,nil)'

tabfunc["虎牙直播"]='打开网页("https://m.huya.com/","视频","虎牙直播",nil,nil)'


tabfunc["触手直播"]='打开网页("https://chushou.tv/m-home.htm","视频","触手直播",nil,{"h5_footer"})'

tabfunc["QQ定位"]='activity.newActivity("qq_gps")'

tabfunc["设备信息"]='activity.newActivity("sysinfo")'

tabfunc["随机一文"]='activity.newActivity("random_raaper")'

tabfunc["轻漫画"]='activity.newActivity("cartoon")'

tabfunc["一言合集"]='activity.newActivity("a_brief_remark")'

tabfunc["全屏时钟"]='activity.newActivity("full_screen_clock")'

tabfunc["尺子"]='activity.newActivity("ruler")'

tabfunc["QQ头像获取"]='QQ_getheadportrait() 弹出输入法()'

tabfunc["短链生成"]='短链接生成() 弹出输入法() '

tabfunc["文件分享"]=[[
打开网页("http://send.firefox.com","普通","文件分享",nil,nil)
]]
tabfunc["bilibili获取封面"]='bilibili_getpng() 弹出输入法() '

tabfunc["条码工具"]='activity.newActivity("qr_code")'

tabfunc["轻影视"]='activity.newActivity("light_film")'

tabfunc["天气"]='activity.newActivity("weather")'

tabfunc["拼音转换"]='打开网页("http://hy.httpcn.com/hzzpy/","普通","拼音转换",nil,{"mui-content-padded bsgg","mui-bar mui-bar-nav","hanyu-xg"})'

tabfunc["指南针"]='activity.newActivity("compass")'

tabfunc["垃圾分类查询"]='activity.newActivity("refuse_classification")'

tabfunc["战旗直播"]=[[打开网页("https://m.zhanqi.tv/","视频","战旗直播",nil,nil)]]

tabfunc["bilibili直播"]=[[打开网页("https://live.bilibili.com/h5/","视频","bilibili直播",nil,{"logo-bar f-clear","top-nav-ctnr","bili-app-link-container none-select","@ID<bili-footer>"})]]

tabfunc["腾讯新闻"]=[[打开网页("https://xw.qq.com/","普通","腾讯新闻",nil,nil)]]

tabfunc["归属地查询"]=[[activity.newActivity("phone_search")]]

tabfunc["网易新闻"]=[[打开网页("http://3g.163.com/","普通","网易新闻",nil,nil)]]

tabfunc["凤凰新闻"]=[[打开网页("https://i.ifeng.com","普通","凤凰新闻","var d=document;var s=d.createElement('script');s.setAttribute('src', 'https://greasyfork.org/scripts/7410-jskillad/code/jsKillAD.user.js');d.head.appendChild(s);",{"link-qP2JS-s8"})]]

tabfunc["央视新闻"]=[[打开网页("http://m.cctv.com/","普通","央视新闻",nil,nil)]]

tabfunc["未来新闻"]=[[打开网页("http://m.news.k618.cn/","普通","未来新闻",nil,nil)]]

tabfunc["摩斯密码"]=[[打开网页("http://tool.uixsj.cn/morse/","普通","摩斯密码","document.body.style.marginTop='-55px'",nil)]]

tabfunc["影视搜索"]=[[activity.newActivity("filmsearch")]]

tabfunc["防红链接"]='打开网页("http://url.gljlw.com/fh/","普通","防红链接",nil,{"container-fluid"})'

tabfunc["带壳截图"]='activity.newActivity("shell_screenshot")'

tabfunc["翻译"]='activity.newActivity("taoist_translation")'

tabfunc["快递查询"]='activity.newActivity("express_inquiry")'

tabfunc["取色器"]='activity.newActivity("palette")'

tabfunc["一个ai"]='activity.newActivity("talk")'

tabfunc["地铁查询"]='打开网页("http://webmetro.itouchchina.com","普通","地铁查询",nil,nil)'

tabfunc["QQ强制聊天"]='qq_forcedchat() 弹出输入法() '

tabfunc["QQ空间开通"]='打开网页("http://ctc.qzs.qq.com/qzone/web/load2.htm","普通","QQ空间开通",nil,nil)'

tabfunc["QQ空间关闭"]='打开网页("http://imgcache.qq.com/qzone/web/qzone_submit_close.html","普通","QQ空间关闭",nil,nil)'

tabfunc["QQ拉圈圈"]='打开网页("http://w.toolv.cn/tool/laquanquan/","普通","QQ拉圈圈",[[document.body.style.marginTop="-230px"]],{"am-tabs","am-icon-chain","am-panel-footer index-footer"})'

tabfunc["rc4加解密"]='activity.newActivity("rc4jm")'
tabfunc["QQ音乐加速"]=[[
      AlertDialog.Builder(this)
                  .setTitle("提示")
                  .setMessage("请领取QQ音乐加速后在打开QQ音乐才能领取成功。")
                  .setPositiveButton("好的",{onClick=function(v)
          打开网页("http://w.toolv.cn/tool/qqmusic/","普通","QQ音乐加速","document.body.style.marginTop='-230px'",{"am-tabs","am-icon-chain","am-panel-footer index-footer"})                                                     
                       end
                     })
                  .setNeutralButton("取消",nil)
                   .show()

]]

tabfunc["综合解析"]=[[打开网页("http://www.tutujiexi.com/","普通","综合解析","document.body.style.marginTop='-100px'",{"navbar-brand","footer","navbar tuNavbar has-shadow is-fixed-top is-info","content has-text-centered"})]]

tabfunc["快手解析"]=[[打开网页("http://tool.uixsj.cn/kuaishou","普通","快手解析",nil,{"navbar navbar-inverse navbar-fixed-top","footer"})]]

tabfunc["字数统计"]=[[打开网页("http://tool.uixsj.cn/s/count/","普通","字数统计","document.body.style.marginTop='-90px'",{"navbar navbar-default navbar-fixed-top","@ID<footer>"})]]

tabfunc["QQ说说蓝色字体"]='QQ_Talk_about_Blue_Font() 弹出输入法() '

tabfunc["随机数生成"]='activity.newActivity("random_number")'

tabfunc["贴吧ID信息查询"]=[[打开网页("http://mk.mkblog.cn/home/info","普通","贴吧ID信息查询",nil,nil)]]

tabfunc["王者荣耀重复名"]="王者荣耀重复名() 弹出输入法()"

tabfunc["bilibili视频下载"]="bilibili_download() 弹出输入法() "

tabfunc["特殊文字生成"]='特殊文字生成() 弹出输入法() '

tabfunc["QQ靓号注册"]='打开网页("https://ssl.zc.qq.com/v3/index-chs.html?type=3","普通","QQ靓号注册",nil,nil)'

tabfunc["图片隐藏信息"]=[[
打开网页("http://tool.cccyun.cc/tool/hide","普通","图片隐藏信息",nil,nil)
]]

tabfunc["QQ空间各种代码"]=([[
  InputLayout={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
   {
    EditText;
    layout_width="fill";
    layout_height="600dp";
    text=读取文件(QQ空间代码地址);
    gravity="center";
   };
}
AlertDialog.Builder(this)
.setTitle("")
.setView(loadlayout(InputLayout))
.setPositiveButton("确定",nil)

.show()    

]])


tabfunc["随机密码生成"]=[[打开网页("http://tool.uixsj.cn/password/","普通","随机密码生成","document.body.style.marginTop='-55px'",{"navbar-header","footer"})]]

tabfunc["空白名字"]=[[
写入剪贴板("　　　　　　　　　　　　")
提示("已复制!")
]]

tabfunc["shell脚本执行"]=[[
--输入对话框
InputLayout={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
  {
    EditText;
    layout_marginTop="0dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit";
  };
};

AlertDialog.Builder(this)
.setTitle("请输入shell命令")
.setView(loadlayout(InputLayout))
.setPositiveButton("确定",{onClick=function(v) 
    if(edit.Text=="")then
      提示("未输入任何东西")
      else      
      执行Shell(edit.Text)
     判断代码执行(edit.Text)
      end
    end})
.setNeutralButton("取消",nil)
.show()
]]


tabfunc["引流神器"]=[[
import "android.util.Base64"
import "android.net.Uri"
import "android.content.Intent"

--列表对话框（列表项目名称自定义）
items={}--定义一个布局为l列表单个项目布局，名字为itemc
--给空的items添加所有的数据
--格式为  table.insert(空列表名称,"列表名称")
table.insert(items,"王者荣耀引流")
table.insert(items,"领QB引流")
table.insert(items,"QQ红包引流")
table.insert(items,"自定义")


AlertDialog.Builder(this)
.setTitle("引流神器 V1.0.1")--设置标题
--给列表对话框设置点击事件
.setItems(items,{onClick=function(l,v) 
    --注：与创建有数据的列表项目名称必须一样    
    if items[v+1]=="王者荣耀引流" then
    InputLayout={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
  {
    TextView;
    id="Prompt",
    textSize="15sp",
    layout_marginTop="10dp";
    layout_marginLeft="3dp",
    layout_width="80%w";
    layout_gravity="center",
    text="输入要跳转的链接地址:";
  };
  {
    EditText;
    hint="输入";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit";
  };
}; 
AlertDialog.Builder(this)
.setTitle("请输入跳转链接")
.setView(loadlayout(InputLayout))
.setPositiveButton("确定", function()
      local 分享ID=1104466820
      local 跳转链接=edit.text
      local 预览图链接="https://ws1.sinaimg.cn/large/006N1muNly1g1izhzc4cqj3068068abf.jpg"
      local 图片链接="https://ws1.sinaimg.cn/large/006N1muNly1g1izhzc4cqj3068068abf.jpg "   
      local 标题="王者荣耀"
      local 描述="点击抽取皮肤钻石百分百中奖"
      qqShare(分享ID,跳转链接,预览图链接,图片链接,标题,描述) 
end) 
 .setNeutralButton("取消", nil)
.show()
弹出输入法()
    elseif items[v+1]=="领QB引流" then
         InputLayout={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
  {
    TextView;
    id="Prompt",
    textSize="15sp",
    layout_marginTop="10dp";
    layout_marginLeft="3dp",
    layout_width="80%w";
    layout_gravity="center",
    text="输入要跳转的链接地址:";
  };
  {
    EditText;
    hint="输入";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit";
  };
};
AlertDialog.Builder(this)
.setTitle("请输入跳转链接")
.setView(loadlayout(InputLayout))
.setPositiveButton("确定", function()
 import "android.util.Base64"
import "android.net.Uri"
import "android.content.Intent"
          
      local 分享ID=1101685683
      local 跳转链接=edit.text
      local 预览图链接="https://img.alicdn.com/bao/uploaded/i1/T1aiVpXoBHXXb1upjX.jpg"
      local 图片链接="https://img.alicdn.com/bao/uploaded/i1/T1aiVpXoBHXXb1upjX.jpg "   
      local 标题="最新活动"
      local 描述="百分百中奖免费抽QB"
      qqShare(分享ID,跳转链接,预览图链接,图片链接,标题,描述) 
end) 
 .setNeutralButton("取消", nil)
.show()
 弹出输入法()   
    elseif items[v+1]=="QQ红包引流" then
      InputLayout={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
  {
    TextView;
    id="Prompt",
    textSize="15sp",
    layout_marginTop="10dp";
    layout_marginLeft="3dp",
    layout_width="80%w";
    layout_gravity="center",
    text="输入要跳转的链接地址:";
  };
  {
    EditText;
    hint="输入";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit";
  };
};
AlertDialog.Builder(this)
.setTitle("请输入:")
.setView(loadlayout(InputLayout))
.setPositiveButton("确定", function()
 import "android.util.Base64"
import "android.net.Uri"
import "android.content.Intent"
        local 分享ID=1101685683
      local 跳转链接=edit.text
      local 预览图链接="https://ww1.sinaimg.cn/large/007iUjdily1g1rswi80vgj30bb0dfwep.jpg"
      local 图片链接="https://ww1.sinaimg.cn/large/007iUjdily1g1rswi80vgj30bb0dfwep.jpg "   
      local 标题="[QQ红包]发红包啦！"
      local 描述="赶紧点击拆开吧"
      qqShare(分享ID,跳转链接,预览图链接,图片链接,标题,描述) 
end) 
 .setNeutralButton("取消", nil)
.show()
弹出输入法()
    elseif items[v+1]=="自定义" then
     InputLayout={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
  {
    EditText;
    hint="输入分享ID,不填则默认手机腾讯网";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit";
  };
  {
    EditText;
    hint="输入要跳转的链接地址:";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit1";
  };
  {
    EditText;
    hint="输入预览图的链接地址:";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit2";
  };
    {
    EditText;
    hint="输入图片的链接地址:";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit3";
  };
    {
    EditText;
    hint="输入标题:";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit4";
  };
    {
    EditText;
    hint="输入描述:";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    id="edit5";
  };
};

AlertDialog.Builder(this)
.setTitle("请输入:")
.setView(loadlayout(InputLayout))
.setPositiveButton("GO", function()
 
if edit.text=="" or nil then
edit.text=1101685683
end                        
      local 分享ID=edit.text
      local 跳转链接=edit1.text
      local 预览图链接=edit2.text
       local 图片链接=edit3.text
       local 标题=edit4.text
      local 描述=edit5.text
      qqShare(分享ID,跳转链接,预览图链接,图片链接,标题,描述) 
end) 
 .setNeutralButton("取消", nil)
.show()
    end
  end})
.show()--显示弹窗
弹出输入法()
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE|WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)

]]