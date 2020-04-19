require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "http"
import "mods.func"


activity.setContentView(loadlayout("layout/taoist_translation"))



--一个表,用于读音
TranslationDatabase={
  自动检测="auto",
  中文="zh",
  英语="en",
  日语="jq",
  韩语="ko",
  西班牙文="es",
  俄语="ru",
  法语="fr",
}



--最好是单词翻译，句子翻译会不准确
--结果跟有道翻译官完全准确
--翻译类型tran_type
--[[
自动检       AUTO
中译英       ZH_CN2EN
中译日       ZH_CN2JA
中译韩       ZH_CN2KR
中译法       ZH_CN2FR
中译俄       ZH_CN2RU
中译西       ZH_CN2SP
]]




function 有道翻译(content,tran_type)
  edText = edit.Text:match"^%s*(.-)%s*$"
  if edText ~= "" then
    url="http://m.youdao.com/translate"
    data="inputtext="..content.."&type="..tran_type
    body,cookie,code,headers=http.post(url,data)
    for v in body:gmatch('<ul id="translateResult">(.-)</ul>') do
      v=v:match('<li>(.-)</li>')
      v=v:match"^%s*(.-)%s*$"
      return v
    end
   else
    result.Text = ""
    设置hint(result,12,"输入内容为空,请重新输入...")
  end
end


