using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;
using FieldEngineerLite.Helpers;
using FieldEngineerLite.Models;

namespace FieldEngineerLite.Views
{	
    public class JobDetailsPage : ContentPage
    {        
        public JobDetailsPage()
        {
            TableSection mainSection = new TableSection();     
            
            mainSection.Add(new DataElementCell("Title", "Description"));
            mainSection.Add(new DataElementCell("Customer.FullName", "Customer"));
            mainSection.Add(new DataElementCell("Customer.Address", "Address") { Height = 60 });
            mainSection.Add(new DataElementCell("Customer.PrimaryContactNumber", "Telephone"));

            var statusCell = new DataElementCell("Status");
            statusCell.ValueLabel.SetBinding<Job>(Label.TextColorProperty, job => job.Status, converter: new JobStatusToColorConverter());
            mainSection.Add(statusCell);

            var equipmentSection = new TableSection("Equipment");            
            var equipmentRowTemplate = new DataTemplate(typeof(ImageCell));            
            equipmentRowTemplate.SetBinding(ImageCell.TextProperty, "Name");
            equipmentRowTemplate.SetBinding(ImageCell.DetailProperty, "Description");

			// I don't have images working on Android yet
			if (Device.OS == TargetPlatform.iOS) 			
				equipmentRowTemplate.SetBinding (ImageCell.ImageSourceProperty, "ThumbImage");

            var equipmentListView = new ListView {
                RowHeight = 50,
                ItemTemplate = equipmentRowTemplate
            };
            equipmentListView.SetBinding<Job>(ListView.ItemsSourceProperty, job => job.Equipments);            

            var equipmentCell = new ViewCell { View = equipmentListView };            
            equipmentSection.Add(equipmentCell);

            var actionsSection = new TableSection("Actions");
            
            TextCell completeJob = new TextCell { 
                Text = "Mark Job as Complete",
				TextColor = AppStyle.DefaultActionColor
            };            
            completeJob.Tapped += async delegate {
                await this.CompleteJobAsync();
            };
            actionsSection.Add(completeJob);
            
            var table = new TableView
            {
                Intent = TableIntent.Form,
                VerticalOptions = LayoutOptions.FillAndExpand,
                HasUnevenRows = true,
                Root = new TableRoot("Root")
                {
                    mainSection, actionsSection, equipmentSection
                }
            };
            table.SetBinding<Job>(TableView.BackgroundColorProperty, job => job.Status, converter: new JobStatusToColorConverter(useLightTheme: true));
            
            this.Title = "Job Details";
            this.Content = new StackLayout
            {
                Orientation = StackOrientation.Vertical,
                Children = { new JobHeaderView(), table }
            };

            this.BindingContextChanged += delegate
            {
                if (SelectedJob != null && SelectedJob.Equipments != null)
                    equipmentCell.Height = SelectedJob.Equipments.Count * equipmentListView.RowHeight;
            };
        }

        private Job SelectedJob
        {
            get { return this.BindingContext as Job; }
        }

        private async Task CompleteJobAsync()
        {
            var job = this.SelectedJob;
            await App.JobService.CompleteJobAsync (job);

            // Force a refresh
            this.BindingContext = null;
            this.BindingContext = job;
        }

        private class DataElementCell : ViewCell
        {
            public Label DescriptionLabel { get; set; }
            public Label ValueLabel { get; set; }

            public DataElementCell(string property, string propertyDescription = null)
            {
                DescriptionLabel = new Label {
                    Text = propertyDescription ?? property,
                    Font = AppStyle.DefaultFont.WithAttributes(FontAttributes.Bold),
                    WidthRequest = 150,
                    VerticalOptions = LayoutOptions.CenterAndExpand                
                };

                ValueLabel = new Label {
                    Font = AppStyle.DefaultFont,
                    HorizontalOptions = LayoutOptions.FillAndExpand,
                    VerticalOptions = LayoutOptions.CenterAndExpand,
                    XAlign = TextAlignment.End
                };
                ValueLabel.SetBinding(Label.TextProperty, property);

                this.View = new StackLayout
                {
                    Orientation = StackOrientation.Horizontal,
                    Padding = 10,
                    Children = { DescriptionLabel, ValueLabel }
                };
            }
        }   
    }
}
