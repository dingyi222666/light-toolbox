import "android.view.animation.AnimationSet"
local array = activity.getTheme().obtainStyledAttributes({
  android.R.attr.colorBackground,
  android.R.attr.textColorPrimary,
  android.R.attr.colorPrimary,
  android.R.attr.colorPrimaryDark,
  android.R.attr.colorAccent,
  android.R.attr.navigationBarColor,
  android.R.attr.statusBarColor,
  android.R.attr.colorButtonNormal,
});

local colorBackground = array.getColor(0, 0xFF00FF)
local textColorPrimary = array.getColor(1, 0xFF00FF)
local colorPrimary = array.getColor(2, 0xFF00FF)
local colorPrimaryDark = array.getColor(3, 0xFF00FF)
local colorAccent = array.getColor(4, 0xFF00FF)
local navigationBarColor = array.getColor(5, 0xFF00FF)
local statusBarColor = array.getColor(6, 0xFF00FF)
local colorButtonNormal = array.getColor(7, 0xFF00FF)

强调色=蓝色
背景颜色=0xffffffff


function math.dp2px(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale + 0.5
end

function ButtonFrame(view,Thickness,FrameColor,InsideColor,radiu)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setStroke(Thickness, FrameColor)
  drawable.setColor(InsideColor)
  local radiu=radiu or 0
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  view.setBackgroundDrawable(drawable)
end


function isDarkColor(color)
  import 'java.lang.Long'
  local r=utf8.sub(color,3,4)
  local g=utf8.sub(color,5,6)
  local b=utf8.sub(color,7,8)
  local function toint(e)
    return Long.parseLong(e, 16)
  end
  return ((toint(r) * 0.299) + (toint(g) * 0.587) + (toint(b) * 0.114))<= 192
end

function MyEditText(info)
  info=info or {}
  if info=="getView" then
    local f={}
    function f.getEditTextView(id)
      return id.getChildAt(0).getChildAt(1).getChildAt(0)
    end
    function f.getHintView(id)
      return id.getChildAt(0).getChildAt(2).getChildAt(0)
    end
    return f
   else
    local lay=loadlayout{
      LinearLayout;
      --layout_width="fill";
      --layout_height="fill";
      {
        FrameLayout;
        layout_width="fill";
        layout_height="fill";
        {
          LinearLayout;
          layout_margin="8dp";
          layout_height="fill";
          layout_width="fill";
        };
        {
          LinearLayout;
          layout_height="fill";
          layout_width="fill";
          orientation="vertical";
          {
            EditText;
            layout_marginTop="10dp";
            layout_marginLeft="16dp";
            background="#00000000";
            layout_marginBottom="8dp";
            --layout_height="fill";
            layout_weight=1;
            layout_width="fill";
            textSize=info.textSize or "16dp";
            text=info.text or "";
            layout_marginRight="16dp";
            gravity="top|left";
          };
        };
        {
          LinearLayout;
          layout_marginLeft="16dp";
          layout_marginRight="16dp";
          backgroundColor=info.backgroundColor or 背景颜色;
          --layout_marginTop="8dp";
          --layout_marginBottom="8dp";
          layout_gravity="top|left";
          {
            TextView;
            layout_marginLeft="2dp";
            layout_marginRight="2dp";
            --layout_marginBottom="5dp";
            textSize="12dp";
            text=info.Hint or "";
          };
        };
      };
    }

    if info.id then
      _ENV[info.id]=lay
    end
    import "android.view.animation.ScaleAnimation"
    import "android.view.animation.TranslateAnimation"
    import "android.graphics.drawable.StateListDrawable"
    import "android.content.Context"

    local editH=math.dp2px(15)

    ButtonFrame(lay.getChildAt(0).getChildAt(0),math.dp2px(1),info.HintTextColor or (function() if isDarkColor(string.upper(Integer.toHexString(背景颜色))) then return 0xFFFFFFFF else return 0x70000000 end end)(),背景颜色,math.dp2px(8))
    MyEditText("getView").getHintView(lay).textColor=info.HintTextColor or (function() if isDarkColor(string.upper(Integer.toHexString(背景颜色))) then return 0xFFFFFFFF else return 0x70000000 end end)()
    local animationSet=AnimationSet(true)
    animationSet.addAnimation(TranslateAnimation(0,0,0,editH))
    animationSet.addAnimation(ScaleAnimation(1,16/12,1,16/12))
    lay.getChildAt(0).getChildAt(2).startAnimation(animationSet.setDuration(0).setFillAfter(true))

    MyEditText("getView").getEditTextView(lay).setOnFocusChangeListener{
      onFocusChange=function(view,hasFocus)
        if hasFocus then--判断焦点是否存在
          --焦点存在执行的事件
          ButtonFrame(lay.getChildAt(0).getChildAt(0),math.dp2px(2),info.HintTextColor or 强调色,info.backgroundColor or 背景颜色,math.dp2px(8))
          MyEditText("getView").getHintView(lay).textColor=info.HintTextColor or 强调色
          if view.text=="" then
            local animationSet=AnimationSet(true)
            animationSet.addAnimation(TranslateAnimation(0,0,editH,0))
            animationSet.addAnimation(ScaleAnimation(16/12,1,16/12,1))
            lay.getChildAt(0).getChildAt(2).startAnimation(animationSet.setDuration(100).setFillAfter(true))
          end
         else
          ButtonFrame(lay.getChildAt(0).getChildAt(0),math.dp2px(1),info.HintTextColor or (function() if isDarkColor(string.upper(Integer.toHexString(背景颜色))) then return 0xFFFFFFFF else return 0x70000000 end end)(),info.backgroundColor or 背景颜色,math.dp2px(8))
          MyEditText("getView").getHintView(lay).textColor=info.HintTextColor or (function() if isDarkColor(string.upper(Integer.toHexString(背景颜色))) then return 0xFFFFFFFF else return 0x70000000 end end)()
          if view.text=="" then
            local animationSet=AnimationSet(true)
            animationSet.addAnimation(TranslateAnimation(0,0,0,editH))
            animationSet.addAnimation(ScaleAnimation(1,16/12,1,16/12))
            lay.getChildAt(0).getChildAt(2).startAnimation(animationSet.setDuration(100).setFillAfter(true))
          end
        end
      end}
    if info.textColor then
      MyEditText("getView").getEditTextView(lay).textColor=info.textColor
    end
    if info.Hint then
      lay.getChildAt(0).getChildAt(2).setVisibility(View.VISIBLE)
     else
      lay.getChildAt(0).getChildAt(2).setVisibility(View.GONE)
    end



    MyEditText("getView").getEditTextView(lay).addTextChangedListener{
      onTextChanged=function(text,a,b)
        if #text==0 and not(MyEditText("getView").getEditTextView(lay).isFocused()) then
          local animationSet=AnimationSet(true)
          animationSet.addAnimation(TranslateAnimation(0,0,0,editH))
          animationSet.addAnimation(ScaleAnimation(1,16/12,1,16/12))
          lay.getChildAt(0).getChildAt(2).startAnimation(animationSet.setDuration(100).setFillAfter(true))
        end
        if a==0 and b==0 and not(MyEditText("getView").getEditTextView(lay).isFocused()) then
          local animationSet=AnimationSet(true)
          animationSet.addAnimation(TranslateAnimation(0,0,editH,0))
          animationSet.addAnimation(ScaleAnimation(16/12,1,16/12,1))
          lay.getChildAt(0).getChildAt(2).startAnimation(animationSet.setDuration(100).setFillAfter(true))
        end
      end
    }

    if MyEditText("getView").getEditTextView(lay).text~="" then
      local animationSet=AnimationSet(true)
      animationSet.addAnimation(TranslateAnimation(0,0,editH,0))
      animationSet.addAnimation(ScaleAnimation(16/12,1,16/12,1))
      lay.getChildAt(0).getChildAt(2).startAnimation(animationSet.setDuration(0).setFillAfter(true))
    end
    _G[info.id]=MyEditText("getView").getEditTextView(_G[info.id])
    return function() return lay end
  end
end


--[[
--属性配置
MyEditText({
  text="text";
  Hint="Hint";
  radius=20;
  textSize="5dp";
  HintTextColor=0xFF000000;
  textColor=0xFFFF0000;
  })

--获取ID
MyEditText("getView").getHintView(id)
MyEditText("getView").getEditTextView(id)


]]