# Field Engineer Lite #

Field Engineer Lite is a small Azure Mobile Services sample [presented at Xamarin Evolve 2014](https://www.youtube.com/watch?v=uYcM2DdZTmg&list=UUe-f02uZgEXdHmHpC3loAQg). It is based on Field Engineer, an official Mobile Services sample [available on MSDN code gallery](http://code.msdn.microsoft.com/windowsazure/Azure-Mobile-based-Field-ae27e666).

The sample consists of Xamarin.Forms based iOS and Android clients and a .NET server side project for publishing to Mobile Services.

![iOS Screenshot](/images/iOS_screenshot.png) ![Android Screenshot](/images/Android_screenshot.png)

## Client Setup ##
By default, when you run the client sample it will be configured to use an existing Mobile Service, but you can easily point it at your own mobile service by updating the `JobService.cs` file.

## Server Setup ##
You can run the .NET server project locally or by publishing it to a mobile service. See the `SQLDBSetup.sql` script for more information on setting up the database. 

##Supporting Videos##
[Xamarin Evolve 2014](https://www.youtube.com/watch?v=uYcM2DdZTmg&list=UUe-f02uZgEXdHmHpC3loAQg)

[TechEd Europe 2014, Session Number: DEV-B350](https://www.youtube.com/watch?v=M3bpREwZYXI)
