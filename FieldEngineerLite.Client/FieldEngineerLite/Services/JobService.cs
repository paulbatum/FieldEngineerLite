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
        private List<Job> jobs;

        public async Task InitializeAsync()
        {
            jobs = GetDummyData ();
            await Task.FromResult (0);
        }

        public async Task SyncAsync()
        {
            await Task.FromResult (0);
        }            

        public async Task<IEnumerable<Job>> SearchJobs(string searchInput)
        {
            IEnumerable<Job> items = this.jobs;           
            return await Task.FromResult(items);
        }

        public async Task CompleteJobAsync(Job job)
        {
            job.Status = Job.CompleteStatus;
            await Task.FromResult (0);
        }

        public async Task ClearAllJobs()
        {
            jobs = new List<Job> ();
        }

        private async Task<bool> IsAuthenticated()
        {
            return true;               
        }   

        private List<Job> GetDummyData()
        {
            return new List<Job> {
                new Job 
                { 
                    AgentId = "agent1",
                    Customer = new Customer { FullName = "Fake Customer" },
                    Equipments = new List<Equipment>
                    {
                        new Equipment { Name = "Some cable", ThumbImage = "Data/EquipmentImages/HDMI_1_Thumb.jpg" }
                    },
                    EtaTime = "08:30 - 09:30",
                    Id = "1",
                    JobNumber = "1",
                    Status = Job.InProgressStatus,
                    Title = "Go fix some broken thing"
                },
                new Job 
                { 
                    AgentId = "agent1", 
                    Customer = new Customer { FullName = "Another Pretend Customer" },
                    Equipments = new List<Equipment>
                    {
                        new Equipment { Name = "Some cable", ThumbImage = "Data/EquipmentImages/HDMI_1_Thumb.jpg" }
                    },
                    EtaTime = "10:30 - 11:30",
                    Id = "2",
                    JobNumber = "2",
                    Status = Job.PendingStatus,
                    Title = "Work work"
                },
                new Job 
                { 
                    AgentId = "agent1", 
                    Customer = new Customer { FullName = "John Smith" },
                    Equipments = new List<Equipment>
                    {
                        new Equipment { Name = "Some cable", ThumbImage = "Data/EquipmentImages/HDMI_1_Thumb.jpg" }
                    },
                    EtaTime = "11:30 - 12:30",
                    Id = "3",
                    JobNumber = "3",
                    Status = Job.CompleteStatus,
                    Title = "setup the new thing"
                }
            };
        }
    }
}

