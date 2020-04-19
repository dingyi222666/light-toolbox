--[[
码上 project by Ayaka_Ago

Barcode Scanning by ZXing
https://github.com/zxing/zxing
]]

require "import"
import "mods.glob"
import "mods.func"
import "Pretend"
this.setContentView(loadlayout({
  LinearLayout,
  orientation="vertical",
  {
    RelativeLayout,
    layout_height="13%h",
    layout_width="fill",
    id="topBar",
    elevation="1%w",
    paddingTop=状态栏高度,
    backgroundColor=returntheme(),
    {
      ImageView,
      src="image/left.png",
      layout_alignParentLeft=true;
      layout_height="fill",
      layout_width="8.5%h",
      colorFilter=0xffffffff,
      onClick=function ()
        this.finish()
      end,
      BackgroundDrawable=转波纹色(0xffffffff),
      padding="4%w",
      id="back",
    },
    {
      TextView,
      id="title",
      text="开源许可",
      layout_toRightOf="back",
      gravity="left|center",
      textSize="18sp",
      layout_height="fill",
      textColor=0xffffffff,
    },
    {
      ImageView,
      layout_alignParentRight=true;
      layout_height="fill",
      layout_width="8.5%h",
      colorFilter=0xffffffff,
      padding="4%w",
    },
  },
  {
    ScrollView,
    padding="4%w",
    {
      LinearLayout,
      orientation="vertical",      
      {
        LinearLayout,
        orientation="vertical",
        layout_height="wrap",
        layout_width="fill",
        onClick=function ()
          浏览器打开网页("https://github.com/zxing/zxing")
        end,
        BackgroundDrawable=转波纹色(0xcb5B5B5B),
        paddingBottom="2%w",
        {
          RelativeLayout,
          padding="4%w",
          paddingLeft=0,
          layout_height="13%h",
          {
            LinearLayout,
            orientation="horizontal",
            layout_height="13%h",
            layout_width="fill",
            {
              CircleImageView,
              src="http://camo.githubusercontent.com/cd92fcc87ebc531c60edc667da4a77b90c004ff0/68747470733a2f2f7261772e6769746875622e636f6d2f77696b692f7a78696e672f7a78696e672f7a78696e672d6c6f676f2e706e67",
              layout_width="13%h",
              layout_height="fill",
            },
            {
              LinearLayout,
              orientation="vertical",
              layout_height="fill",
              gravity="center|left",
              {
                TextView,
                text="Barcode Scanning",
                textSize="18sp",
                textColor=0xff444444,
              },
              {
                TextView,
                paddingTop="1%w",
                text="ZXing",
              },
            },
          },
          {
            CircleImageView,
            layout_width="7%h",
            layout_height="fill",
            layout_alignParentRight=true,
          },
        },
        {
          TextView,
          textColor=0xff444444,
          textSize="15sp",
          padding="4%w",
          text=[[ZXing ("zebra crossing") is an open-source, multi-format 1D/2D barcode image processing library implemented in Java, with ports to other languages.]],
        },
        {
          LinearLayout,
          orientation="horizontal",
          layout_height="4%h",
          paddingRight="4%w",
          layout_gravity="right|center",
          {
            TextView,
            gravity="center",
            text="查看更多信息",
            textColor=returntheme(),
            textSize="14sp",
            id="bt2";
            paddingRight="1%w",
            layout_height="fill",
          },
          {
            ImageView,
            src="image/left.png",
            layout_height="fill",
            layout_width="4%h",
            padding="0.75%w",
            rotation=180,
            colorFilter=returntheme(),
          },
        },
      },

    },
  },--scrollview
}))


import "android.graphics.Paint"

bt2.getPaint().setFakeBoldText(true)