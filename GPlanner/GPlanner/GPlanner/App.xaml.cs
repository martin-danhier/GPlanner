using System;
using Microsoft.AppCenter;
using Microsoft.AppCenter.Analytics;
using Microsoft.AppCenter.Crashes;
using GPlanner.Views;
using Xamarin.Forms;

namespace GPlanner
{
	public partial class App : Application
	{
		public App ()
		{
			InitializeComponent();


            MainPage = new MainPage();
        }

		protected override void OnStart ()
		{
            AppCenter.Start("ios=d92c419e-fc3b-4f4d-b9a4-804fee99704c;android=cdbbd461-a25d-43c9-baf0-ecbbdf1b7d77;uwp=a4d5742f-ff03-42e8-8733-fb08bc2dce49", typeof(Analytics), typeof(Crashes));
        }

		protected override void OnSleep ()
		{
			// Handle when your app sleeps
		}

		protected override void OnResume ()
		{
			// Handle when your app resumes
		}
	}
}
