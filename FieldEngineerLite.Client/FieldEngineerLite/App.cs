using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using Xamarin.Forms;
using FieldEngineerLite.Views;

#if __IOS__
using UIContext = MonoTouch.UIKit.UIViewController;
#elif __ANDROID__
using UIContext = global::Android.Content.Context;
#endif

namespace FieldEngineerLite
{
    public class App
    {
        public static UIContext UIContext { get; set; }
        public static JobService JobService = new JobService();

        public static Page GetMainPage()
        {
            return new NavigationPage (new JobListPage ());
        }
    }

    public static class AppStyle
    {
		public static NamedSize DefaultFontSize =  Device.OnPlatform(
			iOS: NamedSize.Small,
			Android: NamedSize.Medium,
			WinPhone: NamedSize.Medium
		);

		public static Color DefaultActionColor = Device.OnPlatform(
			iOS: Color.Blue,
			Android: Color.Accent,
			WinPhone: Color.Accent
		);
			
        public static readonly Font DefaultFont = Device.OnPlatform(
            iOS: Font.OfSize("Avenir", DefaultFontSize),
            Android: Font.SystemFontOfSize(DefaultFontSize),
            WinPhone: Font.SystemFontOfSize(DefaultFontSize)
        );			
    }
}
