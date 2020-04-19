require "import"
import "mods.glob"
import "mods.func"
import "Pretend"
fea_list=pm.getSystemAvailableFeatures()

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
      text="系统 Features",
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
    TextView,
    id="perm_count",
    layout_width="fill",
    textSize="14sp",
    padding="2%w",
    paddingLeft="3.5%w",
  },
  {
    ListView,
    id="per_ls",
    layout_width="fill",
    fastScrollEnabled=true,
    VerticalScrollBarEnabled=false,
    dividerHeight=1,
  },
}))

perm_adp=LuaAdapter(activity,{},{
  TextView,
  id="p",
  padding="3.5%w",
  textSize="16sp",
  layout_width="fill",
  textColor=0xff444444,
})
for l=0,#fea_list-1 do
  perm_adp.add({p=fea_list[l].name})
end
perm_count.text="总共 "..perm_adp.getCount().." 个 Features"
per_ls.setAdapter(perm_adp)



per_ls.onItemLongClick=function(parent, view, position, id)
  写入剪贴板(view.Tag.p.Text)
  提示("已复制您长按选择的Features")
end