// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
// This file reused from: https://code.msdn.microsoft.com/Field-Engineer-501df99d

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.WindowsAzure.Mobile.Service.Tables;

namespace FieldEngineerLite.Service.Models
{
    [Table("Job")]
    public class Job : ITableData
    {
        public Job()
        {
            this.JobHistories = new HashSet<JobHistory>();
            this.Equipments = new HashSet<Equipment>();
        }

        [StringLength(50)]
        public string CustomerId { get; set; }

        [StringLength(50)]
        public string AgentId { get; set; }

        public DateTimeOffset? EndTime { get; set; }

        [StringLength(50)]
        public string EtaTime { get; set; }

        [StringLength(50)]
        public string Id { get; set; }

        [StringLength(50)]
        public string JobNumber { get; set; }

        public DateTimeOffset? StartTime { get; set; }

        [StringLength(50)]
        public string Status { get; set; }

        [StringLength(50)]
        public string Title { get; set; }

        public Customer Customer { get; set; }

        public DateTimeOffset? CreatedAt { get; set; }
        
        public bool Deleted { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTimeOffset? UpdatedAt { get; set; }
        
        [Timestamp]
        public byte[] Version { get; set; }

        public ICollection<JobHistory> JobHistories { get; set; }

        public ICollection<Equipment> Equipments { get; set; }
    }
}
