package alihoseinpoor.com.toasty;

import android.content.Context;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.view.Gravity;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * ToastyPlugin
 */
public class ToastyPlugin implements MethodCallHandler {
    private Context context;

    private ToastyPlugin(Context context) {
        this.context = context;
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "toasty");
        channel.setMethodCallHandler(new ToastyPlugin(registrar.context()));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "showToast":
                String message = call.argument("message").toString();
                String length = call.argument("length").toString();
                String gravity = call.argument("gravity").toString();
                Number fontSize = call.argument("font_size");
                Number fontColor = call.argument("font_color");
                Number backColor = call.argument("back_color");

                Toast toast = Toast.makeText(context, message, length.equals("short") ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG);
                View view = toast.getView();
                TextView toastMessage = (TextView) view.findViewById(android.R.id.message);

                toastMessage.setText(message);
                toast.setView(view);

                switch (gravity) {
                    case "top":
                        toast.setGravity(Gravity.TOP, 0, 100);
                        break;
                    case "center":
                        toast.setGravity(Gravity.CENTER, 0, 0);
                        break;
                    default:
                        toast.setGravity(Gravity.BOTTOM, 0, 100);
                }

                Drawable shapeDrawable;
                shapeDrawable = context.getResources().getDrawable(R.drawable.toast_drawable);
                if (backColor != null && shapeDrawable != null) {
                    shapeDrawable.setColorFilter(backColor.intValue(), PorterDuff.Mode.SRC_IN);
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
                    view.setBackground(shapeDrawable);
                }

                toastMessage.setTextSize(fontSize.floatValue());
                toastMessage.setTextColor(fontColor.intValue());

                toast.show();
                break;
        }
    }
}
