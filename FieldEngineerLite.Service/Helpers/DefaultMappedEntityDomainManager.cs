using System.Data.Entity;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.OData;
using Microsoft.WindowsAzure.Mobile.Service;

namespace FieldEngineerLite.Service.Helpers
{
    public class DefaultMappedEntityDomainManager<TData, TModel>
            : MappedEntityDomainManager<TData, TModel>
        where TData : class, Microsoft.WindowsAzure.Mobile.Service.Tables.ITableData
        where TModel : class, Microsoft.WindowsAzure.Mobile.Service.Tables.ITableData
    {
        public DefaultMappedEntityDomainManager(DbContext context, HttpRequestMessage request, ApiServices services)
            : base(context, request, services)
        {            
        }

        public override Task<bool> DeleteAsync(string id)
        {
            return this.DeleteItemAsync(id);
        }

        public override Task<TData> UpdateAsync(string id, Delta<TData> patch)
        {
            return this.UpdateEntityAsync(patch, id);
        }

        public override SingleResult<TData> Lookup(string id)
        {
            return this.LookupEntity(model => model.Id == id);
        }

        protected override void SetOriginalVersion(TModel model, byte[] version)
        {            
            this.Context.Entry(model).OriginalValues["Version"] = version;
        }
    }
}
