package alihoseinpoor.com.toasty;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;
import java.util.Objects;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * ToastyPlugin
 */
public class ToastyPlugin  implements MethodCallHandler {
    private Context context;
    private Toast toast;
    private View view;

    @SuppressLint("InflateParams")
    private ToastyPlugin(Context context) {
        this.context = context;
        toast = new Toast(context);
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        if (inflater != null) {
            this.view = inflater.inflate(R.layout.toast_layout, null);
        }
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "toasty");
        channel.setMethodCallHandler(new ToastyPlugin(registrar.context()));
    }

    private static void setIcon(View view, int id) {
        if (view != null) {
            ImageView imageView = (ImageView) view.findViewById(R.id.toastIcon);
            imageView.setImageResource(id);
        }
    }

    private static void setIconColor(View view, int color) {
        if (view != null) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.FROYO) {
                ImageView imageView = (ImageView) view.findViewById(R.id.toastIcon);
                imageView.setColorFilter(color);
            }
        }
    }

    private static void setIconSize(View view, Number iconSize, Context context) {
        if (view != null) {
            if (iconSize != null) {
                int dpIconSize = Math.round(TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, iconSize.intValue(), context.getResources().getDisplayMetrics()));
                ImageView imageView = (ImageView) view.findViewById(R.id.toastIcon);
                imageView.getLayoutParams().height = dpIconSize;
                imageView.getLayoutParams().width = dpIconSize;
            }
        }
    }

    private static void setToastLength(Toast toasty, String length) {
        toasty.setDuration(length.equals("short") ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG);
    }

    private static void setToastGravity(Toast toast, String gravity) {
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
    }

    private static View getToastView(Toast toast) {
        return (toast == null) ? null : toast.getView();

    }

    private static void setToastView(View view, Toast toast) {
        toast.setView(view);
    }

    private static void setToastText(Toast toast, String text, View view, int id) {
        if (toast != null && view != null) {
            TextView toastMessage = (TextView) view.findViewById(id);
            toastMessage.setText(text);
        }
    }

    private static void setToastMessageSize(View view, float size, int id) {
        if (view != null) {
            TextView toastMessage = (TextView) view.findViewById(id);
            toastMessage.setTextSize(size);
        }
    }

    private static void setToastMessageColor(View view, int color, int id) {
        if (view != null) {
            TextView toastMessage = (TextView) view.findViewById(id);
            toastMessage.setTextColor(color);
        }
    }

    private static void setToastDrawable(View view, Number color, Context context, boolean customToast, int id) {
        Drawable shapeDrawable;
        shapeDrawable = context.getResources().getDrawable(id);
        if (customToast) {
            if (color != null && shapeDrawable != null) {
                shapeDrawable.setColorFilter(color.intValue(), PorterDuff.Mode.SRC_IN);
            }
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
            view.setBackground(shapeDrawable);
        }
    }

    private static void createTypedToast(MethodCall call, View view, Toast toast, Context context, int drawabl, int icon) {
        String message = Objects.requireNonNull(call.argument("message")).toString();
        String length = Objects.requireNonNull(call.argument("length")).toString();
        String gravity = Objects.requireNonNull(call.argument("gravity")).toString();
        Number fontSize = call.argument("font_size");
        Number fontColor = call.argument("font_color");
        Number iconColor = call.argument("icon_color");
        Number iconSize = call.argument("icon_size");

        ToastyPlugin.setToastView(view, toast);
        ToastyPlugin.setToastLength(toast, length);
        ToastyPlugin.setToastGravity(toast, gravity);

        if (view != null) {
            ToastyPlugin.setToastText(toast, message, view, R.id.toastMessage);
            if (fontSize != null) {
                ToastyPlugin.setToastMessageSize(view, fontSize.floatValue(), R.id.toastMessage);
            }
            if (fontColor != null) {
                ToastyPlugin.setToastMessageColor(view, fontColor.intValue(), R.id.toastMessage);
            }
            ToastyPlugin.setIcon(view, icon);
            if (iconColor != null) {
                ToastyPlugin.setIconColor(view, iconColor.intValue());
            }
            ToastyPlugin.setIconSize(view, iconSize, context);
            ToastyPlugin.setToastDrawable(view, null, context, false, drawabl);
        }

        toast.show();
    }


    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "showToast": {
                String message = Objects.requireNonNull(call.argument("message")).toString();
                String length = Objects.requireNonNull(call.argument("length")).toString();
                String gravity = Objects.requireNonNull(call.argument("gravity")).toString();
                Number fontSize = call.argument("font_size");
                Number fontColor = call.argument("font_color");
                Number backColor = call.argument("back_color");

                toast = Toast.makeText(context, message, length.equals("short") ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG);
                View toastView = ToastyPlugin.getToastView(toast);

                if (toastView != null) {
                    ToastyPlugin.setToastText(toast, message, toastView, android.R.id.message);
                    ToastyPlugin.setToastView(toastView, toast);
                    ToastyPlugin.setToastGravity(toast, gravity);
                    ToastyPlugin.setToastDrawable(toastView, backColor, context, true, R.drawable.toast_drawable);
                    if (fontSize != null) {
                        ToastyPlugin.setToastMessageSize(toastView, fontSize.floatValue(), android.R.id.message);
                    }
                    if (fontColor != null) {
                        ToastyPlugin.setToastMessageColor(toastView, fontColor.intValue(), android.R.id.message);
                    }
                }
                toast.show();
                break;
            }

            case "cancel":
                if (toast != null) {
                    toast.cancel();
                }
                break;

            case "successToast":
                ToastyPlugin.createTypedToast(call, view, toast, context, R.drawable.toast_drawable_success, R.drawable.success);
                break;

            case "errorToast":
                ToastyPlugin.createTypedToast(call, view, toast, context, R.drawable.toast_drawable_error, R.drawable.error);
                break;

            case "warningToast":
                ToastyPlugin.createTypedToast(call, view, toast, context, R.drawable.toast_drawable_warning, R.drawable.warning);
                break;
        }
    }
}