function 设置hint(id,size,str)
  import "android.text.Spanned"
  import "android.text.SpannableString"
  import "android.text.style.AbsoluteSizeSpan"
  s = SpannableString(str);
  textSize = AbsoluteSizeSpan(size,true);
  s.setSpan(textSize,0,s.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
  id.setHint(s);
end



function 检测内容是否为空(str,tran_type,mode)
  conText = edit.Text:match"^%s*(.-)%s*$"
  if conText ~= "" then
    result.Text = 有道翻译(str,tran_type)
   else
    result.Text = ""
    设置hint(result,12,"输入内容为空,请重新输入...")

  end
end


function 复制文本(str)
  import "android.content.*"
  activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(str)
  提示("翻译内容已复制")
end


function 分享文本(str)
  import "android.content.Intent"
  intent = Intent(Intent.ACTION_SEND);
  intent.setType("text/plain");
  intent.putExtra(Intent.EXTRA_TEXT,str);
  activity.startActivityForResult(intent, 0)
end


function 翻译()
  a = source.getText()
  b = target.getText()

  if a=="自动检测" or b=="自动检测" then
    翻译类型="AUTO"
    检测内容是否为空(edit.Text,翻译类型)

   elseif a=="中文" and b=="英文" then
    翻译类型="ZH_CN2EN"
    检测内容是否为空(edit.Text,翻译类型)
   elseif a=="中文" and b=="日文" then
    翻译类型="ZH_CN2JA"
    检测内容是否为空(edit.Text,翻译类型)
   elseif a=="中文" and b=="韩文" then
    翻译类型="ZH_CN2KR"
    检测内容是否为空(edit.Text,翻译类型)
   elseif a=="中文" and b=="法文" then
    翻译类型="ZH_CN2FR"
    检测内容是否为空(edit.Text,翻译类型)
   elseif a=="中文" and b=="俄文" then
    翻译类型="ZH_CN2RU"
    检测内容是否为空(edit.Text,翻译类型)
   elseif a=="中文" and b=="西班牙文" then
    翻译类型="ZH_CN2SP"
    检测内容是否为空(edit.Text,翻译类型)


   elseif a=="英文" and b=="中文" then
    翻译类型="EN2ZH_CN"
    检测内容是否为空(edit.Text,翻译类型)
   elseif a=="日文" and b=="中文" then
    翻译类型="JA2ZH_CN"
    检测内容是否为空(edit.Text,翻译类型)
   elseif a=="韩文" and b=="中文" then
    翻译类型="KR2ZH_CN"
    检测内容是否为空(edit.Text,翻译类型)
   elseif a=="法文" and b=="中文" then
    翻译类型="FR2ZH_CN"
    检测内容是否为空(edit.Text,翻译类型)
   elseif a=="俄文" and b=="中文" then
    翻译类型="RU2ZH_CN"
    检测内容是否为空(edit.Text,翻译类型)
   elseif a=="西班牙文" and b=="中文" then
    翻译类型="SP2ZH_CN"
    检测内容是否为空(edit.Text,翻译类型)

   elseif a=="日文" and b=="英文" then
    rel = 有道翻译(edit.Text,"JA2ZH_CN")
    翻译类型="ZH_CN2EN"
    检测内容是否为空(rel,翻译类型)
   elseif a=="日文" and b=="日文" then
    rel = 有道翻译(edit.Text,"JA2ZH_CN")
    翻译类型="ZH_CN2JA"
    检测内容是否为空(rel,翻译类型)
   elseif a=="日文" and b=="韩文" then
    rel = 有道翻译(edit.Text,"JA2ZH_CN")
    翻译类型="ZH_CN2KR"
    检测内容是否为空(rel,翻译类型)
   elseif a=="日文" and b=="法文" then
    rel = 有道翻译(edit.Text,"JA2ZH_CN")
    翻译类型="ZH_CN2FR"
    检测内容是否为空(rel,翻译类型)
   elseif a=="日文" and b=="俄文" then
    rel = 有道翻译(edit.Text,"JA2ZH_CN")
    翻译类型="ZH_CN2RU"
    检测内容是否为空(rel,翻译类型)
   elseif a=="日文" and b=="西班牙文" then
    rel = 有道翻译(edit.Text,"JA2ZH_CN")
    翻译类型="ZH_CN2SP"
    检测内容是否为空(rel,翻译类型)

   elseif a=="韩文" and b=="英文" then
    rel = 有道翻译(edit.Text,"KR2ZH_CN")
    翻译类型="ZH_CN2EN"
    检测内容是否为空(rel,翻译类型)
   elseif a=="韩文" and b=="日文" then
    rel = 有道翻译(edit.Text,"KR2ZH_CN")
    翻译类型="ZH_CN2JA"
    检测内容是否为空(rel,翻译类型)
   elseif a=="韩文" and b=="韩文" then
    rel = 有道翻译(edit.Text,"KR2ZH_CN")
    翻译类型="ZH_CN2KR"
    检测内容是否为空(rel,翻译类型)
   elseif a=="韩文" and b=="法文" then
    rel = 有道翻译(edit.Text,"KR2ZH_CN")
    翻译类型="ZH_CN2FR"
    检测内容是否为空(rel,翻译类型)
   elseif a=="韩文" and b=="俄文" then
    rel = 有道翻译(edit.Text,"KR2ZH_CN")
    翻译类型="ZH_CN2RU"
    检测内容是否为空(rel,翻译类型)
   elseif a=="韩文" and b=="西班牙文" then
    rel = 有道翻译(edit.Text,"KR2ZH_CN")
    翻译类型="ZH_CN2SP"
    检测内容是否为空(rel,翻译类型)


   elseif a=="法文" and b=="英文" then
    rel = 有道翻译(edit.Text,"FR2ZH_CN")
    翻译类型="ZH_CN2EN"
    检测内容是否为空(rel,翻译类型)
   elseif a=="法文" and b=="日文" then
    rel = 有道翻译(edit.Text,"FR2ZH_CN")
    翻译类型="ZH_CN2JA"
    检测内容是否为空(rel,翻译类型)
   elseif a=="法文" and b=="韩文" then
    rel = 有道翻译(edit.Text,"FR2ZH_CN")
    翻译类型="ZH_CN2KR"
    检测内容是否为空(rel,翻译类型)
   elseif a=="法文" and b=="法文" then
    rel = 有道翻译(edit.Text,"FR2ZH_CN")
    翻译类型="ZH_CN2FR"
    检测内容是否为空(rel,翻译类型)
   elseif a=="法文" and b=="俄文" then
    rel = 有道翻译(edit.Text,"FR2ZH_CN")
    翻译类型="ZH_CN2RU"
    检测内容是否为空(rel,翻译类型)
   elseif a=="法文" and b=="西班牙文" then
    rel = 有道翻译(edit.Text,"FR2ZH_CN")
    翻译类型="ZH_CN2SP"
    检测内容是否为空(rel,翻译类型)


   elseif a=="俄文" and b=="英文" then
    rel = 有道翻译(edit.Text,"RU2ZH_CN")
    翻译类型="ZH_CN2EN"
    检测内容是否为空(rel,翻译类型)
   elseif a=="俄文" and b=="日文" then
    rel = 有道翻译(edit.Text,"RU2ZH_CN")
    翻译类型="ZH_CN2JA"
    检测内容是否为空(rel,翻译类型)
   elseif a=="俄文" and b=="韩文" then
    rel = 有道翻译(edit.Text,"RU2ZH_CN")
    翻译类型="ZH_CN2KR"
    检测内容是否为空(rel,翻译类型)
   elseif a=="俄文" and b=="法文" then
    rel = 有道翻译(edit.Text,"RU2ZH_CN")
    翻译类型="ZH_CN2FR"
    检测内容是否为空(rel,翻译类型)
   elseif a=="俄文" and b=="俄文" then
    rel = 有道翻译(edit.Text,"RU2ZH_CN")
    翻译类型="ZH_CN2RU"
    检测内容是否为空(rel,翻译类型)
   elseif a=="俄文" and b=="西班牙文" then
    rel = 有道翻译(edit.Text,"RU2ZH_CN")
    翻译类型="ZH_CN2SP"
    检测内容是否为空(rel,翻译类型)

   elseif a=="西班牙文" and b=="英文" then
    rel = 有道翻译(edit.Text,"SP2ZH_CN")
    翻译类型="ZH_CN2EN"
    检测内容是否为空(rel,翻译类型)
   elseif a=="西班牙文" and b=="日文" then
    rel = 有道翻译(edit.Text,"SP2ZH_CN")
    翻译类型="ZH_CN2JA"
    检测内容是否为空(rel,翻译类型)
   elseif a=="西班牙文" and b=="韩文" then
    rel = 有道翻译(edit.Text,"SP2ZH_CN")
    翻译类型="ZH_CN2KR"
    检测内容是否为空(rel,翻译类型)
   elseif a=="西班牙文" and b=="法文" then
    rel = 有道翻译(edit.Text,"SP2ZH_CN")
    翻译类型="ZH_CN2FR"
    检测内容是否为空(rel,翻译类型)
   elseif a=="西班牙文" and b=="俄文" then
    rel = 有道翻译(edit.Text,"SP2ZH_CN")
    翻译类型="ZH_CN2RU"
    检测内容是否为空(rel,翻译类型)
   elseif a=="西班牙文" and b=="西班牙文" then
    rel = 有道翻译(edit.Text,"SP2ZH_CN")
    翻译类型="ZH_CN2SP"
    检测内容是否为空(rel,翻译类型)
  end
end


设置hint(edit,12,"在此输入要翻译的文本...")

edit.addTextChangedListener{
  onTextChanged=function(s)
    翻译()
  end
}




copy.onClick=function()
  复制文本(result.Text)
end


conversion.onClick=function()
  c=target.getText()
  d=source.getText()

  source.setText(c)
  target.setText(d)
  翻译()
end


share.onClick=function()
  分享文本(result.Text)
end

function ReadingAloud(str,Language)
  text=str


  speed=5

  --音调:tones范围(1-9)
  tones=4

  --音量:volume范围(1-9)
  volume=9

  --发音人:Pronunciation(0-6)
  Pronunciation=4

  --语言:
  --中文:  "zh"
  --英文:  "en"
  --日文:  "jp" 
  if Language=="en" or Language=="zh" or Language=="jp" then
  language=Language
  else
  language="en"
  end


  rel = "http://tts.baidu.com/text2audio?idx=1&tex="..text.."&cuid=baidu_speech_demo&cod=2&lan="..language.."&ctp=1&pdt=1&spd="..speed.."&vol="..volume.."&pit="..tones.."&per="..Pronunciation

  import "android.media.MediaPlayer"
  mediaPlayer = MediaPlayer()

  --初始化参数
  mediaPlayer.reset()

  --设置播放资源
  mediaPlayer.setDataSource(rel)

  --开始缓冲资源
  mediaPlayer.prepare()

  --是否循环播放该资源
  mediaPlayer.setLooping(false)


  mediaPlayer.start()
end


fullscreen.onClick=function()
  task(300,function()
    if result.Text~="" then
      ReadingAloud(result.Text,tostring(TranslationDatabase[target.Text]))
     else
      提示("空字符,朗读失败")
    end
  end)
end

source.onClick=function()
  name2=nil
  name2="Source"
  activity.newActivity("taoist_translation_source")
end


target.onClick=function()
  name2=nil
  name2="Target"
  activity.newActivity("taoist_translation_target")
end


function onResult(name,...)
  返回参数=...
  if name2=="Source" then
    source.setText(返回参数)
    翻译()
   elseif name2=="Target" then
    target.setText(返回参数)
    翻译()
  end
end


波纹(source,0x44000000)
原波纹(share,0x44000000)
波纹(target,0x44000000)
原波纹(conversion,0x44000000)
原波纹(copy,0x44000000)
原波纹(fullscreen,0x44000000)


通知栏颜色(returntheme())
