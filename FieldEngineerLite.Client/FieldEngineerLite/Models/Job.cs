using System;
using System.Collections.Generic;
using Microsoft.WindowsAzure.MobileServices;

namespace FieldEngineerLite.Models
{
    public class Job
    {
        public const string CompleteStatus = "Completed";
        public const string InProgressStatus = "On Site";
        public const string PendingStatus = "Not Started";

        public string Id { get; set; }
        public string AgentId { get; set; }
        public string JobNumber { get; set; }
        public string EtaTime { get; set; }
        public string Status { get; set; }
        public string Title { get; set; }

        public Customer Customer { get; set; }
        public List<Equipment> Equipments { get; set; }

        [Version]
        public string Version { get; set; }
    }
}
