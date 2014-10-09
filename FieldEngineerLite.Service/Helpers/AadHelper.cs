using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using Microsoft.WindowsAzure.Mobile.Service.Security;
using Microsoft.WindowsAzure.Mobile.Service.Tables;

namespace FieldEngineerLite.Service.Helpers
{
    public static class AadHelper
    {
        public static async Task<string> GetAadObjectId(this TableController controller)
        {
            ServiceUser mobileServiceUser = (ServiceUser)controller.User;
            controller.Services.Log.Info("User logged in: " + mobileServiceUser.Id);

            if (mobileServiceUser.Id == null)
                return null;

            var aadCreds = (await mobileServiceUser.GetIdentitiesAsync())
                .OfType<AzureActiveDirectoryCredentials>().FirstOrDefault();

            if (aadCreds == null)
                return null;

            controller.Services.Log.Info("Found user with objectId: " + aadCreds.ObjectId);

            return aadCreds.ObjectId;
        }
    }
}
