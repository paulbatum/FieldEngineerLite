using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.WindowsAzure.MobileServices;
using Microsoft.WindowsAzure.MobileServices.SQLiteStore;
using Microsoft.WindowsAzure.MobileServices.Sync;
using FieldEngineerLite.Helpers;
using FieldEngineerLite.Models;
using System.Threading;

namespace FieldEngineerLite
{
    public class JobService
    {
        private MobileServiceClient MobileService = new MobileServiceClient(
            "https://pbevolvewest.azure-mobile.net/",
            "",
            new LoggingHandler()
        );

        private IMobileServiceSyncTable<Job> jobTable;

        public async Task InitializeAsync()
        {
            var store = new MobileServiceSQLiteStoreWithLogging("localdata.db");
            store.DefineTable<Job> ();
            await this.MobileService.SyncContext.InitializeAsync(store);

            jobTable = this.MobileService.GetSyncTable<Job>();
        }

        public async Task SyncAsync()
        {
            // Comment this back in if you want auth
            //if (!await IsAuthenticated())
            //    return;

            await this.MobileService.SyncContext.PushAsync();

            var query = jobTable.CreateQuery()
                .Where(job => job.AgentId == "37e865e8-38f1-4e6b-a8ee-b404a188676e")
                ;

            await jobTable.PullAsync("myjobs", query);
        }            

        public async Task<IEnumerable<Job>> SearchJobs(string searchInput)
        {
            var query = jobTable.CreateQuery ();
                
            if (!string.IsNullOrWhiteSpace(searchInput)) {
                query = query.Where (job => 
                    job.JobNumber == searchInput
                    || searchInput.ToUpper().Contains(job.Title.ToUpper()) // workaround bug: these are backwards
                    || searchInput.ToUpper().Contains(job.Status.ToUpper())
                );
            }

            return await query.ToEnumerableAsync();
        }

        public async Task CompleteJobAsync(Job job)
        {
            job.Status = Job.CompleteStatus;
            await jobTable.UpdateAsync(job);

            var inprogress = await jobTable
                .Where(j => j.Status == Job.InProgressStatus)
                .Take(1)
                .ToListAsync();

            if(inprogress.Count == 0)
            {
                var nextJob = (await jobTable
                    .Where(j => j.Status == Job.PendingStatus)
                    .Take(1)
                    .ToListAsync()
                ).FirstOrDefault();

                if (nextJob != null)
                {
                    nextJob.Status = Job.InProgressStatus;
                    await jobTable.UpdateAsync(nextJob);
                }
            }
        }

        public async Task ClearAllJobs()
        {
            await jobTable.PurgeAsync ("myjobs", jobTable.CreateQuery(), CancellationToken.None);
            await InitializeAsync ();
        }

        private async Task<bool> IsAuthenticated()
        {
            if(this.MobileService.CurrentUser == null)
            {
                await this.MobileService.LoginAsync(App.UIContext, MobileServiceAuthenticationProvider.WindowsAzureActiveDirectory);
            }

            return this.MobileService.CurrentUser != null;                
        }
    }
}

