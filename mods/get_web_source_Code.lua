require "import"
import "android.widget.*"
import "android.view.*"




function getHtml(url,回调)

  --浏览器对话框
  layoutdig={
    LinearLayout;
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LuaWebView;
      --layout_width="fill";
      id="gh";
      layout_weight="fill";
      layout_height="fill";
    };
  };

  对话框=AlertDialog.Builder(this)
  .setTitle("对话框")
  .setView(loadlayout(layoutdig))
  gh.getSettings().setJavaScriptEnabled(true)--设置支持JS
  gh.loadUrl(tostring(url))--加载网页
  gh.setWebViewClient{
    shouldOverrideUrlLoading=function(view,url)
      --Url即将跳转
    end,
    onPageStarted=function(view,url,favicon)
      --网页加载时

    end,
    onPageFinished=function(view,url)
      --网页加载完成
      gh.evaluateJavascript("function getSource(){return \"<html>\"+document.getElementsByTagName('html')[0].innerHTML+\"</html>\";};getSource();",{
        onReceiveValue=function(result)
          -- %转换为%;再转换回%，是为了将\\n转换为%n，而这是为了让\\n能够正常转换为\n而不是\。
          result=result:gsub("%%","%%;"):gsub("\\\\n","%%n"):gsub("\\n","\n"):gsub("%%n","\\n"):gsub("%%;","%%"):gsub("\\u003C","<"):gsub("\\\"","\""):gsub("^\"",""):gsub("\"$","")
          回调(result)
        end

      })
    end}
end