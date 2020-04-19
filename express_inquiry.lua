require "import"
require "Pretend"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "mods.func"
import "mods.MyEditText"
activity.setContentView(loadlayout("layout/express_inquiry"))

通知栏颜色(returntheme())


cjson=import "cjson"


adp=LuaAdapter(activity, {
  LinearLayout,
  orientation = "horizontal",
  layout_width = "fill",
  layout_height = "wrap",
  {
    TextView,
    layout_width = "1dp",
    layout_height = "fill",
    background = "#FF7D7D7D",
    layout_marginLeft = "20dp"
  },
  {
    TextView,
    layout_width = "40dp",
    layout_height = "fill",
    gravity = "top|center",
    textColor = "#FF7D7D7D",
    layout_marginTop="5dp",--布局顶距
    layout_marginLeft = "-20.5dp",
    text = "●",
    textSize = "13sp"
  },
  {
    LinearLayout,
    orientation = "vertical",
    layout_width = "fill",
    layout_height = "wrap",
    {
      TextView,
      layout_width = "fill",
      layout_height = "wrap",
      layout_marginTop = "5dp",
      gravity = "left|center",
      textColor = "#FF000000",
      text = "",
      textSize = "15sp",
      layout_marginLeft = "5dp",
      id = "状态"
    },
    {
      TextView,
      layout_width = "fill",
      layout_height = "wrap",
      layout_marginTop = "5dp",
      gravity = "left|center",
      textColor = "#FF7D7D7D",
      text = "",
      textSize = "15sp",
      layout_marginLeft = "5dp",
      layout_marginBottom = "5dp",
      id = "时间"
    }
  }
})

lbx.adapter=adp


弹出输入法()


function ks.onClick()
  adp.clear()
  local number=zh1.getText()
  if #tostring(number)<1 then
    adp.add{状态="无",时间="无"}
   else
    layout=
    {
      LinearLayout;--线性布局
      orientation='vertical';--重力属性
      layout_width='fill';--布局宽度
      layout_height='fill';--布局高度
      background='#00000000';--布局背景颜色(或者图片路径)
      gravity='center';--默认居中
      {
        CardView;--卡片控件
        layout_margin='0dp';--卡片边距
        elevation='0dp';--阴影属性
        layout_width='150dp';--卡片宽度
        CardBackgroundColor='#FFFFFFFF';--卡片背景颜色
        layout_height='150dp';--卡片高度
        radius='15dp';--卡片圆角
        {
          LinearLayout;--线性布局
          orientation='vertical';--重力属性
          layout_width='fill';--布局宽度
          layout_height='fill';--布局高度
          gravity='center';--默认居中
          {
            LinearLayout;--线性布局
            orientation='vertical';--重力属性
            layout_width='fill';--布局宽度
            layout_height='fill';--布局高度
            gravity='center';--默认居中
            layout_marginBottom='20dp';--布局底距
            {
              ProgressBar;--默认圆圈
              id="进度条";
              --              gravity='center';--默认居中
            };
          };
          {
            TextView;--文本控件
            layout_width='fill';--文本宽度
            layout_height='50dp';--文本高度
            gravity='center';--重力属性
            textColor='#FF7D7D7D';--文字颜色
            text='正在加载中';--显示的文字
            textSize='15sp';--文字大小
            layout_marginTop='-50dp';--布局顶距
          };
        };
      };
    };
    对话框=Dialog(activity)--,R.Theme_AppLua_Dialog)--,R.style.BottomDialog)
    --设置弹窗布局
    对话框.setContentView(loadlayout(layout))
    对话框.getWindow().setBackgroundDrawableResource(android.R.color.transparent);

    --设置弹窗位置
    对话框.getWindow().setGravity(Gravity.CENTER)--默认底部 CENTER中 TOP顶
    --设置触摸弹窗外部隐藏弹窗
    对话框.setCanceledOnTouchOutside(false);
    --设置弹窗宽度
    对话框.getWindow().getAttributes().width =WindowManager.LayoutParams.MATCH_PARENT
    对话框.setCancelable(false)--注意放置位置,并不是什么地方都有效
    对话框.show()

    import "android.graphics.PorterDuffColorFilter"
    import "android.graphics.PorterDuff"
    进度条.IndeterminateDrawable.setColorFilter(PorterDuffColorFilter(returntheme(),PorterDuff.Mode.SRC_ATOP))

    查询(number)
  end
end

function 查询(number)
  if tostring(number) ~=nil then local url1="https://api.oioweb.cn/api/CheckExpress.php?postid="..tostring(number)
    Http.get(url1,nil,"utf8",nil,function(code,content)
   
        if code==200 then
              json=import "json"
              local con = json.decode(content)--json数据转表
              local mesg=con.data.messages      
                      if mesg~=nil then
                对话框.dismiss()
                  for k,v in ipairs(mesg) do
                    adp.add{状态=v.context,时间=v.time}
                end
               else
                adp.add{状态="无",时间="无"}
                对话框.dismiss()
            end
           else
            adp.add{状态="无",时间="无"}
            对话框.dismiss()
            end       
   
    end)
  end
end

