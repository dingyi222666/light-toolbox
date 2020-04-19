require "import"
import "mods.glob"
import "mods.func"
import "Pretend"

name=...
packinfo = pm.getPackageInfo(name, 64)

function onResume()
  if pcall(function ()
      --希哈与签名
      signInfo_area.getChildAt(3).text=getsha1(name)
      signInfo_area.getChildAt(1).text=packinfo.signatures[0].toCharsString()
      signInfo_area.getChildAt(5).text=getMd5(name)
    end) then else
    提示 ("签名信息加载失败，该应用可能已被卸载。")
    this.finish()
  end
end

this.setContentView(loadlayout (
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
    BackgroundColor=returntheme();
    {
      ImageView,
      src="image/left.png",
      onClick=function ()
        this.finish()
      end,
      foreground=转波纹色(0xffffffff),
      layout_height="fill",
      id="back",
      ColorFilter="#FFFFFFFF";
      layout_width="15%w",
      padding="4%w",
    },
    {
      TextView,
      id="title",
      text="签名信息",
      paddingRight="13%w",
      paddingLeft="3%w",
      layout_toRightOf="back";
      gravity="left|center",
      singleLine=true,
      ellipsize="end",
      textSize="18sp",
      layout_height="fill",
      layout_width="fill",
      textColor=0xffffffff,
    },
  },
  {
    ScrollView,
    {
      LinearLayout,
      orientation="vertical",
      id="signInfo_area",
      {
        TextView,
        textSize="14sp",
        padding="3.5%w",
        text="签名",
        paddingBottom=0,
      },
      {
        TextView,
        textSize="16sp",
        textColor=0xff444444,
        padding="3.5%w",
        textIsSelectable=true,
        OnLongClickListener={
          onLongClick=function(l,v)
          写入剪贴板(v.Text)
          提示("已复制")
        end,},
      },
      {
        TextView,
        textSize="14sp",
        padding="3.5%w",
        text="SHA1",
        paddingBottom=0,
      },
      {
        TextView,
        textSize="16sp",
        textColor=0xff444444,
        padding="3.5%w",
        textIsSelectable=true,
        OnLongClickListener={
          onLongClick=function(l,v)
          写入剪贴板(v.Text)
          提示("已复制")
        end,},
      },
      {
        TextView,
        textSize="14sp",
        padding="3.5%w",
        text="MD5",
        paddingBottom=0,
      },
      {
        TextView,
        textSize="16sp",
        textColor=0xff444444,
        padding="3.5%w",
        textIsSelectable=true,
        OnLongClickListener={
          onLongClick=function(l,v)
          写入剪贴板(v.Text)
          提示("已复制")
        end,},
      },
    },
  },
}))