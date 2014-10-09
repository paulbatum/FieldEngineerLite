using System;
using System.Collections.Generic;
using System.Text;
using Xamarin.Forms;
using FieldEngineerLite.Helpers;
using FieldEngineerLite.Models;

namespace FieldEngineerLite
{
    public class JobHeaderView : ContentView
    {
        public JobHeaderView()
        {
            var number = new Label();
            number.TextColor = Color.White;
            number.WidthRequest = 30;
            number.Font = AppStyle.DefaultFont.WithSize(NamedSize.Large).WithAttributes(FontAttributes.Bold);
            number.SetBinding<Job>(Label.TextProperty, job => job.JobNumber);

            var eta = new Label();
            eta.VerticalOptions = LayoutOptions.FillAndExpand;
            eta.HorizontalOptions = LayoutOptions.FillAndExpand;
            eta.YAlign = TextAlignment.Center;
            eta.TextColor = Color.White;
            eta.Font = AppStyle.DefaultFont;
            eta.SetBinding<Job>(Label.TextProperty, job => job.EtaTime);

            var rootLayout = new StackLayout
            {
                Orientation = StackOrientation.Horizontal,
                Padding = 5,
                Children = { number, eta }
            };
            rootLayout.SetBinding<Job>(StackLayout.BackgroundColorProperty, job => job.Status, converter: new JobStatusToColorConverter());

            this.Content = rootLayout;
        }
    }
}

