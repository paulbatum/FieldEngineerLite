// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------

using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;
using System.Web.Http.OData;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using FieldEngineerLite.Service.DataObjects;
using FieldEngineerLite.Service.Helpers;
using FieldEngineerLite.Service.Models;
using Microsoft.ServiceBus.Notifications;
using Microsoft.WindowsAzure.Mobile.Service;
using Microsoft.WindowsAzure.Mobile.Service.Security;
using Microsoft.WindowsAzure.Mobile.Service.Tables;

namespace AzureMobile.Samples.FieldEngineer.Service.Controllers
{
    //[AuthorizeLevel(AuthorizationLevel.User)]  
    [AuthorizeLevel(AuthorizationLevel.Anonymous)]  
    public class JobController : TableController<JobDTO>
    {      
        private ExistingDbContext context;        

        protected override void Initialize(HttpControllerContext controllerContext)
        {
            base.Initialize(controllerContext);
            this.context = new ExistingDbContext();
            
            this.DomainManager = new DefaultMappedEntityDomainManager<JobDTO,Job>(this.context, Request, Services);            
        }
        
        [ExpandProperty("Customer")]
        [ExpandProperty("Equipments")]
        public async Task<IQueryable<JobDTO>> GetAllJobs()
        {                        
            var jobs = this.context.Jobs
                .Include("Customer")
                .Include("Equipments")
                .Project().To<JobDTO>();            

            var aadObjectId = await this.GetAadObjectId();
            if(aadObjectId != null)
                jobs = jobs.Where(j => j.AgentId == aadObjectId);

            return jobs;
        }

        [ExpandProperty("Customer")]
        [ExpandProperty("Equipments")]
        public SingleResult<JobDTO> GetJob(string id)
        {
            return this.Lookup(id);
        }
        
        public async Task<JobDTO> PatchJob(string id, Delta<JobDTO> patch)
        {
            Job currentJob = this.context.Jobs.Find(id);

            currentJob.JobHistories.Add(new JobHistory
            {
                ActionBy = await this.GetAadObjectId(),
                Comments = "Job Updated",
                JobId = currentJob.Id,
                Id = Guid.NewGuid().ToString(),
                Job = currentJob,
                TimeStamp = DateTimeOffset.UtcNow,
            });            

            return await this.UpdateAsync(id, patch);                   
        }        
    }
}
